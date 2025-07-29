-- Accounts Batch 4

INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6440', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6440', 
    'General business expenses:Advertising & marketing', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6500', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6500', 
    'Legal & accounting services', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6510', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6510', 
    'Legal & accounting services:Accounting fees', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6520', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6520', 
    'Legal & accounting services:Legal Fees', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6530', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6530', 
    'Legal & accounting services:Consulting Fees', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6610', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6610', 
    'Rent:Equipment rental', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6700', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6700', 
    'Supplies', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6710', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6710', 
    'Supplies:Supplies & materials', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6800', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6800', 
    'Travel', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6810', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6810', 
    'Travel:Airfare', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6820', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6820', 
    'Travel:Hotels', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6830', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6830', 
    'Travel:Vehicle gas & fuel', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6840', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6840', 
    'Travel:Milage', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6850', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6850', 
    'Travel:Parking & tolls', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6860', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6860', 
    'Travel:Taxis or shared rides', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-6920', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '6920', 
    'Utilities:Phone service', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-7000', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '7000', 
    'Meals', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-7010', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '7010', 
    'Meals:Meals with clients', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-7020', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '7020', 
    'Meals:Travel meals', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;
INSERT INTO public.chart_of_accounts (
    account_id_display, company_id, account_number, account_name, 
    account_type, normal_balance, opening_balance, is_active
) VALUES (
    'ACC-70300', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '70300', 
    'Gain on Sale of Asset', 
    'Expense', 'Debit', 
    0.0, true
) ON CONFLICT (account_id_display) DO NOTHING;