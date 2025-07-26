-- Migration to fix remaining security warnings
-- 1. Fix Security Definer View
-- 2. Fix Function Search Path warnings

-- ========================================
-- 1. Fix Security Definer View
-- ========================================
-- Recreate the view with SECURITY INVOKER instead of SECURITY DEFINER
DROP VIEW IF EXISTS public.outstanding_partner_billings;

CREATE VIEW public.outstanding_partner_billings WITH (security_invoker = true) AS
SELECT pb.id,
    pb.partner_billing_id_display,
    p.partner_name,
    s.site_name,
    vi.vendor_invoice_id_display AS vendor_invoice_number,
    vi.invoice_date,
    pb.status,
    pb.total_amount,
    pb.payment_due_date,
    CASE
        WHEN pb.payment_due_date < CURRENT_DATE AND (pb.status::text = ANY (ARRAY['Pending'::character varying::text, 'Sent'::character varying::text])) THEN true
        ELSE false
    END AS is_overdue,
    CASE
        WHEN pb.payment_due_date < CURRENT_DATE AND (pb.status::text = ANY (ARRAY['Pending'::character varying::text, 'Sent'::character varying::text])) THEN CURRENT_DATE - pb.payment_due_date
        ELSE 0
    END AS days_overdue
FROM partner_billings pb
    JOIN partners p ON pb.partner_id = p.id
    JOIN vendor_invoices vi ON pb.vendor_invoice_id = vi.id
    JOIN sites s ON vi.site_id = s.id
WHERE pb.status::text = ANY (ARRAY['Pending'::character varying::text, 'Sent'::character varying::text, 'Overdue'::character varying::text])
ORDER BY (
    CASE
        WHEN pb.payment_due_date < CURRENT_DATE AND (pb.status::text = ANY (ARRAY['Pending'::character varying::text, 'Sent'::character varying::text])) THEN true
        ELSE false
    END) DESC, (
    CASE
        WHEN pb.payment_due_date < CURRENT_DATE AND (pb.status::text = ANY (ARRAY['Pending'::character varying::text, 'Sent'::character varying::text])) THEN CURRENT_DATE - pb.payment_due_date
        ELSE 0
    END) DESC, pb.payment_due_date;

-- Grant permissions on the view
GRANT SELECT ON public.outstanding_partner_billings TO anon;
GRANT SELECT ON public.outstanding_partner_billings TO authenticated;
GRANT ALL ON public.outstanding_partner_billings TO service_role;

-- ========================================
-- 2. Fix Function Search Path warnings
-- ========================================
-- Update all functions to have explicit search_path set to 'public'

-- update_last_accessed_at
CREATE OR REPLACE FUNCTION public.update_last_accessed_at()
RETURNS TRIGGER 
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
    UPDATE brain_bot_documents 
    SET last_accessed_at = NOW() 
    WHERE id = NEW.document_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- update_updated_at_column
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER 
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- handle_updated_at
CREATE OR REPLACE FUNCTION public.handle_updated_at()
RETURNS TRIGGER 
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- is_admin
CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS BOOLEAN 
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
    RETURN EXISTS (
        SELECT 1 
        FROM user_profiles 
        WHERE user_id = auth.uid() 
        AND role = 'admin'
    );
END;
$$ LANGUAGE plpgsql;

-- check_email_domain
CREATE OR REPLACE FUNCTION public.check_email_domain()
RETURNS TRIGGER 
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
    -- Add your email domain check logic here
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- handle_new_user
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER 
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
    INSERT INTO public.user_profiles (user_id, email)
    VALUES (NEW.id, NEW.email);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- is_admin_no_rls
CREATE OR REPLACE FUNCTION public.is_admin_no_rls()
RETURNS BOOLEAN 
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
    RETURN EXISTS (
        SELECT 1 
        FROM user_profiles 
        WHERE user_id = auth.uid() 
        AND role = 'admin'
    );
END;
$$ LANGUAGE plpgsql;

-- get_partner_financial_summary
CREATE OR REPLACE FUNCTION public.get_partner_financial_summary(partner_uuid uuid)
RETURNS TABLE(total_invoices bigint, total_original_amount numeric, total_markup_amount numeric, total_final_amount numeric, outstanding_invoices bigint, outstanding_amount numeric, paid_invoices bigint, paid_amount numeric)
SECURITY DEFINER
SET search_path = public
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        COUNT(pb.id) AS total_invoices,
        SUM(pb.original_amount) AS total_original_amount,
        SUM(pb.markup_amount) AS total_markup_amount,
        SUM(pb.total_amount) AS total_final_amount,
        COUNT(CASE WHEN pb.status != 'Paid' THEN 1 END) AS outstanding_invoices,
        SUM(CASE WHEN pb.status != 'Paid' THEN pb.total_amount ELSE 0 END) AS outstanding_amount,
        COUNT(CASE WHEN pb.status = 'Paid' THEN 1 END) AS paid_invoices,
        SUM(CASE WHEN pb.status = 'Paid' THEN pb.total_amount ELSE 0 END) AS paid_amount
    FROM 
        partner_billings pb
    WHERE 
        pb.partner_id = partner_uuid;
END;
$$;

-- get_site_financial_summary
CREATE OR REPLACE FUNCTION public.get_site_financial_summary(site_uuid uuid)
RETURNS TABLE(total_invoices bigint, total_original_amount numeric, total_markup_amount numeric, total_final_amount numeric, average_markup_percentage numeric)
SECURITY DEFINER
SET search_path = public
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        COUNT(vi.id) AS total_invoices,
        SUM(vi.original_amount) AS total_original_amount,
        SUM(vi.markup_amount) AS total_markup_amount,
        SUM(vi.final_amount) AS total_final_amount,
        CASE 
            WHEN SUM(vi.original_amount) > 0 
            THEN ROUND(SUM(vi.markup_amount) * 100.0 / SUM(vi.original_amount), 2)
            ELSE 0
        END AS average_markup_percentage
    FROM 
        vendor_invoices vi
    WHERE 
        vi.site_id = site_uuid;
END;
$$;

-- recalculate_all_markups
CREATE OR REPLACE FUNCTION public.recalculate_all_markups()
RETURNS integer
SECURITY DEFINER
SET search_path = public
LANGUAGE plpgsql
AS $$
DECLARE
    invoice_record RECORD;
    count_updated INTEGER := 0;
BEGIN
    FOR invoice_record IN
        SELECT id
        FROM vendor_invoices
        WHERE status NOT IN ('Paid', 'Rejected')
    LOOP
        PERFORM calculate_invoice_markup(invoice_record.id);
        PERFORM create_partner_billing(invoice_record.id);
        count_updated := count_updated + 1;
    END LOOP;
    
    RETURN count_updated;
END;
$$;

-- update_billing_after_invoice_change
CREATE OR REPLACE FUNCTION public.update_billing_after_invoice_change()
RETURNS trigger
SECURITY DEFINER
SET search_path = public
LANGUAGE plpgsql
AS $$
BEGIN
    -- If this is a new record or partner_id is changed, calculate markup
    IF (TG_OP = 'INSERT') OR (OLD.partner_id IS DISTINCT FROM NEW.partner_id) OR
       (OLD.original_amount IS DISTINCT FROM NEW.original_amount) THEN
        PERFORM calculate_invoice_markup(NEW.id);
    END IF;
    
    -- Create or update the corresponding partner billing
    PERFORM create_partner_billing(NEW.id);
    
    RETURN NEW;
END;
$$;

-- calculate_invoice_markup
CREATE OR REPLACE FUNCTION public.calculate_invoice_markup(invoice_uuid uuid)
RETURNS void
SECURITY DEFINER
SET search_path = public
LANGUAGE plpgsql
AS $$
DECLARE
    invoice_record RECORD;
    markup_pct DECIMAL(5,2);
BEGIN
    -- Get the invoice record
    SELECT * INTO invoice_record
    FROM vendor_invoices
    WHERE id = invoice_uuid;
    
    -- If no partner is set, we can't calculate markup
    IF invoice_record.partner_id IS NULL THEN
        RETURN;
    END IF;
    
    -- Get the markup percentage for this site-partner combination
    SELECT spa.markup_percentage INTO markup_pct
    FROM site_partner_assignments spa
    WHERE spa.site_id = invoice_record.site_id
    AND spa.partner_id = invoice_record.partner_id;
    
    -- If no markup percentage is found, use 0
    IF markup_pct IS NULL THEN
        markup_pct := 0;
    END IF;
    
    -- Update the invoice with the calculated values
    UPDATE vendor_invoices
    SET markup_percentage = markup_pct,
        markup_amount = ROUND(original_amount * markup_pct / 100, 2),
        final_amount = original_amount + ROUND(original_amount * markup_pct / 100, 2),
        updated_at = NOW()
    WHERE id = invoice_uuid;
END;
$$;

-- create_partner_billing
CREATE OR REPLACE FUNCTION public.create_partner_billing(invoice_uuid uuid)
RETURNS void
SECURITY DEFINER
SET search_path = public
LANGUAGE plpgsql
AS $$
DECLARE
    invoice_record RECORD;
    billing_id_display VARCHAR(50);
    existing_billing_count INTEGER;
BEGIN
    -- Check if billing already exists for this invoice
    SELECT COUNT(*) INTO existing_billing_count
    FROM partner_billings
    WHERE vendor_invoice_id = invoice_uuid;
    
    IF existing_billing_count > 0 THEN
        -- Billing already exists, update it instead
        UPDATE partner_billings
        SET partner_id = vi.partner_id,
            billing_date = CURRENT_DATE,
            status = 
                CASE 
                    WHEN partner_billings.status = 'Paid' THEN 'Paid' -- Don't change paid status
                    ELSE 'Pending' -- Reset to pending if it wasn't paid
                END,
            original_amount = vi.original_amount,
            markup_amount = COALESCE(vi.markup_amount, 0),
            total_amount = COALESCE(vi.final_amount, vi.original_amount),
            payment_due_date = vi.due_date,
            updated_at = NOW()
        FROM vendor_invoices vi
        WHERE partner_billings.vendor_invoice_id = invoice_uuid
        AND vi.id = invoice_uuid;
    ELSE
        -- Get invoice details
        SELECT * INTO invoice_record
        FROM vendor_invoices
        WHERE id = invoice_uuid;
        
        -- Only create billing if partner is set and markup is calculated
        IF invoice_record.partner_id IS NOT NULL THEN
            -- Generate billing_id_display
            billing_id_display := 'PB-' || TO_CHAR(NOW(), 'YYYYMMDD') || '-' || 
                                 LPAD(CAST((SELECT COUNT(*) + 1 FROM partner_billings) AS TEXT), 3, '0');
            
            -- Create new partner billing record
            INSERT INTO partner_billings (
                partner_billing_id_display,
                partner_id,
                vendor_invoice_id,
                billing_date,
                status,
                original_amount,
                markup_amount,
                total_amount,
                payment_due_date
            ) VALUES (
                billing_id_display,
                invoice_record.partner_id,
                invoice_uuid,
                CURRENT_DATE,
                'Pending',
                invoice_record.original_amount,
                COALESCE(invoice_record.markup_amount, 0),
                COALESCE(invoice_record.final_amount, invoice_record.original_amount),
                invoice_record.due_date
            );
        END IF;
    END IF;
END;
$$;

-- update_invoices_after_assignment_change
CREATE OR REPLACE FUNCTION public.update_invoices_after_assignment_change()
RETURNS trigger
SECURITY DEFINER
SET search_path = public
LANGUAGE plpgsql
AS $$
DECLARE
    invoice_record RECORD;
BEGIN
    -- If markup percentage changed, update related invoices
    IF OLD.markup_percentage IS DISTINCT FROM NEW.markup_percentage THEN
        -- Log the change for auditing purposes
        INSERT INTO markup_changes_log (
            site_id,
            partner_id,
            old_markup_percentage,
            new_markup_percentage,
            changed_by
        ) VALUES (
            NEW.site_id,
            NEW.partner_id,
            OLD.markup_percentage,
            NEW.markup_percentage,
            auth.uid()
        );
        
        -- Update all invoices affected by this markup change
        FOR invoice_record IN
            SELECT id
            FROM vendor_invoices
            WHERE site_id = NEW.site_id
            AND partner_id = NEW.partner_id
            -- Only update non-finalized invoices
            AND status NOT IN ('Paid', 'Rejected')
        LOOP
            -- Recalculate markup and update billing
            PERFORM calculate_invoice_markup(invoice_record.id);
            PERFORM create_partner_billing(invoice_record.id);
        END LOOP;
    END IF;
    
    RETURN NEW;
END;
$$;

-- ========================================
-- 3. Fix Auth Configuration (Manual steps required)
-- ========================================
-- The following need to be fixed in the Supabase dashboard:
-- 1. Auth > Settings > OTP expiry: Set to less than 3600 seconds (1 hour)
-- 2. Auth > Settings > Security: Enable "Leaked password protection"