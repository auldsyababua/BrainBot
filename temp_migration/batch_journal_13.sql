-- Journal Entries Batch 13

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0601', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-10',
    'Expense',
    'ADOBE *XXX-XXX-6687 XXX-XXX-6687 CA 05/10',
    0.0, 21.64, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001412', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0601'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ADOBE *XXX-XXX-6687 XXX-XXX-6687 CA 05/10',
    21.64, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0602', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-12',
    'Expense',
    '7-ELEVEN HOUSTON TX XX4825 05/12',
    0.0, 54.010000000000005, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001413', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0602'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN HOUSTON TX XX4825 05/12',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001414', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0602'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S #24 LAKE JACKSON TX XX2179 05/12',
    24.01, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0603', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-13',
    'Expense',
    'CIRCLE K # X6979 REFUGIO TX XX7998 05/13',
    0.0, 376.27, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001415', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0603'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # X6979 REFUGIO TX XX7998 05/13',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001416', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0603'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'O''REILLY 1238 MATHIS TX XX7007 05/13',
    43.29, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001417', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0603'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'INTUIT *QBooks Onlin CL.INTUIT.COM CA 11/13',
    69.29, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001418', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0603'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '0883 VICTORIA TX XX2019 05/13',
    16.73, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001419', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0603'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'H-E-B GAS #234 REFUGIO TX XX1599 05/13',
    65.4, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001420', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0603'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CONNER''S CORNER STORE EDNA TX XX6063 05/13',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001421', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0603'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LA RIBERA TAQUERIA & RE REFUGIO TX 05/13',
    9.56, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001422', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0603'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TST*SMOLIKS SMOKEHOUSE Mathis TX 05/13',
    102.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0604', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-13',
    'Payment',
    'Payment - 2025-05-13',
    25315.36, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001423', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0604'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    21315.36, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001424', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0604'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    4000.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0605', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-14',
    'Invoice',
    'Invoice - 2025-05-14',
    15172.98, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001425', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0605'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    15172.98, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0606', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-14',
    'Invoice',
    'Invoice - 2025-05-14',
    9730.25, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001426', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0606'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    9730.25, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0607', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-15',
    'Expense',
    '7-ELEVEN HOUSTON TX XX7203 05/15',
    0.0, 13826.6, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001427', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0607'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN HOUSTON TX XX7203 05/15',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001428', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0607'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX2305 To Kebo Oil and Gas, INC 05/15',
    3623.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001429', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0607'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/15',
    7.43, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001430', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0607'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/15',
    66.54, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001431', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0607'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TACTACAM WWW.REVEALCEL MN 05/15',
    9.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001432', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0607'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TAQUERIA AZTECA D.F EAGLE LAKE TX 05/15',
    64.13, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001433', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0607'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TACTACAM WWW.REVEALCEL MN 05/15',
    9.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001434', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0607'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'APPLE LUMBER BRANCH 40 EAGLE LAKE TX XX8253 05/15',
    17.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001435', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0607'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX2589 To Chiron (_#####8441)',
    10000.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0608', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-15',
    'Invoice',
    'Invoice - 2025-05-15',
    28904.9, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001436', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0608'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    28904.9, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0609', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-16',
    'Expense',
    '7-ELEVEN HOUSTON TX XX7852 05/16',
    0.0, 253.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001437', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0609'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN HOUSTON TX XX7852 05/16',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001438', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0609'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/16',
    10.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001439', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0609'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TYPINGMIND.COM WWW.TYPINGMIN WY 05/16',
    170.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001440', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0609'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TAQUERIA AZTECA D.F EAGLE LAKE TX 05/16',
    43.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0610', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-17',
    'Deposit',
    'O''REILLY 6123 EAGLE LAKE TX XX5885 05/17',
    58.44, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001441', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0610'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'O''REILLY 6123 EAGLE LAKE TX XX5885 05/17',
    58.44, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0611', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-17',
    'Expense',
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/17',
    0.0, 764.4599999999999, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001442', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0611'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/17',
    31.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001443', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0611'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TRACTOR SUPPLY C 2340 SEALY TX XX5090 05/17',
    32.43, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001444', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0611'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'O''REILLY 6123 EAGLE LAKE TX XX5061 05/17',
    563.42, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001445', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0611'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN X1119 HOUSTON TX 05/17',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001446', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0611'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'AIRTABLE.COM/BILL AIRTABLE.COM CA 05/17',
    76.24, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001447', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0611'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'AUTOZONE 4000 5121 AN HOUSTON TX XX4703 05/17',
    31.37, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0612', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-19',
    'Invoice',
    'Invoice - 2025-05-19',
    2580.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001448', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0612'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    2580.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0613', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-19',
    'Invoice',
    'Invoice - 2025-05-19',
    1542.5, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001449', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0613'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    1542.5, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0614', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-19',
    'Invoice',
    'Invoice - 2025-05-19',
    2848.75, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001450', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0614'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    2848.75, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0615', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-19',
    'Invoice',
    'Invoice - 2025-05-19',
    1526.25, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001451', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0615'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    1526.25, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0616', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-19',
    'Invoice',
    'Invoice - 2025-05-19',
    2850.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001452', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0616'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    2850.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0617', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-19',
    'Invoice',
    'Invoice - 2025-05-19',
    2132.5, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001453', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0617'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    2132.5, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0618', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-19',
    'Invoice',
    'Invoice - 2025-05-19',
    1598.75, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001454', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0618'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    1598.75, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0619', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-19',
    'Invoice',
    'Invoice - 2025-05-19',
    2985.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001455', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0619'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    2985.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0620', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-19',
    'Invoice',
    'Invoice - 2025-05-19',
    1967.5, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001456', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0620'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    1967.5, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0621', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-19',
    'Expense',
    '7-ELEVEN HOUSTON TX XX8636 05/19',
    0.0, 40.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001457', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0621'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN HOUSTON TX XX8636 05/19',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0622', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-19',
    'Invoice',
    'Invoice - 2025-05-19',
    2572.35, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001458', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0622'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    2572.35, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0623', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-20',
    'Expense',
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/20',
    0.0, 74.03999999999999, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001459', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0623'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/20',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001460', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0623'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WM SUPERCENTER #437 SEALY TX XX9542 05/20',
    34.04, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0624', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-21',
    'Expense',
    '7-ELEVEN HOUSTON TX XX7774 05/21',
    0.0, 61.97, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001461', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0624'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN HOUSTON TX XX7774 05/21',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001462', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0624'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/21',
    21.97, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0625', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-22',
    'Expense',
    '7-ELEVEN HOUSTON TX XX2511 05/22',
    0.0, 440.04, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001463', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0625'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN HOUSTON TX XX2511 05/22',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001464', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0625'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCDONALD''S FX0949 SEALY TX 05/22',
    9.73, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001465', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0625'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TRACTOR SUPPLY C 2340 SEALY TX XX7864 05/22',
    54.41, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001466', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0625'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'AIRTABLE.COM/BILL AIRTABLE.COM CA 05/22',
    25.58, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001467', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0625'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TYPINGMIND.COM WWW.TYPINGMIN WY 05/22',
    299.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001468', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0625'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CURSOR, AI POWERED IDE CURSOR.COM NY 05/22',
    21.32, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0626', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-23',
    'Expense',
    'O''REILLY 6123 EAGLE LAKE TX XX7200 05/23',
    0.0, 167.87, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001469', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0626'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'O''REILLY 6123 EAGLE LAKE TX XX7200 05/23',
    42.61, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001470', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0626'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN HOUSTON TX XX7974 05/23',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001471', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0626'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/23',
    49.2, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001472', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0626'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/23',
    8.93, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001473', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0626'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/23',
    10.48, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001474', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0626'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/23',
    16.65, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0627', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-26',
    'Invoice',
    'Invoice - 2025-05-26',
    1823.4, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001475', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0627'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    1823.4, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0628', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-26',
    'Deposit',
    'O''REILLY 6123 EAGLE LAKE TX XX1341 05/26',
    12.99, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001476', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0628'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'O''REILLY 6123 EAGLE LAKE TX XX1341 05/26',
    12.99, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0629', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-26',
    'Expense',
    'O''REILLY 6123 EAGLE LAKE TX XX8524 05/26',
    0.0, 213.54, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001477', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0629'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'O''REILLY 6123 EAGLE LAKE TX XX8524 05/26',
    116.85, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001478', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0629'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/26',
    11.25, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001479', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0629'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S #30 WHARTON TX 05/26',
    29.73, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001480', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0629'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN HOUSTON TX XX8341 05/26',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001481', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0629'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S #30 WHARTON TX 05/26',
    6.28, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001482', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0629'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TAQUERIA AZTECA D.F EAGLE LAKE TX 05/26',
    19.43, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0630', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-26',
    'Invoice',
    'Invoice - 2025-05-26',
    57916.27, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001483', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0630'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    57916.27, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0631', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-26',
    'Payment',
    'Paid via QuickBooks Payments: Payment ID 236134',
    4871.26, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001484', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0631'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Paid via QuickBooks Payments: Payment ID 236134',
    2435.63, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001485', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0631'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Paid via QuickBooks Payments: Payment ID 220260',
    2435.63, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0632', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-27',
    'Deposit',
    'System-recorded deposit for QuickBooks Payments',
    4871.26, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001486', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0632'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'System-recorded deposit for QuickBooks Payments',
    4871.26, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0633', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-27',
    'Expense',
    'System-recorded fee for QuickBooks Payments. Fee-name: DiscountRateFee, fee-type: Daily.',
    0.0, 506.12, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001487', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0633'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'System-recorded fee for QuickBooks Payments. Fee-name: DiscountRateFee, fee-type: Daily.',
    136.4, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001488', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0633'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SAN DONG NOODLE HOUSE HOUSTON TX 05/27',
    100.71, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001489', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0633'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'HOMEDEPOT.COM XXX-XXX-3376 GA 05/27',
    20.57, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001490', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0633'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'HOMEDEPOT.COM XXX-XXX-3376 GA 05/27',
    119.06, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001491', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0633'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MINT MOBILE XXX-XXX-7392 CA 05/27',
    129.38, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0634', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-27',
    'Payment',
    'Payment - 2025-05-27',
    37776.579999999994, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001492', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0634'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    15172.98, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001493', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0634'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    2580.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001494', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0634'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    1542.5, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001495', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0634'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    2848.75, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001496', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0634'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    2132.5, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001497', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0634'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    1526.25, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001498', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0634'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    2850.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001499', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0634'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    1598.75, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001500', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0634'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    2985.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001501', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0634'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    1967.5, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001502', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0634'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    2572.35, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0635', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-28',
    'Expense',
    '7-ELEVEN HOUSTON TX XX1776 05/28',
    0.0, 4611.24, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001503', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0635'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN HOUSTON TX XX1776 05/28',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001504', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0635'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250528 CO ENTRY DESCR:NET XX0973SEC:CCD TRACE#:XXXXXXXX2000526 EED:250528 IND ID:6 semk4mpaud IND NAME:10NetZero, Inc. 6semjng2p0t TRN: XXXXXX0526 TC',
    3280.67, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001505', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0635'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250528 CO ENTRY DESCR:TAX XX3247SEC:CCD TRACE#:XXXXXXXX2002593 EED:250528 IND ID:6 semk4mpaue IND NAME:10NetZero, Inc. 6semjng2hff TRN: XXXXXX2593 TC',
    1204.73, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001506', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0635'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'APIFY* INV#XXXXXXX9014 PRAGUE 05/29',
    95.84, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0636', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-29',
    'Deposit',
    'THE HOME DEPOT #0577 HOUSTON TX 05/29',
    37.42, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001507', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0636'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'THE HOME DEPOT #0577 HOUSTON TX 05/29',
    37.42, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0637', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-29',
    'Expense',
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/29',
    0.0, 4962.41, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001508', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0637'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/29',
    12.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001509', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0637'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/29',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001510', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0637'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'RAISING CANES 0103 HOUSTON TX 05/29',
    12.73, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001511', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0637'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'PRASEK''S HILLJE SMOKEH SEALY TX XX0013 05/29',
    7.41, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001512', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0637'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250529 CO ENTRY DESCR:NET XX7924SEC:CCD TRACE#:XXXXXXXX7201963 EED:250529 IND ID:6 semk4mpavf IND NAME:10NetZero, Inc. 6semjng4gkk TRN: XXXXXX1963 TC',
    3280.67, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001513', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0637'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250529 CO ENTRY DESCR:TAX XX5272SEC:CCD TRACE#:XXXXXXXX7208487 EED:250529 IND ID:6 semk4mpavg IND NAME:10NetZero, Inc. 6semjng3qgo TRN: XXXXXX8487 TC',
    1204.73, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001514', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0637'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'THE HOME DEPOT #0577 HOUSTON TX 05/29',
    150.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001515', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0637'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'THE HOME DEPOT #0577 HOUSTON TX XX7957 05/29',
    204.48, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001516', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0637'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'APPLE LUMBER BRANCH 40 EAGLE LAKE TX XX1019 05/29',
    69.89, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0638', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-30',
    'Expense',
    '7-ELEVEN HOUSTON TX XX5182 05/30',
    0.0, 30.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001517', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0638'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN HOUSTON TX XX5182 05/30',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0639', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-01',
    'Expense',
    'REPLIT, INC. REPLIT.COM CA 06/01',
    0.0, 40.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001518', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0639'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'REPLIT, INC. REPLIT.COM CA 06/01',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0640', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-02',
    'Expense',
    'SUNOCO XXXXXX2600 KINGWOOD TX XX0600 06/02',
    0.0, 195.36, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001519', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0640'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SUNOCO XXXXXX2600 KINGWOOD TX XX0600 06/02',
    50.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001520', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0640'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SHELL OIL XXXXXXX1528 EAST BERNARD TX 06/02',
    10.24, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001521', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0640'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SHELL OIL XXXXXXX1528 EAST BERNARD TX 06/02',
    77.87, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001522', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0640'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'QUICK TRACK #98 MARSHALL TX XX3200 06/02',
    50.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001523', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0640'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'RENDER.COM RENDER.COM CA 06/02',
    7.25, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0641', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-03',
    'Expense',
    '7-ELEVEN HOUSTON TX XX3568 06/03',
    0.0, 6635.009999999999, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001524', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0641'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN HOUSTON TX XX3568 06/03',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001525', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0641'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'O''REILLY 6123 EAGLE LAKE TX XX5151 06/03',
    33.51, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001526', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0641'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'APPLE LUMBER BRANCH 40 EAGLE LAKE TX XX3767 06/03',
    9.94, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001527', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0641'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'APPLE LUMBER BRANCH 40 EAGLE LAKE TX XX6346 06/03',
    140.71, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001528', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0641'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'APPLE LUMBER BRANCH 40 EAGLE LAKE TX XX7272 06/03',
    12.77, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001529', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0641'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'APPLE LUMBER BRANCH 40 EAGLE LAKE TX XX5826 06/03',
    18.39, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001530', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0641'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TAQUERIA AZTECA D.F EAGLE LAKE TX 06/03',
    74.69, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001531', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0641'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX1236 To Cimarron (_##1169)',
    6305.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0642', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-04',
    'Expense',
    'SERVICE CHARGES FOR THE MONTH OF MAY',
    0.0, 447.01, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001532', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0642'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SERVICE CHARGES FOR THE MONTH OF MAY',
    55.45, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001533', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0642'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN HOUSTON TX XX1340 06/04',
    50.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001534', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0642'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'APPLE LUMBER BRANCH 40 EAGLE LAKE TX XX3478 06/04',
    21.64, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001535', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0642'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TAQUERIA AZTECA D.F EAGLE LAKE TX 06/04',
    60.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001536', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0642'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4007 DESC DATE:250604 CO ENTRY DESCR:FEE XX7482SEC:CCD TRACE#:XXXXXXXX9190862 EED:250604 IND ID:6 semk4pnusi IND NAME:10NetZero, Inc. 6semjngd1kq TRN: XXXXXX0862 TC',
    127.92, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001537', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0642'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'FOREMAN.MN FOREMAN.MN MD 06/05',
    132.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0643', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-04',
    'Payment',
    'Payment - 2025-06-04',
    20589.54, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001538', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0643'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    20589.54, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0644', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-05',
    'Deposit',
    'System-recorded deposit for QuickBooks Payments',
    9730.25, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001539', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0644'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'System-recorded deposit for QuickBooks Payments',
    9730.25, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0645', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-05',
    'Expense',
    'System-recorded fee for QuickBooks Payments. Fee-name: DiscountRateFee, fee-type: Daily.',
    0.0, 333.15, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001540', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0645'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'System-recorded fee for QuickBooks Payments. Fee-name: DiscountRateFee, fee-type: Daily.',
    272.45, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001541', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0645'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX0595 RIVERSIDE TX XX3041 06/05',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001542', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0645'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'O''REILLY 765 CROCKETT TX 06/05',
    30.7, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0646', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-05',
    'Payment',
    'Paid via QuickBooks Payments: Payment ID 292594',
    9730.25, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001543', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0646'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Paid via QuickBooks Payments: Payment ID 292594',
    9730.25, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0647', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-06',
    'Expense',
    'TRACTOR SUPPLY C 2340 SEALY TX XX7381 06/06',
    0.0, 63.6, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001544', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0647'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TRACTOR SUPPLY C 2340 SEALY TX XX7381 06/06',
    43.6, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001545', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0647'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MURPHY7701ATWALMART SEALY TX XX7245 06/06',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0648', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-07',
    'Expense',
    'ARLO TECHNOLOGIES INC XXX-XXX-3750 CA 06/09',
    0.0, 10.65, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001546', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0648'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ARLO TECHNOLOGIES INC XXX-XXX-3750 CA 06/09',
    10.65, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0649', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-09',
    'Expense',
    '7-ELEVEN HOUSTON TX XX8892 06/09',
    0.0, 114.2, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001547', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0649'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN HOUSTON TX XX8892 06/09',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001548', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0649'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 06/09',
    14.67, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001549', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0649'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NETLIFY NETLIFY.COM CA 06/09',
    40.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001550', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0649'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'APPLE LUMBER BRANCH 40 EAGLE LAKE TX XX5383 06/09',
    19.03, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0650', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-10',
    'Expense',
    'BUC-EE''S 24 XXX-XXX-6390 TX 06/10',
    0.0, 217.06, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001551', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0650'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 06/10',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001552', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0650'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ADOBE *XXX-XXX-6687 ADOBE.LY/ENUS CA 06/11',
    21.64, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001553', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0650'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'RAISING CANES 0900 HOUSTON TX 06/10',
    12.73, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001554', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0650'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'THE HOME DEPOT #6525 HOUSTON TX XX7710 06/10',
    27.92, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001555', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0650'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ASAPPARTS SAN JOSE CA XX5031 06/09',
    114.77, false
) ON CONFLICT (line_id_display) DO NOTHING;

