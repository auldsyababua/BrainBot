-- Insert Partners (from QuickBooks customers)

INSERT INTO public.partners (
    partner_id_display, partner_name, partner_type, 
    primary_contact_name, primary_contact_email, is_active
) VALUES (
    'PART-001', 'Flober LLC', 'Investor',
    'Bernardo Nonna',
    'bernardo@bigsur.energy, ariel@bigsur.energy',
    true
) ON CONFLICT (partner_name) DO NOTHING;
INSERT INTO public.partners (
    partner_id_display, partner_name, partner_type, 
    primary_contact_name, primary_contact_email, is_active
) VALUES (
    'PART-002', 'Malama Energy', 'Investor',
    'Steve Hansen',
    NULL,
    true
) ON CONFLICT (partner_name) DO NOTHING;
INSERT INTO public.partners (
    partner_id_display, partner_name, partner_type, 
    primary_contact_name, primary_contact_email, is_active
) VALUES (
    'PART-003', 'Operation Orange', 'Investor',
    NULL,
    NULL,
    true
) ON CONFLICT (partner_name) DO NOTHING;
INSERT INTO public.partners (
    partner_id_display, partner_name, partner_type, 
    primary_contact_name, primary_contact_email, is_active
) VALUES (
    'PART-004', 'Operation Orange LLC', 'Investor',
    NULL,
    'cody@rightwaymgmt.com',
    true
) ON CONFLICT (partner_name) DO NOTHING;
INSERT INTO public.partners (
    partner_id_display, partner_name, partner_type, 
    primary_contact_name, primary_contact_email, is_active
) VALUES (
    'PART-005', 'Scott Aulds', 'Investor',
    'Scott Aulds',
    NULL,
    true
) ON CONFLICT (partner_name) DO NOTHING;
INSERT INTO public.partners (
    partner_id_display, partner_name, partner_type, 
    primary_contact_name, primary_contact_email, is_active
) VALUES (
    'PART-006', 'Shawn Leary', 'Investor',
    'Shawn Leary',
    NULL,
    true
) ON CONFLICT (partner_name) DO NOTHING;
INSERT INTO public.partners (
    partner_id_display, partner_name, partner_type, 
    primary_contact_name, primary_contact_email, is_active
) VALUES (
    'PART-007', 'WasteWatt Ventures LLC', 'Investor',
    'Kristine Cranley',
    'kristine@pmsquaredfinancial.com',
    true
) ON CONFLICT (partner_name) DO NOTHING;
INSERT INTO public.partners (
    partner_id_display, partner_name, partner_type, 
    primary_contact_name, primary_contact_email, is_active
) VALUES (
    'PART-008', 'Zapata II, LLC', 'Investor',
    NULL,
    NULL,
    true
) ON CONFLICT (partner_name) DO NOTHING;
