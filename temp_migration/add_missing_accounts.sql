-- Add missing accounts
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_name, account_type, 
    account_subtype, is_active, description
) VALUES 
    ('ACC-1310', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', 'Prepaid Expenses', 
     'Asset', 'Current Asset', true, 'Prepaid expenses')
ON CONFLICT (account_id_display) DO NOTHING;
EOF < /dev/null