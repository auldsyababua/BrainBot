-- Accounts Batch 1

-- Insert Chart of Accounts
-- Generated from QuickBooks export

INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-1000', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '1000', 
    '10NetZero Checking (2705) - 1', 
    'Asset', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-1011', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '1011', 
    'Loans to officers:Loans To Officers - Joel', 
    'Asset', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-10310', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '10310', 
    'Inventory Asset', 
    'Asset', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-10456', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '10456', 
    'XG1450G-1', 
    'Asset', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-10457', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '10457', 
    'CAT XQ1475-2', 
    'Asset', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-1100', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '1100', 
    'Accounts receivable (A/R)', 
    'Asset', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-1300', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '1300', 
    'Crypto Assets', 
    'Asset', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-1410', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '1410', 
    'Hashhut#1', 
    'Asset', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-1411', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '1411', 
    'Hashhut#1:Hashhut#1- A/D', 
    'Asset', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-1420', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '1420', 
    'Hashhut #2', 
    'Asset', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-1421', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '1421', 
    'Hashhut #2:Hashhut #2 - A/D', 
    'Asset', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-1430', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '1430', 
    'Machinery & Equipment', 
    'Asset', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-1431', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '1431', 
    'Machinery & Equipment:Machinery & Equipment - A/D', 
    'Asset', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-1440', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '1440', 
    'Tools, machinery, and equipment', 
    'Asset', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-1441', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '1441', 
    'Tools, machinery, and equipment:Tools, machinery, and equipment', 
    'Asset', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-1450', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '1450', 
    'Electrical Equipment', 
    'Asset', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-1451', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '1451', 
    'Electrical Equipment:Electrical Equipment', 
    'Asset', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-2000', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2000', 
    'Accounts Payable (A/P)', 
    'Liability', 'Credit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-2200', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2200', 
    'Accrued Interest', 
    'Liability', 'Credit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-2500', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2500', 
    'Short-term business loans', 
    'Liability', 'Credit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;