-- Accounts Batch 5

INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-7320', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '7320', 
    'Office expenses:Office supplies', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-7340', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '7340', 
    'Office expenses:Shipping & postage', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-7360', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '7360', 
    'Office expenses:Software & apps', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-7370', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '7370', 
    'Payroll expenses:Officers'' salaries', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-7500', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '7500', 
    'Interest Expense', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-7900', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '7900', 
    'Taxes paid', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-8000', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '8000', 
    'Depreciation', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;