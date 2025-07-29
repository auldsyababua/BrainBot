-- Journal Entries Batch 14

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0651', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-11',
    'Expense',
    '7-ELEVEN HOUSTON TX XX5063 06/11',
    0.0, 54.64, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001556', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0651'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN HOUSTON TX XX5063 06/11',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001557', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0651'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TST* RUDY''S COUNTRY STO KATY TX 06/12',
    24.64, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0652', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-13',
    'Expense',
    'INTUIT *QBooks Onlin CL.INTUIT.COM CA 11/13',
    0.0, 119.29, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001558', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0652'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'INTUIT *QBooks Onlin CL.INTUIT.COM CA 11/13',
    69.29, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001559', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0652'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 06/13',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001560', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0652'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'DELAWARE CORP & TAX W XXX-XXX-3073 DE 06/13',
    10.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0653', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-15',
    'Expense',
    'TACTACAM WWW.REVEALCEL MN 06/15',
    0.0, 18.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001561', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0653'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TACTACAM WWW.REVEALCEL MN 06/15',
    9.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001562', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0653'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TACTACAM WWW.REVEALCEL MN 06/15',
    9.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0654', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-16',
    'Expense',
    'BUC-EE''S #24 OUTSIDE EAGLE LAKE TX XX4816 06/16',
    0.0, 359.12, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001563', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0654'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S #24 OUTSIDE EAGLE LAKE TX XX4816 06/16',
    70.25, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001564', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0654'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S #24 OUTSIDE EAGLE LAKE TX XX8743 06/16',
    11.22, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001565', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0654'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN HOUSTON TX XX8574 06/16',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001566', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0654'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'O''REILLY 6123 EAGLE LAKE TX XX4639 06/16',
    27.04, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001567', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0654'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 06/16',
    3.24, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001568', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0654'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TAQUERIA AZTECA D.F EAGLE LAKE TX 06/16',
    38.76, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001569', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0654'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TYPINGMIND.COM WWW.TYPINGMIN WY 06/16',
    170.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001570', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0654'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'APPLE LUMBER BRANCH 40 EAGLE LAKE TX XX5145 06/16',
    8.61, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0655', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-17',
    'Expense',
    '7-ELEVEN HOUSTON TX XX5989 06/17',
    0.0, 6343.09, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001571', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0655'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN HOUSTON TX XX5989 06/17',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001572', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0655'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX5471 To Kebo Oil and Gas, INC 06/17',
    4414.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001573', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0655'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'O''REILLY 6123 EAGLE LAKE TX XX4087 06/17',
    88.17, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001574', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0655'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TAQUERIA AZTECA D.F EAGLE LAKE TX 06/17',
    53.07, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001575', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0655'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'APPLE LUMBER BRANCH 400 EAGLE LAKE TX 06/17',
    18.94, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001576', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0655'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'AIRTABLE.COM/BILL AIRTABLE.COM CA 06/17',
    51.17, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001577', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0655'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX8422 To Power Solutions International, Inc. 06/17',
    1614.75, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001578', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0655'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'FULSHEAR RE LLC FULSHEAR TX XX3900 06/17',
    72.99, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0656', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-18',
    'Invoice',
    'Invoice - 2025-06-18',
    18453.28, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001579', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0656'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    18453.28, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0657', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-18',
    'Invoice',
    'Invoice - 2025-06-18',
    11355.06, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001580', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0657'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    11355.06, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0658', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-18',
    'Invoice',
    'Invoice - 2025-06-18',
    5145.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001581', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0658'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    5145.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0659', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-18',
    'Invoice',
    'Invoice - 2025-06-18',
    2642.63, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001582', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0659'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    2642.63, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0660', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-20',
    'Expense',
    'SPYPOINT PREM-ANNUAL VICTORIAVILLE QC 06/20',
    0.0, 240.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001583', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0660'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SPYPOINT PREM-ANNUAL VICTORIAVILLE QC 06/20',
    120.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001584', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0660'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SPYPOINT PREM-ANNUAL VICTORIAVILLE QC 06/20',
    120.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0661', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-20',
    'Payment',
    'Paid via QuickBooks Payments: Payment ID 272234',
    30000.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001585', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0661'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Paid via QuickBooks Payments: Payment ID 272234',
    30000.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0662', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-21',
    'Payment',
    'Paid via QuickBooks Payments: Payment ID 117506',
    27916.27, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001586', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0662'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Paid via QuickBooks Payments: Payment ID 117506',
    27916.27, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0663', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-22',
    'Expense',
    'CURSOR, AI POWERED IDE CURSOR.COM NY 06/22',
    0.0, 345.9, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001587', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0663'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CURSOR, AI POWERED IDE CURSOR.COM NY 06/22',
    21.32, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001588', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0663'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TYPINGMIND.COM WWW.TYPINGMIN WY 06/22',
    299.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001589', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0663'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'AIRTABLE.COM/BILL AIRTABLE.COM CA 06/22',
    25.58, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0664', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-23',
    'Deposit',
    'System-recorded deposit for QuickBooks Payments',
    57916.27, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001590', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0664'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'System-recorded deposit for QuickBooks Payments',
    57916.27, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0665', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-23',
    'Expense',
    'System-recorded fee for QuickBooks Payments. Fee-name: DiscountRateFee, fee-type: Daily.',
    0.0, 1810.99, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001591', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0665'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'System-recorded fee for QuickBooks Payments. Fee-name: DiscountRateFee, fee-type: Daily.',
    1621.66, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001592', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0665'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'PANDA EXPRESS # 3059 WILLIS TX 06/23',
    13.53, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001593', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0665'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX2369 HOUSTON TX XX7691 06/23',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001594', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0665'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WM SUPERCENTER #236 CROCKETT TX XX7965 06/23',
    30.37, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001595', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0665'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TST*TX BURGER - CROCKET Crockett TX 06/23',
    28.45, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001596', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0665'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WAL WAL-MART #0236 002 CROCKETT TX XX9812 06/23',
    76.98, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0666', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-24',
    'Expense',
    '7-ELEVEN HOUSTON TX XX8444 06/24',
    0.0, 60.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001597', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0666'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN HOUSTON TX XX8444 06/24',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001598', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0666'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TAQUERIA AZTECA D.F EAGLE LAKE TX 06/24',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0667', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-25',
    'Expense',
    '7-ELEVEN HOUSTON TX XX0545 06/25',
    0.0, 47.370000000000005, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001599', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0667'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN HOUSTON TX XX0545 06/25',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001600', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0667'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 06/25',
    14.13, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001601', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0667'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'APPLE LUMBER BRANCH 40 EAGLE LAKE TX XX0451 06/25',
    3.24, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0668', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-26',
    'Invoice',
    'Invoice - 2025-06-26',
    21144.63, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001602', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0668'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    21144.63, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0669', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-26',
    'Invoice',
    'Invoice - 2025-06-26',
    2200.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001603', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0669'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    2200.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0670', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-26',
    'Expense',
    'Online ACH Payment XXXXXXX0398 To Chiron (_#####8441)',
    0.0, 10000.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001604', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0670'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX0398 To Chiron (_#####8441)',
    10000.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0671', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-26',
    'Invoice',
    'Invoice - 2025-06-26',
    5076.18, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001605', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0671'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    5076.18, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0672', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-27',
    'Expense',
    '7-ELEVEN HOUSTON TX XX3816 06/27',
    0.0, 9013.57, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001606', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0672'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN HOUSTON TX XX3816 06/27',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001607', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0672'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 06/27',
    12.75, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001608', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0672'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250627 CO ENTRY DESCR:TAX XX2126SEC:CCD TRACE#:XXXXXXXX3599831 EED:250627 IND ID:6 semk517rss IND NAME:10NetZero, Inc. 6semjnh7e0u TRN: XXXXXX9831 TC',
    1204.77, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001609', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0672'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250627 CO ENTRY DESCR:NET XX2131SEC:CCD TRACE#:XXXXXXXX3600533 EED:250627 IND ID:6 semk517rsr IND NAME:10NetZero, Inc. 6semjnh7e13 TRN: XXXXXX0533 TC',
    3280.65, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001610', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0672'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250627 CO ENTRY DESCR:NET XX2128SEC:CCD TRACE#:XXXXXXXX3601898 EED:250627 IND ID:6 semk517rno IND NAME:10NetZero, Inc. 6semjnh7e10 TRN: XXXXXX1898 TC',
    3280.67, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001611', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0672'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250627 CO ENTRY DESCR:TAX XX9221SEC:CCD TRACE#:XXXXXXXX3587788 EED:250627 IND ID:6 semk517rnp IND NAME:10NetZero, Inc. 6semjnh7kul TRN: XXXXXX7788 TC',
    1204.73, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0673', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-28',
    'Expense',
    'APIFY* INV#XXXXXXX9009 PRAGUE 06/29',
    0.0, 39.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001612', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0673'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'APIFY* INV#XXXXXXX9009 PRAGUE 06/29',
    39.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0674', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-30',
    'Expense',
    '7-ELEVEN HOUSTON TX XX4028 06/30',
    0.0, 148.2, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001613', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0674'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN HOUSTON TX XX4028 06/30',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001614', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0674'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 06/30',
    17.59, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001615', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0674'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 06/30',
    61.61, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001616', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0674'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MAGIC PATTERNS WWW.MAGICPATT DE 06/30',
    19.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001617', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0674'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SAMSCLUB #4712 HOUSTON TX XX1300 06/30',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0675', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-07-01',
    'Expense',
    'WHATABURGER 1038 CORRIGAN TX 07/01',
    0.0, 510.54999999999995, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001618', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0675'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WHATABURGER 1038 CORRIGAN TX 07/01',
    12.29, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001619', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0675'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX0595 RIVERSIDE TX XX3177 07/01',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001620', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0675'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LOVE''S #0290 OUTSIDE LUFKIN TX XX2612 07/01',
    64.03, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001621', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0675'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'REPLIT, INC. REPLIT.COM CA 07/01',
    42.64, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001622', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0675'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CTLP*CSC ServiceWorks MELVILLE NY 07/01',
    3.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001623', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0675'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MIRACLE MART #2 LINDEN TX 07/01',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001624', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0675'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'RODESSA GAS N GRILL RODESSA LA 07/01',
    76.16, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001625', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0675'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TST*FIRE AND KNIVES Linden TX 07/01',
    222.54, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001626', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0675'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CTLP*VendAIr LONGVIEW TX 07/01',
    2.25, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001627', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0675'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'QT 7906 OUTSIDE MARSHALL TX XX7689 07/01',
    19.69, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001628', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0675'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'RODESSA GAS N GRILL RODESSA LA 07/01',
    7.95, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0676', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-07-02',
    'Expense',
    'CEFCO #104 MT ENTERPR MOUNT ENTERP TXXX1100 07/02',
    0.0, 51.29, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001629', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0676'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CEFCO #104 MT ENTERPR MOUNT ENTERP TXXX1100 07/02',
    50.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001630', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0676'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S #26 MADISONVILLE TX 07/02',
    1.29, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0677', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-07-03',
    'Expense',
    'SERVICE CHARGES FOR THE MONTH OF JUNE',
    0.0, 12.5, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001631', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0677'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SERVICE CHARGES FOR THE MONTH OF JUNE',
    12.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0678', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-07-03',
    'Payment',
    'Payment - 2025-07-03',
    44495.549999999996, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001632', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0678'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    1823.4, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001633', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0678'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    11355.06, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001634', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0678'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    5145.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001635', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0678'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    2642.63, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001636', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0678'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    18453.28, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001637', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0678'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    5076.18, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0679', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-07-08',
    'Expense',
    'BUC-EE''S 24 XXX-XXX-6390 TX 07/08',
    0.0, 41.31, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001638', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0679'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 07/08',
    30.66, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001639', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0679'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ARLO TECHNOLOGIES INC XXX-XXX-3750 CA 07/09',
    10.65, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0680', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-07-10',
    'Expense',
    '7-ELEVEN HOUSTON TX XX8491 07/10',
    0.0, 73.02000000000001, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001640', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0680'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN HOUSTON TX XX8491 07/10',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001641', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0680'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TAQUERIA AZTECA D.F EAGLE LAKE TX 07/10',
    33.02, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0681', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-07-11',
    'Expense',
    'BOUDREAUX EXPRESS MART TOMBALL TX XX8763 07/11',
    0.0, 66.97, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001642', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0681'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BOUDREAUX EXPRESS MART TOMBALL TX XX8763 07/11',
    59.93, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001643', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0681'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CHEVRON XXX2710 KATY TX 07/11',
    7.04, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0682', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-07-13',
    'Expense',
    'INTUIT *QBooks Onlin CL.INTUIT.COM CA 11/13',
    0.0, 79.95, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001644', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0682'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'INTUIT *QBooks Onlin CL.INTUIT.COM CA 11/13',
    79.95, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0683', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-07-14',
    'Expense',
    '7-ELEVEN HOUSTON TX XX9630 07/14',
    0.0, 97.6, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001645', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0683'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN HOUSTON TX XX9630 07/14',
    29.35, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001646', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0683'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S #24 OUTSIDE EAGLE LAKE TX XX8274 07/14',
    68.25, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0684', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-07-14',
    'Invoice',
    'Invoice - 2025-07-14',
    69499.54, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001647', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0684'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    69499.54, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0685', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-07-15',
    'Expense',
    '7-ELEVEN HOUSTON TX XX4992 07/15',
    0.0, 86.48, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001648', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0685'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN HOUSTON TX XX4992 07/15',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001649', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0685'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'STAR STOP #65 HOUSTON TX 07/15',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001650', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0685'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 07/15',
    16.48, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0686', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-07-15',
    'Payment',
    'Payment - 2025-07-15',
    23344.63, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001651', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0686'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    21144.63, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001652', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0686'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    2200.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0687', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-07-16',
    'Expense',
    'BUC-EE''S 24 XXX-XXX-6390 TX 07/16',
    0.0, 80.41999999999999, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001653', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0687'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 07/16',
    53.53, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001654', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0687'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 07/16',
    13.16, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001655', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0687'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 07/16',
    5.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001656', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0687'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 07/16',
    4.99, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001657', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0687'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 07/16',
    3.24, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0688', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-07-17',
    'Invoice',
    'Invoice - 2025-07-17',
    1065.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001658', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0688'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    1065.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0689', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-07-17',
    'Invoice',
    'Invoice - 2025-07-17',
    33450.36, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001659', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0689'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    33450.36, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0690', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-07-17',
    'Expense',
    'Online Payment XXXXXXX8707 To Kebo Oil and Gas, INC 07/17',
    0.0, 3523.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001660', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0690'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX8707 To Kebo Oil and Gas, INC 07/17',
    3523.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0691', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-07-17',
    'Invoice',
    'Invoice - 2025-07-17',
    27995.18, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001661', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0691'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    27995.18, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0692', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-07-18',
    'Expense',
    'O''REILLY 6123 EAGLE LAKE TX XX8010 07/18',
    0.0, 59.96, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001662', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0692'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'O''REILLY 6123 EAGLE LAKE TX XX8010 07/18',
    43.68, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001663', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0692'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WHATABURGER 120 Q26 HOUSTON TX 07/18',
    16.28, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0693', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-07-18',
    'Payment',
    'Payment - 2025-07-18',
    69499.54, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001664', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0693'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    69499.54, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0694', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-07-21',
    'Expense',
    'CIRCLE K #XXX2156 HOUSTON TX XX4796 07/21',
    0.0, 127.74, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001665', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0694'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX2156 HOUSTON TX XX4796 07/21',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001666', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0694'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 07/21',
    11.12, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001667', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0694'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 07/21',
    72.1, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001668', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0694'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 07/21',
    4.52, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0695', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-07-23',
    'Expense',
    'O''REILLY 6123 EAGLE LAKE TX XX6993 07/23',
    0.0, 333.02, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001669', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0695'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'O''REILLY 6123 EAGLE LAKE TX XX6993 07/23',
    260.06, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001670', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0695'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TRACTOR SUPPLY C 2340 SEALY TX XX2264 07/23',
    32.96, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001671', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0695'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN HOUSTON TX XX7279 07/23',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0696', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-07-25',
    'Expense',
    '7-ELEVEN HOUSTON TX XX5037 07/25',
    0.0, 40.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001672', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0696'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN HOUSTON TX XX5037 07/25',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0697', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-07-28',
    'Invoice',
    'Invoice - 2025-07-28',
    14072.5, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001673', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0697'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    14072.5, true
) ON CONFLICT (line_id_display) DO NOTHING;

