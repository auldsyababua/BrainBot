-- Accounts Batch 2

INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-2520', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2520', 
    'Long-term business loans:Notes Payable - Colin Aulds', 
    'Liability', 'Credit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-2530', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2530', 
    'Long-term business loans:Notes Payable - S. Bryan Aulds', 
    'Liability', 'Credit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-2540', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2540', 
    'Long-term business loans:Notes Payable - Scott Aulds Sr.', 
    'Liability', 'Credit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-2550', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2550', 
    'Long-term business loans:Notes Payable - Shawn Leary', 
    'Liability', 'Credit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-2610', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2610', 
    'Long-term loans from shareholders:Cash Loan from Bryan Aulds', 
    'Liability', 'Credit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-2620', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2620', 
    'Long-term loans from shareholders:Cash Loan from Colin Aulds', 
    'Liability', 'Credit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-3110', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '3110', 
    'Common stock:Common Stock - Bryan Aulds', 
    'Equity', 'Credit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-3120', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '3120', 
    'Common stock:Common Stock - Colin Aulds', 
    'Equity', 'Credit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-3130', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '3130', 
    'Common stock:Common Stock - Joel Fulford', 
    'Equity', 'Credit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-3140', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '3140', 
    'Common stock:Common Stock - Shawn Leary', 
    'Equity', 'Credit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-3150', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '3150', 
    'Common stock:Common Stock - Scott Aulds Sr', 
    'Equity', 'Credit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-3160', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '3160', 
    'Common stock:Common Stock - Philip Stanley', 
    'Equity', 'Credit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-3200', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '3200', 
    'Additional paid in capital', 
    'Equity', 'Credit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-3300', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '3300', 
    'Dividends paid', 
    'Equity', 'Credit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-5000', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '5000', 
    'Site Equipment Sales', 
    'Income', 'Credit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-5100', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '5100', 
    'Services', 
    'Income', 'Credit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-5110', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '5110', 
    'Services:Consulting Income', 
    'Income', 'Credit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-5120', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '5120', 
    'Services:Power Sales - Mathis', 
    'Income', 'Credit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-5200', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '5200', 
    'Billable Expense Income', 
    'Income', 'Credit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-5210', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '5210', 
    'Billable Expense Income:Billable Expense Income - Tomball', 
    'Income', 'Credit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;