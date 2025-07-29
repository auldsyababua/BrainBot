-- Journal Entries Batch 11

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0501', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-14',
    'Expense',
    'Online ACH Payment XXXXXXX0351 To MartinLegal (_#####2006)',
    0.0, 840.19, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001125', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0501'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX0351 To MartinLegal (_#####2006)',
    840.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001126', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0501'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'INTUIT *QBooks Onlin CL.INTUIT.COM CA 11/13',
    0.19, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0502', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-14',
    'Check',
    'CHECK # 5670',
    0.0, 1900.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001127', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0502'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CHECK # 5670',
    1900.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0503', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-15',
    'Expense',
    'TACTACAM WWW.REVEALCEL MN 02/15',
    0.0, 18.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001128', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0503'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TACTACAM WWW.REVEALCEL MN 02/15',
    9.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001129', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0503'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TACTACAM WWW.REVEALCEL MN 02/15',
    9.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0504', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-17',
    'Expense',
    'CIRCLE K #XXX0595 RIVERSIDE TX XX1442 02/17',
    0.0, 117.78999999999999, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001130', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0504'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX0595 RIVERSIDE TX XX1442 02/17',
    45.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001131', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0504'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CHIPOTLE 0170 HOUSTON TX 02/17',
    22.79, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001132', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0504'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BROOKSHIRE BROTHERS #8 CROCKETT TX XX6896 02/17',
    50.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0505', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-18',
    'Expense',
    'WAL-MART #4111 RICHMOND TX XX1300 02/18',
    0.0, 61.89, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001133', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0505'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WAL-MART #4111 RICHMOND TX XX1300 02/18',
    61.89, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0506', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-19',
    'Expense',
    'BUC-EE''S 24 XXX-XXX-6390 TX 02/19',
    0.0, 2388.34, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001134', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0506'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 02/19',
    45.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001135', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0506'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX4220 To UNITED RENTALS (NORTH AMERICA),INC. 02/19',
    2262.21, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001136', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0506'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'FEDEXXXXXX3729 XXX-XXX3339 TN 02/20',
    81.13, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0507', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-20',
    'Expense',
    'TX.GOV*SERVICEFEE-DI WWW.TEXAS.GOV TX 02/20',
    0.0, 5373.93, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001137', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0507'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TX.GOV*SERVICEFEE-DI WWW.TEXAS.GOV TX 02/20',
    6.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001138', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0507'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250220 CO ENTRY DESCR:NET XX2394SEC:CCD TRACE#:XXXXXXXX0705880 EED:250220 IND ID:6 semk3nvpst IND NAME:10NetZero, Inc. 6semjncmfjq TRN: XXXXXX5880 TC',
    3280.67, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001139', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0507'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250220 CO ENTRY DESCR:TAX XX2424SEC:CCD TRACE#:XXXXXXXX0730773 EED:250220 IND ID:6 semk3nvpsu IND NAME:10NetZero, Inc. 6semjncmfko TRN: XXXXXX0773 TC',
    1204.73, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001140', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0507'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'FORT BEND VEHREG WWW.TEXAS.GOV TX 02/20',
    574.75, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001141', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0507'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'J & W PARTS EAGLE LAKE TX 02/20',
    179.76, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001142', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0507'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'J & W PARTS EAGLE LAKE TX 02/20',
    128.02, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0508', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-21',
    'Deposit',
    'J & W PARTS EAGLE LAKE TX 02/21',
    244.57, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001143', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0508'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'J & W PARTS EAGLE LAKE TX 02/21',
    244.57, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0509', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-21',
    'Expense',
    'O''REILLY 6123 EAGLE LAKE TX 02/21',
    0.0, 529.02, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001144', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0509'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'O''REILLY 6123 EAGLE LAKE TX 02/21',
    242.33, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001145', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0509'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'APPLE LUMBER BRANCH 40 EAGLE LAKE TX XX5596 02/21',
    6.32, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001146', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0509'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TAQUERIA AZTECA D.F EAGLE LAKE TX 02/21',
    57.39, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001147', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0509'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'APPLE LUMBER BRANCH 40 EAGLE LAKE TX XX8523 02/21',
    222.98, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0510', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-24',
    'Expense',
    'CIRCLE K #XXX2369 HOUSTON TX XX1769 02/24',
    0.0, 126.87, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001148', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0510'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX2369 HOUSTON TX XX1769 02/24',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001149', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0510'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'PHOENICIA MKT BAR HOUSTON TX 02/24',
    15.59, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001150', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0510'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'J & K KORNER STORE EAGLE LAKE TX XX9516 02/24',
    66.28, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001151', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0510'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'X1538-HOUSTON CENTER GA HOUSTON TX 02/24',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0511', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-25',
    'Expense',
    'Online ACH Payment XXXXXXX0977 To Zedcire (_########0274)',
    0.0, 11618.35, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001152', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0511'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX0977 To Zedcire (_########0274)',
    2435.63, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001153', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0511'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'DARK HORSE CPAS WWW.DARKHORSE CA 02/25',
    2500.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001154', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0511'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX0489 To MaximalistIII (_####9857)',
    5500.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001155', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0511'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX1411 To Zedcire (_########0274)',
    1104.15, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001156', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0511'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX3838 To Zedcire (_########0274)',
    78.57, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0512', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-26',
    'Expense',
    'TST*TACOS DONA LENA Houston TX 02/26',
    0.0, 1788.45, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001157', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0512'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TST*TACOS DONA LENA Houston TX 02/26',
    34.21, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001158', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0512'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'FEDEXXXXXX5675 XXX-XXX3339 TN 02/27',
    1754.24, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0513', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-27',
    'Expense',
    'CORPUS MM/GAS XX0273 CORPUS CHRIS TX XX9531 02/27',
    0.0, 7609.3, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001159', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0513'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CORPUS MM/GAS XX0273 CORPUS CHRIS TX XX9531 02/27',
    74.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001160', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0513'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX2209 To Kebo Oil and Gas, INC 02/27',
    2162.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001161', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0513'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # X6983 MATHIS TX XX5629 02/27',
    44.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001162', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0513'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCDONALD''S FX0850 MATHIS TX 02/27',
    6.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001163', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0513'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1403 ROSENBERG TX XX6977 02/27',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001164', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0513'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ATT*BILL PAYMENT XXX-XXX-2020 TX 02/28',
    559.27, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001165', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0513'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250227 CO ENTRY DESCR:NET XX2028SEC:CCD TRACE#:XXXXXXXX0527508 EED:250227 IND ID:6 semk3pkgj4 IND NAME:10NetZero, Inc. 6semjncsiic TRN: XXXXXX7508 TC',
    3280.67, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001166', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0513'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250227 CO ENTRY DESCR:TAX XX2096SEC:CCD TRACE#:XXXXXXXX0525579 EED:250227 IND ID:6 semk3pkgj5 IND NAME:10NetZero, Inc. 6semjncsikg TRN: XXXXXX5579 TC',
    1204.73, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001167', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0513'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BEST BUY XXXX6031 VICTORIA TX XX2038 02/27',
    238.13, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0514', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-04',
    'Invoice',
    'Invoice - 2025-03-04',
    3332.33, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001168', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0514'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    3332.33, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0515', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-04',
    'Invoice',
    'Invoice - 2025-03-04',
    3110.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001169', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0515'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    3110.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0516', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-04',
    'Expense',
    'BUC-EE''S 24 XXX-XXX-6390 TX 03/04',
    0.0, 162.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001170', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0516'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 03/04',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001171', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0516'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'FOREMAN.MN FOREMAN.MN MD 03/05',
    132.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0517', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-04',
    'Invoice',
    'Invoice - 2025-03-04',
    6759.74, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001172', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0517'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    6759.74, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0518', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-05',
    'Expense',
    'SERVICE CHARGES FOR THE MONTH OF FEBRUARY',
    0.0, 146.99, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001173', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0518'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SERVICE CHARGES FOR THE MONTH OF FEBRUARY',
    51.05, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001174', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0518'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4007 DESC DATE:250305 CO ENTRY DESCR:FEE XX0183SEC:CCD TRACE#:XXXXXXXX1590107 EED:250305 IND ID:6 semk3s5sqo IND NAME:10NetZero, Inc. 6semjnd526n TRN: XXXXXX0107 TC',
    95.94, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0519', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-05',
    'Payment',
    'Payment - 2025-03-05',
    3332.33, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001175', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0519'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    3332.33, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0520', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-07',
    'Deposit',
    'Online Transfer from CHK ...5317 transaction#: XXXXXXX2766',
    66412.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001176', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0520'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Transfer from CHK ...5317 transaction#: XXXXXXX2766',
    66412.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0521', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-07',
    'Expense',
    'ARLO TECHNOLOGIES INC XXX-XXX-3750 CA 03/09',
    0.0, 68856.57, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001177', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0521'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ARLO TECHNOLOGIES INC XXX-XXX-3750 CA 03/09',
    10.65, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001178', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0521'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'EXPEDIA XXXXXXXXXX9804 EXPEDIA.COM WA 03/07',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001179', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0521'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'UNITED XXXXXXX5567 UNITED.COM TX 03/07',
    1206.96, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001180', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0521'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'UNITED XXXXXXX5567 UNITED.COM TX 03/07',
    1206.96, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001181', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0521'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ONLINE INTERNATIONAL WIRE TRANSFER VIA: WELLSFARGO NY INTL/XXXXX5092 A/C: BOFMCAM2XXX MONTREAL H5A 1K8 CA BEN: POWERPRO SOLUTIONS CALGARY T3M2X2 CA REF: ESTIMAT E 214 BUSINESS EXPENSES IMAD: 0307MMQFMP2NXX2112 TRN: XXXXXX5066 ES 03/07',
    66412.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0522', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-09',
    'Expense',
    'NETLIFY NETLIFY.COM CA 03/09',
    0.0, 20.25, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001182', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0522'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NETLIFY NETLIFY.COM CA 03/09',
    20.25, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0523', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-10',
    'Deposit',
    'System-recorded deposit for QuickBooks Payments',
    37627.87, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001183', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0523'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'System-recorded deposit for QuickBooks Payments',
    37627.87, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0524', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-10',
    'Expense',
    'System-recorded fee for QuickBooks Payments. Fee-name: DiscountRateFee, fee-type: Daily.',
    0.0, 1977.48, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001184', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0524'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'System-recorded fee for QuickBooks Payments. Fee-name: DiscountRateFee, fee-type: Daily.',
    1053.58, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001185', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0524'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX1799 To Hard Core Supply LLC 03/10',
    902.26, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001186', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0524'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ADOBE *XXX-XXX-6687 ADOBE.LY/ENUS CA 03/11',
    21.64, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0525', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-10',
    'Payment',
    'Paid via QuickBooks Payments: Payment ID 252359',
    37627.87, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001187', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0525'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Paid via QuickBooks Payments: Payment ID 252359',
    37627.87, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0526', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-11',
    'Expense',
    'UNITED XXXXXXX3827 UNITED.COM TX 03/11',
    0.0, 1493.6299999999999, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001188', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0526'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'UNITED XXXXXXX3827 UNITED.COM TX 03/11',
    39.99, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001189', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0526'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'UNITED XXXXXXX3849 UNITED.COM TX 03/11',
    39.99, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001190', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0526'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'COUNTRY MART FULSHEAR TX 03/11',
    76.31, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001191', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0526'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'OPENAI OPENAI.COM CA 03/11',
    21.28, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001192', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0526'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX8814 To BitCruiser (_########1093)',
    1316.06, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0527', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-12',
    'Expense',
    'MISSOURI RENTAL AND LE SAINT LOUIS MO 03/16',
    0.0, 250.35, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001193', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0527'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MISSOURI RENTAL AND LE SAINT LOUIS MO 03/16',
    131.07, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001194', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0527'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BP#XXX7169AIRPORT BP ST. LOUIS MO XX7600 03/12',
    27.6, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001195', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0527'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'STARBUCKS X1390 IAH B20 HOUSTON TX 03/12',
    17.21, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001196', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0527'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MAGGIE OBRIENS XXX-XXX8906 MO 03/12',
    42.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001197', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0527'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'STEAK-N-SHAKE#0172 Q99 MT VERNON IL 03/12',
    9.99, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001198', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0527'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LOVE''S #0824 INSIDE MT. VERNON IL 03/12',
    8.51, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001199', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0527'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'STEAK-N-SHAKE#0172 Q99 MT VERNON IL 03/12',
    13.97, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0528', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-13',
    'Expense',
    'INTUIT *QBooks Onlin CL.INTUIT.COM CA 11/13',
    0.0, 14584.56, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001200', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0528'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'INTUIT *QBooks Onlin CL.INTUIT.COM CA 11/13',
    69.29, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001201', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0528'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'STARBUCKS A-05 STL ST. LOUIS MO 03/13',
    6.79, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001202', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0528'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250313 CO ENTRY DESCR:TAX XX4661SEC:CCD TRACE#:XXXXXXXX9952086 EED:250313 IND ID:6 semk3u91ef IND NAME:10NetZero, Inc. 6semjndbjl5 TRN: XXXXXX2086 TC',
    1204.77, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001203', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0528'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SQ *PRELUDE COFFEE & TE Houston TX 03/13',
    6.95, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001204', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0528'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX4034 To Chiron (_#####8441)',
    10000.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001205', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0528'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250313 CO ENTRY DESCR:NET XX5553SEC:CCD TRACE#:XXXXXXXX9952565 EED:250313 IND ID:6 semk3u91ee IND NAME:10NetZero, Inc. 6semjndbkh1 TRN: XXXXXX2565 TC',
    3280.65, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001206', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0528'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'THE HALAL GUYS DOWNTOWN HOUSTON TX 03/13',
    16.11, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0529', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-13',
    'Invoice',
    'Invoice - 2025-03-13',
    7792.75, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001207', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0529'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    7792.75, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0530', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-14',
    'Expense',
    'CIRCLE K #XXX2255 HOUSTON TX XX2426 03/14',
    0.0, 2950.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001208', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0530'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX2255 HOUSTON TX XX2426 03/14',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001209', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0530'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX1046 To Kebo Oil and Gas, INC 03/14',
    2850.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001210', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0530'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S #16 GIDDINGS TX 03/14',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001211', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0530'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Perry Brooks Garage Austin TX 03/14',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0531', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-14',
    'Invoice',
    'Invoice - 2025-03-14',
    17203.53, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001212', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0531'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    17203.53, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0532', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-15',
    'Expense',
    'LYFT *1 RIDE 03-12 HELP.LYFT.COM CA 03/15',
    0.0, 44.31, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001213', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0532'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LYFT *1 RIDE 03-12 HELP.LYFT.COM CA 03/15',
    26.31, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001214', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0532'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TACTACAM WWW.REVEALCEL MN 03/15',
    9.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001215', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0532'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TACTACAM WWW.REVEALCEL MN 03/15',
    9.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0533', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-17',
    'Invoice',
    'Invoice - 2025-03-17',
    14381.04, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001216', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0533'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    14381.04, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0534', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-17',
    'Payment',
    'Payment - 2025-03-17',
    7792.75, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001217', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0534'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    7792.75, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0535', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-18',
    'Expense',
    'BUC-EE''S 24 XXX-XXX-6390 TX 03/18',
    0.0, 575.1800000000001, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001218', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0535'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 03/18',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001219', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0535'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX2255 HOUSTON TX 03/18',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001220', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0535'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'J & W PARTS EAGLE LAKE TX 03/18',
    24.89, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001221', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0535'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'J & W PARTS EAGLE LAKE TX 03/18',
    453.85, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001222', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0535'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'J & W PARTS EAGLE LAKE TX 03/18',
    7.57, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001223', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0535'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TAQUERIA AZTECA D.F EAGLE LAKE TX 03/18',
    38.87, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0536', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-19',
    'Expense',
    'CIRCLE K # X6979 REFUGIO TX XX8737 03/19',
    0.0, 175.54, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001224', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0536'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # X6979 REFUGIO TX XX8737 03/19',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001225', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0536'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # X6979 REFUGIO TX XX8427 03/19',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001226', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0536'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WHATABURGER 319 Q26 REFUGIO TX 03/19',
    15.04, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001227', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0536'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LA RIBERA TAQUERIA & RE REFUGIO TX 03/19',
    14.85, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001228', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0536'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SUNOCO XXXXXX3800 CORPUS CHRIST TX 03/19',
    85.65, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0537', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-19',
    'Payment',
    'Payment - 2025-03-19',
    14381.04, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001229', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0537'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    14381.04, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0538', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-20',
    'Expense',
    'CHEVRON XXX3622 NACOGDOCHES TX 03/20',
    0.0, 7.12, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001230', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0538'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CHEVRON XXX3622 NACOGDOCHES TX 03/20',
    7.12, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0539', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-21',
    'Expense',
    'O''REILLY 6123 EAGLE LAKE TX XX7297 03/21',
    0.0, 320.36999999999995, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001231', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0539'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'O''REILLY 6123 EAGLE LAKE TX XX7297 03/21',
    208.79, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001232', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0539'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S 24 XXX-XXX-6390 TX 03/21',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001233', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0539'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TAQUERIA AZTECA D.F EAGLE LAKE TX 03/21',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001234', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0539'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'APPLE LUMBER BRANCH 40 EAGLE LAKE TX XX9466 03/21',
    51.58, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0540', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-22',
    'Expense',
    'TEXAN # 8 VICTORIA VICTORIA TX XX3610 03/22',
    0.0, 70.28, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001235', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0540'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TEXAN # 8 VICTORIA VICTORIA TX XX3610 03/22',
    70.28, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0541', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-23',
    'Invoice',
    'Invoice - 2025-03-23',
    17310.41, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001236', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0541'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    17310.41, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0542', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-24',
    'Expense',
    'Online ACH Payment XXXXXXX9953 To JohnSchillereff (_#####5067)',
    0.0, 46104.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001237', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0542'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX9953 To JohnSchillereff (_#####5067)',
    33493.91, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001238', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0542'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S #30 WHARTON TX 03/24',
    29.6, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001239', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0542'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX0113 To 2WServices (_###4108)',
    12580.49, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0543', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-25',
    'Expense',
    'CIRCLE K #XXX2369 HOUSTON TX XX5666 03/25',
    0.0, 55.41, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001240', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0543'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX2369 HOUSTON TX XX5666 03/25',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001241', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0543'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'JERSEY MIKES X5204 WILLIS TX 03/25',
    15.41, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0544', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-27',
    'Invoice',
    'Invoice - 2025-03-27',
    960.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001242', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0544'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    960.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0545', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-27',
    'Expense',
    'CIRCLE K #XXX2369 HOUSTON TX XX8345 03/27',
    0.0, 21052.89, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001243', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0545'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX2369 HOUSTON TX XX8345 03/27',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001244', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0545'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ONLINE DOMESTIC WIRE TRANSFER VIA: WELLS FARGO NA/XXXXX0248 A/C: MUSTANG MACHINERY COMPANY HOUSTON TX X7210 US REF: JOB NUMBER UEIDX0493/TIME/14:20 IMAD: 0327MM QFMP2NXX9803 TRN: XXXXXX5086 ES 03/27',
    21001.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001245', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0545'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Subway X3623 Trinity TX 03/27',
    11.89, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0546', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-27',
    'Invoice',
    'Invoice - 2025-03-27',
    726.41, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001246', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0546'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    726.41, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0547', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-27',
    'Payment',
    'Payment - 2025-03-27',
    18996.82, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001247', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0547'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    17310.41, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001248', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0547'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    726.41, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001249', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0547'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    960.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0548', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-28',
    'Expense',
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250328 CO ENTRY DESCR:REM XX2041SEC:CCD TRACE#:XXXXXXXX0365939 EED:250328 IND ID:6 semk4220fa IND NAME:10NetZero, Inc. 6semjndstnp TRN: XXXXXX5939 TC',
    0.0, 12485.4, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001250', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0548'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250328 CO ENTRY DESCR:REM XX2041SEC:CCD TRACE#:XXXXXXXX0365939 EED:250328 IND ID:6 semk4220fa IND NAME:10NetZero, Inc. 6semjndstnp TRN: XXXXXX5939 TC',
    8000.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001251', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0548'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250328 CO ENTRY DESCR:TAX XX2432SEC:CCD TRACE#:XXXXXXXX0366841 EED:250328 IND ID:6 semk4220f9 IND NAME:10NetZero, Inc. 6semjndsu40 TRN: XXXXXX6841 TC',
    1204.73, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001252', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0548'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250328 CO ENTRY DESCR:NET XX2204SEC:CCD TRACE#:XXXXXXXX0366133 EED:250328 IND ID:6 semk4220f8 IND NAME:10NetZero, Inc. 6semjndstss TRN: XXXXXX6133 TC',
    3280.67, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0549', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-31',
    'Expense',
    'FOSSATIS DELICATESSEN VICTORIA TX 03/31',
    0.0, 91.52, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001253', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0549'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'FOSSATIS DELICATESSEN VICTORIA TX 03/31',
    31.52, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001254', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0549'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TEXAN # 8 VICTORIA VICTORIA TX XX9400 03/31',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001255', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0549'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX2255 HOUSTON TX 03/31',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0550', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-02',
    'Expense',
    'CIRCLE K #XXX2369 HOUSTON TX 04/02',
    0.0, 1416.14, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001256', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0550'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX2369 HOUSTON TX 04/02',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001257', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0550'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'PANDA EXPRESS #1900 HOUSTON TX 04/02',
    13.53, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001258', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0550'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCDONALD''S F2856 HOUSTON TX 04/02',
    5.41, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001259', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0550'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCCOYS #96 EL CAMPO TX 04/02',
    1357.2, false
) ON CONFLICT (line_id_display) DO NOTHING;

