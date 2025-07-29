-- Journal Entries Batch 12

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0551', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-02',
    'Invoice',
    'Invoice - 2025-04-02',
    5559.75, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001260', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0551'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    5559.75, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0552', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-03',
    'Expense',
    'SERVICE CHARGES FOR THE MONTH OF MARCH',
    0.0, 117.53, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001261', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0552'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SERVICE CHARGES FOR THE MONTH OF MARCH',
    65.9, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001262', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0552'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S #40 KATY TX 04/03',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001263', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0552'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'APPLE LUMBER BRANCH 40 EAGLE LAKE TX XX3468 04/03',
    21.63, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0553', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-03',
    'Invoice',
    'Invoice - 2025-04-03',
    1897.5, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001264', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0553'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    1897.5, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0554', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-04',
    'Invoice',
    'Invoice - 2025-04-04',
    18586.32, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001265', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0554'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    18586.32, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0555', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-07',
    'Expense',
    'CIRCLE K #XXX2255 HOUSTON TX XX0381 04/07',
    0.0, 1337.9, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001266', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0555'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX2255 HOUSTON TX XX0381 04/07',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001267', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0555'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCCOYS *XXX-XXX-3878 MCCOYS.COM TX 04/08',
    1253.51, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001268', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0555'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ARLO TECHNOLOGIES INC XXX-XXX-3750 CA 04/09',
    10.65, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001269', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0555'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TST*TX BURGER - CROCKET Crockett TX 04/07',
    13.74, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001270', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0555'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'H-E-B GAS/CARWASH #791 WILLIS TX XX4691 04/07',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0556', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-07',
    'Payment',
    'Payment - 2025-04-07',
    28874.82, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001271', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0556'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    2831.25, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001272', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0556'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    5559.75, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001273', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0556'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    1897.5, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001274', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0556'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    18586.32, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0557', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-08',
    'Invoice',
    'Invoice - 2025-04-08',
    10799.73, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001275', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0557'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    10799.73, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0558', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-08',
    'Invoice',
    'Invoice - 2025-04-08',
    27545.22, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001276', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0558'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    27545.22, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0559', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-08',
    'Expense',
    'BUC-EE''S 24 XXX-XXX-6390 TX 04/08',
    0.0, 1319.71, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001277', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0559'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 04/08',
    51.38, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001278', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0559'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX6821 To Brett Burgeson 04/08',
    974.41, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001279', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0559'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'APPLE LUMBER BRANCH 40 EAGLE LAKE TX XX6502 04/08',
    125.34, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001280', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0559'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SOI*SNAPON TOOLS CO XXX-XXX-7664 WI 04/08',
    137.43, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001281', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0559'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'DOLLAR-GENERAL #3426 EAGLE LAKE TX XX0309 04/08',
    4.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001282', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0559'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ANTHROPIC ANTHROPIC.COM CA 04/08',
    26.65, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0560', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-08',
    'Invoice',
    'Invoice - 2025-04-08',
    2665.85, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001283', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0560'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    2665.85, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0561', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-09',
    'Expense',
    'NETLIFY NETLIFY.COM CA 04/09',
    0.0, 90.25, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001284', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0561'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NETLIFY NETLIFY.COM CA 04/09',
    20.25, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001285', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0561'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TAQUERIA AZTECA D.F EAGLE LAKE TX 04/09',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001286', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0561'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '9235 CLAY ROAD BUSINES HOUSTON TX XX1690 04/09',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0562', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-09',
    'Check',
    'CHECK # 5669',
    0.0, 8550.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001287', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0562'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CHECK # 5669',
    8550.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0563', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-10',
    'Expense',
    'CIRCLE K #XXX2255 HOUSTON TX XX0127 04/10',
    0.0, 6688.64, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001288', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0563'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX2255 HOUSTON TX XX0127 04/10',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001289', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0563'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TAQUERIA AZTECA D.F EAGLE LAKE TX 04/10',
    43.26, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001290', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0563'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:CARROLL INSURANC ORIG ID:XXXXXX3381 DESC DATE: CO ENTRY DESCR:J2488 OOFFSEC:CCD TRACE#:XXXXXXXX9236028 EED:250410 IND ID:CZX0000DWDKYC IND NAME:10N ETZERO INC TRN*1 *CZX0000DWDKYC\RMR*IK*CARROLL INSURANCE AGENCY LTD\ TRN: XXXXXX6028 TC',
    6454.74, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001291', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0563'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ADOBE *XXX-XXX-6687 ADOBE.LY/ENUS CA 04/11',
    21.64, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001292', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0563'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TODOIST TODOIST.COM CA 04/11',
    144.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0564', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-11',
    'Invoice',
    'Invoice - 2025-04-11',
    2690.05, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001293', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0564'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    2690.05, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0565', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-11',
    'Expense',
    'O''REILLY 6123 EAGLE LAKE TX XX8688 04/11',
    0.0, 118.05, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001294', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0565'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'O''REILLY 6123 EAGLE LAKE TX XX8688 04/11',
    10.27, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001295', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0565'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'O''REILLY 6123 EAGLE LAKE TX 04/11',
    15.14, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001296', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0565'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 04/11',
    52.64, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001297', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0565'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 04/11',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0566', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-11',
    'Invoice',
    'Invoice - 2025-04-11',
    5487.91, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001298', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0566'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    5487.91, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0567', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-13',
    'Expense',
    'INTUIT *QBooks Onlin CL.INTUIT.COM CA 11/13',
    0.0, 69.29, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001299', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0567'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'INTUIT *QBooks Onlin CL.INTUIT.COM CA 11/13',
    69.29, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0568', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-13',
    'Invoice',
    'Invoice - 2025-04-13',
    21315.36, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001300', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0568'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    21315.36, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0569', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-14',
    'Expense',
    'BUC-EE''S 24 XXX-XXX-6390 TX 04/14',
    0.0, 25.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001301', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0569'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 04/14',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0570', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-15',
    'Payment',
    'Payment - 2025-04-15',
    27545.22, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001302', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0570'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    27545.22, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0571', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-15',
    'Invoice',
    'Invoice - 2025-04-15',
    6252.37, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001303', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0571'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    6252.37, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0572', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-15',
    'Expense',
    'BUC-EE''S 24 XXX-XXX-6390 TX 04/15',
    0.0, 4471.68, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001304', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0572'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 04/15',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001305', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0572'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 04/15',
    49.58, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001306', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0572'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX9005 To BobcatCrane (_####4024)',
    2493.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001307', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0572'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX7651 To MonarchSparkPlugs (_########7762)',
    1904.1, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0573', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-15',
    'Invoice',
    'Invoice - 2025-04-15',
    20448.9, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001308', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0573'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    20448.9, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0574', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-15',
    'Payment',
    'Payment - 2025-04-15',
    15893.580000000002, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001309', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0574'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    2690.05, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001310', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0574'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    13203.53, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0575', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-16',
    'Expense',
    'OPENROUTER, INC OPENROUTER.AI NY 04/17',
    0.0, 304.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001311', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0575'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'OPENROUTER, INC OPENROUTER.AI NY 04/17',
    50.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001312', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0575'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SMOLIK''S MEATS AND BBQ XXX-XXX3459 TX 04/16',
    60.53, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001313', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0575'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WWW.PERPLEXITY.AI WWW.PERPLEXIT CA 04/16',
    5.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001314', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0575'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TYPINGMIND.COM WWW.TYPINGMIN WY 04/16',
    170.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001315', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0575'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WWW.PERPLEXITY.AI WWW.PERPLEXIT CA 04/16',
    10.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001316', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0575'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TAQUERIA AZTECA D.F EAGLE LAKE TX 04/16',
    8.47, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0576', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-17',
    'Invoice',
    'Invoice - 2025-04-17',
    30284.1, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001317', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0576'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    30284.1, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0577', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-17',
    'Invoice',
    'Invoice - 2025-04-17',
    19499.13, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001318', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0577'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    19499.13, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0578', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-17',
    'Invoice',
    'Invoice - 2025-04-17',
    7910.83, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001319', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0578'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    7910.83, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0579', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-17',
    'Expense',
    'Online Payment XXXXXXX3283 To Kebo Oil and Gas, INC 04/17',
    0.0, 4373.360000000001, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001320', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0579'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX3283 To Kebo Oil and Gas, INC 04/17',
    2897.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001321', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0579'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'PAPPAS BROTHERS STKHSE HOUSTON TX 04/17',
    1428.18, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001322', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0579'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'AIRTABLE.COM/BILL AIRTABLE.COM CA 04/17',
    25.58, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001323', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0579'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LYFT *1 RIDE 04-17 LYFT.COM CA 04/18',
    22.6, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0580', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-17',
    'Invoice',
    'Invoice - 2025-04-17',
    4675.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001324', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0580'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    4675.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0581', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-18',
    'Expense',
    'BUC-EE''S 24 XXX-XXX-6390 TX 04/18',
    0.0, 88.34, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001325', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0581'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 04/18',
    4.52, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001326', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0581'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 04/18',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001327', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0581'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ZORO TOOLS INC XXX-XXX9676 IL 04/18',
    53.82, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0582', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-19',
    'Payment',
    'Payment - 2025-04-19',
    8315.36, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001328', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0582'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    4000.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001329', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0582'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    315.36, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001330', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0582'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    4000.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0583', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-21',
    'Expense',
    'WAL SAMSCLUB #4712 000 HOUSTON TX XX4521 04/21',
    0.0, 194.56, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001331', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0583'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WAL SAMSCLUB #4712 000 HOUSTON TX XX4521 04/21',
    129.73, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001332', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0583'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ZORO TOOLS INC XXX-XXX9676 IL 04/21',
    64.83, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0584', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-21',
    'Invoice',
    'Invoice - 2025-04-21',
    2435.63, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001333', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0584'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    2435.63, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0585', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-22',
    'Expense',
    'HONEY FARMS #845 HOUSTON TX XX9000 04/22',
    0.0, 759.8100000000001, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001334', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0585'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'HONEY FARMS #845 HOUSTON TX XX9000 04/22',
    20.15, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001335', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0585'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SUNOCO XXXXXX2300 REFUGIO TX XX4600 04/22',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001336', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0585'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX2369 HOUSTON TX XX4980 04/22',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001337', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0585'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LA RIBERA TAQUERIA & RE REFUGIO TX 04/22',
    9.56, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001338', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0585'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'AIRTABLE.COM/BILL AIRTABLE.COM CA 04/22',
    25.58, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001339', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0585'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LOVE''S #0617 OUTSIDE HUNGERFORD TX XX3480 04/22',
    70.03, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001340', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0585'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NAVY EXCHANGE XX0060 CORPUS CHRIST TXXX9787 04/22',
    206.49, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001341', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0585'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TYPINGMIND.COM WWW.TYPINGMIN WY 04/22',
    299.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001342', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0585'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CURSOR, AI POWERED IDE CURSOR.COM NY 04/22',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001343', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0585'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'UIZARD COPENHAGEN 04/22',
    19.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001344', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0585'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TST*SMOLIKS SMOKEHOUSE Mathis TX 04/22',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0586', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-23',
    'Expense',
    'TST* ROAMING RONIN CORPUS CHRIST TX 04/23',
    0.0, 239.03, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001345', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0586'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TST* ROAMING RONIN CORPUS CHRIST TX 04/23',
    115.96, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001346', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0586'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MIDWEST HOSE - HOUSTO XXX-XXX-9092 TX 04/23',
    69.01, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001347', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0586'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TST*TX BURGER - CROCKET Crockett TX 04/23',
    14.06, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001348', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0586'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BIG''S 3830 CROCKETT TX XX0214 04/23',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0587', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-25',
    'Expense',
    'O''REILLY 1238 MATHIS TX XX3749 04/25',
    0.0, 109.96000000000001, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001349', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0587'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'O''REILLY 1238 MATHIS TX XX3749 04/25',
    29.41, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001350', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0587'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # X6983 MATHIS TX XX1086 04/25',
    1.07, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001351', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0587'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # X6983 MATHIS TX XX0082 04/25',
    79.48, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0588', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-28',
    'Payment',
    'Payment - 2025-04-28',
    88524.69, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001352', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0588'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    10799.73, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001353', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0588'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    2665.85, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001354', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0588'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    5487.91, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001355', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0588'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    6252.37, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001356', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0588'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    20448.9, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001357', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0588'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    7910.83, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001358', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0588'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    4675.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001359', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0588'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    30284.1, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0589', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-29',
    'Expense',
    'TRACTOR SUPPLY C 2340 SEALY TX XX1195 04/29',
    0.0, 160.73, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001360', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0589'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TRACTOR SUPPLY C 2340 SEALY TX XX1195 04/29',
    31.36, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001361', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0589'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN HOUSTON TX XX6292 04/29',
    7.89, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001362', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0589'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S #18 WALLER TX 04/29',
    68.32, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001363', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0589'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 04/29',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001364', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0589'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 04/29',
    13.16, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0590', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-30',
    'Expense',
    'SUNOCO XXXXXX2300 REFUGIO TX XX9300 04/30',
    0.0, 119.49999999999999, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001365', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0590'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SUNOCO XXXXXX2300 REFUGIO TX XX9300 04/30',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001366', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0590'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SUNOCO XXXXXX1300 MATHIS TX XX1573 04/30',
    20.07, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001367', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0590'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LA RIBERA TAQUERIA & RE REFUGIO TX 04/30',
    15.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001368', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0590'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LA RIBERA TAQUERIA & RE REFUGIO TX 04/30',
    13.77, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001369', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0590'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # X6979 REFUGIO TX XX5818 04/30',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001370', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0590'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NAME-CHEAP.COM* JAZS WWW.NAMECHEAP AZ 05/01',
    10.66, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0591', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-01',
    'Expense',
    'SUNOCO XXXXXX1300 MATHIS TX XX8146 05/01',
    0.0, 609.81, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001371', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0591'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SUNOCO XXXXXX1300 MATHIS TX XX8146 05/01',
    14.86, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001372', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0591'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'REPLIT, INC. REPLIT.COM CA 05/01',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001373', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0591'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BEST BUY #235 CORPUS CHRIST TX XX0005 05/01',
    497.92, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001374', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0591'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'STRIPES XXXXXX2700 CORPUS CHRIST TX XX2400 05/01',
    34.06, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001375', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0591'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'STRIPES XXXXXX2700 CORPUS CHRIST TX XX5286 05/01',
    22.97, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0592', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-02',
    'Expense',
    '7-ELEVEN HOUSTON TX XX1471 05/02',
    0.0, 235.82999999999998, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001376', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0592'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN HOUSTON TX XX1471 05/02',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001377', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0592'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'GLAMA.AI GLAMA.AI WY 05/02',
    11.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001378', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0592'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Amazon web services aws.amazon.co WA 05/03',
    122.57, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001379', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0592'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ZAPIER.COM/CHARGE ZAPIER.COM CA 05/02',
    10.66, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001380', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0592'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TAQUERIA AZTECA D.F EAGLE LAKE TX 05/02',
    21.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001381', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0592'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'RENDER.COM RENDER.COM CA 05/02',
    3.82, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001382', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0592'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'APPLE LUMBER BRANCH 40 EAGLE LAKE TX XX3468 05/02',
    36.78, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0593', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-03',
    'Expense',
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4007 DESC DATE:250505 CO ENTRY DESCR:FEE XX2756SEC:CCD TRACE#:XXXXXXXX9784427 EED:250505 IND ID:6 semk4fu58d IND NAME:10NetZero, Inc. 6semjnfchs4 TRN: XXXXXX4427 TC',
    0.0, 127.92, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001383', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0593'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4007 DESC DATE:250505 CO ENTRY DESCR:FEE XX2756SEC:CCD TRACE#:XXXXXXXX9784427 EED:250505 IND ID:6 semk4fu58d IND NAME:10NetZero, Inc. 6semjnfchs4 TRN: XXXXXX4427 TC',
    127.92, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0594', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-04',
    'Expense',
    'FOREMAN.MN FOREMAN.MN MD 05/05',
    0.0, 132.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001384', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0594'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'FOREMAN.MN FOREMAN.MN MD 05/05',
    132.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0595', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-05',
    'Expense',
    '7-ELEVEN HOUSTON TX XX8049 05/05',
    0.0, 166.37, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001385', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0595'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN HOUSTON TX XX8049 05/05',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001386', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0595'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SERVICE CHARGES FOR THE MONTH OF APRIL',
    52.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001387', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0595'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/05',
    62.62, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001388', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0595'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/05',
    11.25, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0596', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-06',
    'Expense',
    'BUC-EE''S #30 WHARTON TX 05/06',
    0.0, 116.74000000000001, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001389', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0596'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S #30 WHARTON TX 05/06',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001390', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0596'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # X6983 MATHIS TX XX6936 05/06',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001391', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0596'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TAQUERIA AZTECA D.F EAGLE LAKE TX 05/06',
    19.43, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001392', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0596'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'APPLE LUMBER BRANCH 40 EAGLE LAKE TX XX4308 05/06',
    17.31, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0597', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-07',
    'Expense',
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/07',
    0.0, 75.65, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001393', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0597'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/07',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001394', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0597'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN HOUSTON TX XX5097 05/07',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001395', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0597'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ARLO TECHNOLOGIES INC XXX-XXX-3750 CA 05/09',
    10.65, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0598', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-08',
    'Expense',
    'TEXAN # 8 VICTORIA VICTORIA TX XX0900 05/08',
    0.0, 149.57999999999998, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001396', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0598'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TEXAN # 8 VICTORIA VICTORIA TX XX0900 05/08',
    45.09, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001397', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0598'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CONNER''S CORNER STORE EDNA TX XX7000 05/08',
    86.99, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001398', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0598'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/08',
    15.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001399', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0598'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CTLP*Glitz Air RICHMOND TX 05/08',
    2.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0599', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-09',
    'Expense',
    '7-ELEVEN HOUSTON TX XX9875 05/09',
    0.0, 1716.4, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001400', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0599'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN HOUSTON TX XX9875 05/09',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001401', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0599'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TRACTOR SUPPLY C 2340 SEALY TX XX8766 05/09',
    793.35, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001402', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0599'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TX.GOV*SERVICEFEE-DI WWW.TEXAS.GOV TX 05/09',
    2.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001403', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0599'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TX.GOV*SERVICEFEE-DI WWW.TEXAS.GOV TX 05/09',
    2.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001404', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0599'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TX.GOV*SERVICEFEE-DI WWW.TEXAS.GOV TX 05/09',
    2.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001405', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0599'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'J & K KORNER STORE EAGLE LAKE TX 05/09',
    12.3, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001406', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0599'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'FORT BEND VEHREG WWW.TEXAS.GOV TX 05/09',
    225.75, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001407', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0599'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NETLIFY NETLIFY.COM CA 05/09',
    20.25, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001408', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0599'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'FORT BEND VEHREG WWW.TEXAS.GOV TX 05/09',
    225.75, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001409', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0599'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'FORT BEND VEHREG WWW.TEXAS.GOV TX 05/09',
    225.75, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001410', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0599'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'APPLE LUMBER BRANCH 40 EAGLE LAKE TX XX2823 05/09',
    187.25, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0600', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-09',
    'Invoice',
    'Invoice - 2025-05-09',
    2435.63, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001411', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0600'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    2435.63, true
) ON CONFLICT (line_id_display) DO NOTHING;

