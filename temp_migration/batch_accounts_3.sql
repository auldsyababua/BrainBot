-- Accounts Batch 3

INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6010', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6010', 
    'Cost of goods sold:Site Equipment Purchase Cost', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6021', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6021', 
    'Cost of goods sold:Cost of labor - COGS:Site Setup - LA', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6022', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6022', 
    'Cost of goods sold:Cost of labor - COGS:Site Setup - Mathis', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6023', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6023', 
    'Cost of goods sold:Cost of labor - COGS:Site Setup - Tomball', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6024', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6024', 
    'Cost of goods sold:Cost of labor - COGS:Site Setup - Wharton', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6025', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6025', 
    'Cost of goods sold:Cost of labor - COGS:Site Setup Eagle Lake', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6040', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6040', 
    'Cost of goods sold:Freight in - COGS', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6051', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6051', 
    'Cost of goods sold:Supplies & materials - COGS:Gas Payment - Mathis', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6052', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6052', 
    'Cost of goods sold:Supplies & materials - COGS:Gas Payment - Tomball', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6053', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6053', 
    'Cost of goods sold:Supplies & materials - COGS:LA Gas Payment', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6100', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6100', 
    'Contract labor', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6200', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6200', 
    'Insurance', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6300', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6300', 
    'Repairs & maintenance', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6310', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6310', 
    'Repairs & maintenance:Site Maintence - Tomball', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6320', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6320', 
    'Repairs & maintenance:Site Maintenence - Mathis', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6330', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6330', 
    'Repairs & maintenance:Generator mainenance - Mathis', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6340', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6340', 
    'Repairs & maintenance:Generator maintenance - Tomball', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6400', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6400', 
    'General business expenses', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6410', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6410', 
    'General business expenses:Bank fees & service charges', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6430', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6430', 
    'General business expenses:Memberships & subscriptions', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;