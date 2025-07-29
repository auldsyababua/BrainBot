-- Journal Entries Batch 6

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0251', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-18',
    'Expense',
    'HANDI STOP # 54 HOUSTON TX 05/18',
    0.0, 1693.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000481', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0251'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'HANDI STOP # 54 HOUSTON TX 05/18',
    10.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000482', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0251'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:Express Transpor ORIG ID:204876018 DESC DATE:May 20 CO ENTRY DESCR:10 net zerSEC:CCD TRACE#:XXXXXXXX3742200 EED:240520 IND ID:5 -X8615 IND NAME:10 n et zero TRN: XXXXXX2200 TC',
    1683.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0252', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-20',
    'Deposit',
    'Credit Return: Online Payment XXXXXXX1475 To Certified Production Services, LLC',
    5763.21, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000483', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0252'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Credit Return: Online Payment XXXXXXX1475 To Certified Production Services, LLC',
    5763.21, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0253', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-20',
    'Expense',
    'AZTEC RENTAL CENTER NO2 HOUSTON TX 05/20',
    0.0, 620.33, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000484', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0253'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'AZTEC RENTAL CENTER NO2 HOUSTON TX 05/20',
    620.33, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0254', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-21',
    'Expense',
    'CHEVRON XXX3521 TOMBALL TX 05/21',
    0.0, 1113.17, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000485', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0254'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CHEVRON XXX3521 TOMBALL TX 05/21',
    46.15, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000486', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0254'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CHEVRON XXX3521 TOMBALL TX 05/21',
    19.74, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000487', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0254'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TOMBALL RENTAL CENTER TOMBALL TX 05/21',
    1047.28, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0255', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-22',
    'Expense',
    'SONIC DRIVE IN #5047 TOMBALL TX 05/22',
    0.0, 124.41, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000488', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0255'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SONIC DRIVE IN #5047 TOMBALL TX 05/22',
    7.56, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000489', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0255'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LOWE''S #1052 TOMBALL TX XX6519 05/22',
    96.85, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000490', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0255'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '9235 CLAY ROAD HOUSTON TX 05/22',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0256', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-23',
    'Deposit',
    'TOMBALL RENTAL CENTER TOMBALL TX 05/23',
    500.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000491', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0256'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TOMBALL RENTAL CENTER TOMBALL TX 05/23',
    500.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0257', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-23',
    'Expense',
    'CHEVRON XXX3521 TOMBALL TX 05/23',
    0.0, 118.78, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000492', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0257'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CHEVRON XXX3521 TOMBALL TX 05/23',
    8.42, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000493', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0257'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WHATABURGER 134 Q26 HOUSTON TX 05/23',
    24.93, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000494', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0257'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ELLIOTT ELECTRIC XXXXXX7941 TX 05/23',
    60.64, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000495', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0257'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LOWE''S #1052 TOMBALL TX XX1633 05/23',
    24.79, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0258', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-24',
    'Expense',
    'RAISING CANES 0419 TOMBALL TX 05/24',
    0.0, 39.71, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000496', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0258'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'RAISING CANES 0419 TOMBALL TX 05/24',
    29.71, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000497', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0258'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '9235 CLAY ROAD HOUSTON TX 05/24',
    10.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0259', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-25',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX4588 05/25',
    0.0, 14.98, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000498', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0259'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX4588 05/25',
    14.98, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0260', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-26',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX9329 05/26',
    0.0, 10.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000499', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0260'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX9329 05/26',
    10.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0261', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-27',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX1665 05/27',
    0.0, 21.990000000000002, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000500', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0261'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX1665 05/27',
    10.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000501', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0261'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCDONALD''S FX9431 CYPRESS TX 05/27',
    11.99, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0262', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-28',
    'Expense',
    'Online ACH Payment XXXXXXX6271 To Bernardo (_######3816)',
    0.0, 15824.53, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000502', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0262'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX6271 To Bernardo (_######3816)',
    1904.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000503', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0262'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX7134 To Lagarto Rental Tools, Inc 05/28',
    1388.34, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000504', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0262'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX7346 To 2W Services 05/28',
    12532.19, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0263', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-29',
    'Expense',
    'POTBELLY #522 TOMBALL TX 05/29',
    0.0, 59.02, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000505', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0263'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'POTBELLY #522 TOMBALL TX 05/29',
    39.02, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000506', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0263'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '9235 CLAY ROAD HOUSTON TX 05/29',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0264', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-30',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX8519 05/30',
    0.0, 54657.28999999999, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000507', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0264'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX8519 05/30',
    15.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000508', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0264'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ELLIOTT ELECTRIC SUPPL NACOGDOCHES TXXX7167 05/30',
    33.02, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000509', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0264'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX0547 To HeatCore (_#####1037)',
    54184.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000510', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0264'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ELLIOTT ELECTRIC SUPPL NACOGDOCHES TXXX2240 05/30',
    360.47, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000511', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0264'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ELLIOTT ELECTRIC SUPPL NACOGDOCHES TXXX6106 05/30',
    17.32, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000512', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0264'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ELLIOTT ELECTRIC SUPPL NACOGDOCHES TXXX0306 05/30',
    42.09, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000513', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0264'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LOWE''S #1052 TOMBALL TX XX1092 05/30',
    5.39, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0265', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-31',
    'Expense',
    'WM SUPERC WAL-MART SUP RICHMOND TX 05/31',
    0.0, 84.75, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000514', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0265'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WM SUPERC WAL-MART SUP RICHMOND TX 05/31',
    84.75, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0266', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-01',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX6109 06/01',
    0.0, 20.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000515', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0266'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX6109 06/01',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0267', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-03',
    'Expense',
    'CHEVRON XXX3521 TOMBALL TX 05/31',
    0.0, 158.70000000000002, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000516', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0267'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CHEVRON XXX3521 TOMBALL TX 05/31',
    10.77, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000517', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0267'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SONIC DRIVE IN #5047 TOMBALL TX 06/03',
    14.81, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000518', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0267'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'HUNT ROAD PIT S BROOKSHIRE TX 06/03',
    89.66, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000519', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0267'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LOWE''S #1052 TOMBALL TX XX5288 06/03',
    34.06, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000520', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0267'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'THE HOME DEPOT #6525 HOUSTON TX XX0542 06/03',
    9.4, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0268', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-04',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX8601 06/04',
    0.0, 9.99, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000521', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0268'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX8601 06/04',
    9.99, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0269', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-05',
    'Expense',
    'Online Payment XXXXXXX1641 To Kebo Oil and Gas, INC 06/05',
    0.0, 9661.94, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000522', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0269'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX1641 To Kebo Oil and Gas, INC 06/05',
    3230.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000523', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0269'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SERVICE CHARGES FOR THE MONTH OF MAY',
    15.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000524', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0269'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TST* RUDY''S COUNTRY STO TOMBALL TX 06/06',
    32.9, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000525', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0269'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:IPFSXXX-XXX-2621 ORIG ID:0 ADXXX4370 DESC DATE: CO ENTRY DESCR:IPFSPMTTXPSEC:CCD TRACE#:XXXXXXXX6161358 EED:240605 IND ID:62397 IND NAME:10 NET ZERO INC. GDxLk2vV TRN: XXXXXX1358 TC',
    559.66, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000526', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0269'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX9293 To MartinLegal (_#####2006)',
    1587.7, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000527', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0269'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX6845 To Hard Core Supply LLC 06/05',
    4171.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000528', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0269'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WM SUPERC WAL-MART SUP RICHMOND TX 06/05',
    65.18, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0270', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-06',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX5718 06/06',
    0.0, 7840.379999999999, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000529', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0270'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX5718 06/06',
    10.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000530', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0270'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCDONALD''S FX9431 CYPRESS TX 06/06',
    9.3, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000531', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0270'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TARGET XXXX9042 TOMBALL TX 06/06',
    24.89, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000532', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0270'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX1449 To ACSJames (_########1332)',
    7796.19, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0271', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-07',
    'Expense',
    'WITHDRAWAL 06/07',
    0.0, 11970.94, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000533', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0271'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WITHDRAWAL 06/07',
    9400.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000534', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0271'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '4TE*CULLIGAN OF HOUST XXX-XXX-6400 TX 06/08',
    2570.94, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0272', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-09',
    'Expense',
    'NETLIFY HTTPSWWW.NETL CA 06/09',
    0.0, 20.25, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000535', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0272'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NETLIFY HTTPSWWW.NETL CA 06/09',
    20.25, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0273', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-10',
    'Expense',
    'FLYING J #740 HOUSTON TX XX2606 06/10',
    0.0, 1987.38, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000536', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0273'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'FLYING J #740 HOUSTON TX XX2606 06/10',
    123.94, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000537', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0273'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '9ER''S GRILL @ WHARTON WHARTON TX 06/10',
    33.19, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000538', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0273'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'PMT*FT BEND CO TAX OFFI RICHMOND TX 06/10',
    1830.25, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0274', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-11',
    'Expense',
    'HINZE COUNTRY KITCHEN WHARTON TX 06/11',
    0.0, 1719.91, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000539', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0274'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'HINZE COUNTRY KITCHEN WHARTON TX 06/11',
    38.43, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000540', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0274'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BARBEE SERVICES INC WHARTON TX 06/11',
    1260.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000541', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0274'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ENTERPRISE RENT-A-CAR KATY TX 06/11',
    421.48, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0275', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-12',
    'Expense',
    'CHEVRON XXX3521 TOMBALL TX 06/12',
    0.0, 23.49, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000542', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0275'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CHEVRON XXX3521 TOMBALL TX 06/12',
    3.59, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000543', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0275'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'JACK IN THE BOX 3980 TOMBALL TX 06/12',
    11.03, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000544', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0275'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCDONALD''S FX9431 CYPRESS TX 06/12',
    8.87, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0276', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-13',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX5635 06/13',
    0.0, 957.45, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000545', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0276'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX5635 06/13',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000546', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0276'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TEJAS CHOCOLATE & BARB XXX-XXX0670 TX 06/13',
    80.11, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000547', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0276'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ELLIOTT ELECTRIC XXXXXX7941 TX 06/13',
    857.34, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0277', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-14',
    'Expense',
    'ACADEMY SPORTS & OUTDO HOUSTON TX XX5544 06/14',
    0.0, 1066.94, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000548', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0277'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ACADEMY SPORTS & OUTDO HOUSTON TX XX5544 06/14',
    238.13, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000549', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0277'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'IN *SCHILLEREFF POWER XXX-XXX0410 TX 06/14',
    828.81, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0278', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-15',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX3824 06/15',
    0.0, 47.87, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000550', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0278'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX3824 06/15',
    10.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000551', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0278'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SAM''S CLUB HOUSTON TX 06/15',
    37.87, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0279', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-17',
    'Expense',
    'CIRCLE K # X6979 217 N REFUGIO TX 06/17',
    0.0, 2020.1699999999998, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000552', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0279'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # X6979 217 N REFUGIO TX 06/17',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000553', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0279'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MURPHY7018ATWAL WHARTON TX 06/17',
    35.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000554', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0279'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'O''REILLY 1652 REFUGIO TX XX8012 06/17',
    438.08, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000555', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0279'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'IN *SCHILLEREFF POWER XXX-XXX0410 TX 06/17',
    1497.1, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000556', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0279'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:LYFT MEMBERSHIP ORIG ID:XXXXXX2264 DESC DATE:240615 CO ENTRY DESCR:PAYMENTS SEC:CCD TRACE#:XXXXXXXX6355768 EED:240617 IND ID:XXXXXXXX2863374 IND NA ME:XXXXXXXXXXXXXXXXXX0906 TELECHK XXX-XXX-9263 TRN: XXXXXX5768 TC',
    9.99, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0280', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-18',
    'Expense',
    'Claim reversal: ADOBE *XXX-XXX-6687 ADOBE.LY/ENUS CA 05/11 ClaimId: XXXXXXXXXXX0001',
    0.0, 21.64, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000557', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0280'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Claim reversal: ADOBE *XXX-XXX-6687 ADOBE.LY/ENUS CA 05/11 ClaimId: XXXXXXXXXXX0001',
    21.64, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0281', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-19',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX8989 06/19',
    0.0, 28.91, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000558', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0281'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX8989 06/19',
    15.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000559', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0281'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CHIPOTLE 2794 TOMBALL TX 06/19',
    13.91, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0282', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-20',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX8421 06/20',
    0.0, 516.76, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000560', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0282'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX8421 06/20',
    10.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000561', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0282'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'UNITED XXXXXXX7315 UNITED.COM TX 06/20',
    246.96, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000562', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0282'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SPYPOINT PREM-ANNUAL VICTORIAVILLE QC 06/20',
    129.9, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000563', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0282'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SPYPOINT PREM-ANNUAL VICTORIAVILLE QC 06/20',
    129.9, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0283', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-21',
    'Expense',
    'PILOT #472 BEASLEY TX XX0530 06/21',
    0.0, 20.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000564', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0283'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'PILOT #472 BEASLEY TX XX0530 06/21',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0284', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-22',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX0442 06/22',
    0.0, 10.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000565', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0284'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX0442 06/22',
    10.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0285', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-23',
    'Expense',
    'UNITED XXXXXXX3607 UNITED.COM TX 06/23',
    0.0, 631.99, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000566', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0285'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'UNITED XXXXXXX3607 UNITED.COM TX 06/23',
    542.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000567', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0285'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'UNITED XXXXXXX9479 UNITED.COM TX 06/23',
    89.99, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0286', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-24',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX8875 06/24',
    0.0, 10.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000568', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0286'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX8875 06/24',
    10.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0287', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-25',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX0566 06/25',
    0.0, 25.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000569', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0287'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX0566 06/25',
    15.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000570', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0287'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX9067 06/25',
    10.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0288', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-26',
    'Expense',
    'CIRCLE K #XXX2255 HOUSTON TX XX1915 06/26',
    0.0, 314.78999999999996, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000571', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0288'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX2255 HOUSTON TX XX1915 06/26',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000572', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0288'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'HONEY FARMS #81 HOUSTON TX 06/26',
    46.63, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000573', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0288'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'THE HOME DEPOT #6525 HOUSTON TX XX8568 06/26',
    248.16, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0289', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-27',
    'Expense',
    'PANDA EXPRESS 1215 TOMBALL TX 06/27',
    0.0, 492.05, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000574', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0289'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'PANDA EXPRESS 1215 TOMBALL TX 06/27',
    13.1, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000575', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0289'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'UNITED XXXXXXX5426 UNITED.COM TX 06/27',
    478.95, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0290', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-28',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX2893 06/28',
    0.0, 15.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000576', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0290'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX2893 06/28',
    15.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0291', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-30',
    'Expense',
    'SHELL SERVICE STATION HOCKLEY TX XX9539 06/30',
    0.0, 523.0699999999999, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000577', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0291'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SHELL SERVICE STATION HOCKLEY TX XX9539 06/30',
    94.07, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000578', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0291'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'DELAWARE CORP & TAX W XXX-XXX-3073 DE 06/28',
    429.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0292', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-01',
    'Expense',
    'ADOBE *XXX-XXX-6687 ADOBE.LY/ENUS CA 07/02',
    0.0, 250.88, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000579', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0292'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ADOBE *XXX-XXX-6687 ADOBE.LY/ENUS CA 07/02',
    4.71, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000580', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0292'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX5219 To Bernardo (_######3816)',
    246.17, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0293', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-02',
    'Deposit',
    'FEDWIRE CREDIT VIA: FIRST FINANCIAL BANK, N.A./XXXXX1122 B/O: WASTEWATT VENTUR FORT WORTH, TX XXXXX4071 REF: CHASE NYC/CTR/BNF=10NETZERO, INC. HOUSTON TX X7092- 6626 US/AC-XXXX0000 5231 RFB=#108 OBI=INVOICE 108 -180K W HASHUT GENERATOR AND 900KW HASHHU T IMAD: 0702MMQFMPXXXX0293 TRN: XXXXXX1184 FF',
    249290.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000581', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0293'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'FEDWIRE CREDIT VIA: FIRST FINANCIAL BANK, N.A./XXXXX1122 B/O: WASTEWATT VENTUR FORT WORTH, TX XXXXX4071 REF: CHASE NYC/CTR/BNF=10NETZERO, INC. HOUSTON TX X7092- 6626 US/AC-XXXX0000 5231 RFB=#108 OBI=INVOICE 108 -180K W HASHUT GENERATOR AND 900KW HASHHU T IMAD: 0702MMQFMPXXXX0293 TRN: XXXXXX1184 FF',
    249290.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0294', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-02',
    'Expense',
    'ONLINE INTERNATIONAL WIRE TRANSFER VIA: BANK OF AMERICA, N.A./0959 A/C: TORONTO-DOMINION BANK, THE TORONTO CANADA M5K 1A2 CA BEN: UPSTREAM DATA INC LLOYDMINSTER AB T9V2X1 CA REF: BUSINESS EXPENSES SSN: XXXX8639 TRN: XXXXXX4184 ES 07/02',
    0.0, 228986.69, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000582', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0294'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ONLINE INTERNATIONAL WIRE TRANSFER VIA: BANK OF AMERICA, N.A./0959 A/C: TORONTO-DOMINION BANK, THE TORONTO CANADA M5K 1A2 CA BEN: UPSTREAM DATA INC LLOYDMINSTER AB T9V2X1 CA REF: BUSINESS EXPENSES SSN: XXXX8639 TRN: XXXXXX4184 ES 07/02',
    228986.69, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0295', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-03',
    'Expense',
    'CORPUS MM/GAS 0 CORPUS CHRIS TX 07/03',
    0.0, 501.33000000000004, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000583', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0295'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CORPUS MM/GAS 0 CORPUS CHRIS TX 07/03',
    71.88, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000584', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0295'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SERVICE CHARGES FOR THE MONTH OF JUNE',
    35.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000585', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0295'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TST* SMOLIKS SMOKEHOUSE Mathis TX 07/03',
    28.94, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000586', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0295'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NAPA MATHIS MATHIS TX 07/03',
    154.54, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000587', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0295'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NAPA MATHIS MATHIS TX 07/03',
    7.57, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000588', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0295'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LOWE''S #1825 CORPUS CHRSTI TX XX4487 07/03',
    203.4, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0296', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-06',
    'Expense',
    'ORIG CO NAME:IPFSXXX-XXX-2621 ORIG ID:0 ADXXX4370 DESC DATE: CO ENTRY DESCR:IPFSPMTTXPSEC:CCD TRACE#:XXXXXXXX1311125 EED:240708 IND ID:62397 IND NAME:10 NET ZERO INC. GDxLk2vV TRN: XXXXXX1125 TC',
    0.0, 651.5799999999999, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000589', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0296'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:IPFSXXX-XXX-2621 ORIG ID:0 ADXXX4370 DESC DATE: CO ENTRY DESCR:IPFSPMTTXPSEC:CCD TRACE#:XXXXXXXX1311125 EED:240708 IND ID:62397 IND NAME:10 NET ZERO INC. GDxLk2vV TRN: XXXXXX1125 TC',
    559.66, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000590', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0296'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WM SUPERCENTER #4111 RICHMOND TX XX3060 07/06',
    91.92, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0297', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-07',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX3725 07/07',
    0.0, 250.29999999999998, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000591', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0297'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX3725 07/07',
    10.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000592', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0297'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MINUTEKEY BOULDER CO 07/07',
    8.66, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000593', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0297'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BEST BUY XXXX5172 RICHMOND TX 07/07',
    231.64, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0298', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-08',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX0469 07/08',
    0.0, 18.52, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000594', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0298'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX0469 07/08',
    10.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000595', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0298'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ARLO TECHNOLOGIES INC XXX-XXX-3750 CA 07/09',
    8.52, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0299', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-09',
    'Expense',
    'JACK IN THE BOX 3901 HOUSTON TX 07/09',
    0.0, 35.6, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000596', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0299'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'JACK IN THE BOX 3901 HOUSTON TX 07/09',
    15.35, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000597', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0299'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NETLIFY HTTPSWWW.NETL CA 07/09',
    20.25, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0300', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-10',
    'Expense',
    'LOVE''S #0290 OUTSIDE LUFKIN TX 07/10',
    0.0, 92.22, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000598', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0300'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LOVE''S #0290 OUTSIDE LUFKIN TX 07/10',
    76.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000599', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0300'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ADOBE *XXX-XXX-6687 ADOBE.LY/ENUS CA 07/11',
    16.22, false
) ON CONFLICT (line_id_display) DO NOTHING;

