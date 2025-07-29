-- Journal Entries Batch 5

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0201', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-13',
    'Expense',
    'BUC-EE''S #34 BAYTOWN TX 03/13',
    0.0, 432.37, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000356', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0201'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S #34 BAYTOWN TX 03/13',
    74.76, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000357', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0201'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCCOYS #57 TOMBALL TX 03/13',
    112.54, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000358', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0201'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCCOYS #57 TOMBALL TX 03/13',
    225.07, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000359', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0201'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '9235 CLAY ROAD HOUSTON TX 03/13',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0202', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-14',
    'Expense',
    'CIRCLE K #XXX1916 HOCKLEY TX XX8022 03/14',
    0.0, 9070.55, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000360', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0202'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1916 HOCKLEY TX XX8022 03/14',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000361', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0202'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ATM WITHDRAWAL XX9821 03/XXX4202 FM - Driver Fees',
    500.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000362', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0202'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:RIGGING & WELDIN ORIG ID:XXXXXX6202 DESC DATE:240314 CO ENTRY DESCR:SALE SEC:WEB TRACE#:XXXXXXXX5525076 EED:240314 IND ID: IND NAME:10 NET ZERO TRN : XXXXXX5076TC',
    1688.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000363', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0202'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'THE HOME DEPOT #6525 HOUSTON TX XX5079 03/14',
    102.55, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000364', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0202'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WITHDRAWAL 03/14',
    6750.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0203', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-18',
    'Expense',
    'MURPHY EXPRESS TOMBALL TX 03/18',
    0.0, 20480.92, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000365', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0203'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MURPHY EXPRESS TOMBALL TX 03/18',
    76.18, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000366', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0203'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCCOYS #57 TOMBALL TX 03/18',
    108.24, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000367', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0203'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX3120 To MBX (_#####6908)',
    15749.8, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000368', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0203'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX9435 To JustinBallardLaw (_########9126)',
    1300.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000369', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0203'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ULINE *SHIP SUPPLIES XXX-XXX-5510 WI 03/19',
    527.19, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000370', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0203'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX8491 To UnitedOFS (_#####2100)',
    1312.06, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000371', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0203'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WAL-MART SUPER CENTER TOMBALL TX 03/18',
    145.8, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000372', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0203'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'EMPOWER: ENERGIZING. HTTPSWWW.DIGI TX 03/18',
    1261.65, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0204', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-19',
    'Expense',
    'CHICK-FIL-A #X1244 TOMBALL TX 03/19',
    0.0, 2925.09, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000373', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0204'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CHICK-FIL-A #X1244 TOMBALL TX 03/19',
    25.09, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000374', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0204'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SQ *SAMSON PUMP & SUPPL Alice TX 03/19',
    1400.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000375', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0204'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:Express Transpor ORIG ID:204876018 DESC DATE:Mar 19 CO ENTRY DESCR:10 net zerSEC:CCD TRACE#:XXXXXXXX6006399 EED:240319 IND ID:5 -X7437 IND NAME:10 n et zero TRN: XXXXXX6399 TC',
    1500.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0205', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-20',
    'Expense',
    'BUC-EE''S #30 WHARTON TX 03/20',
    0.0, 2015.04, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000376', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0205'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S #30 WHARTON TX 03/20',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000377', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0205'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # X6979 217 N REFUGIO TX 03/20',
    35.02, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000378', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0205'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'PP*T GREEN SVCS HOUSTON TX 03/20',
    1920.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000379', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0205'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '9235 CLAY ROAD HOUSTON TX 03/20',
    40.02, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0206', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-21',
    'Expense',
    'CIRCLE K # X6979 217 N REFUGIO TX 03/21',
    0.0, 10090.63, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000380', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0206'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # X6979 217 N REFUGIO TX 03/21',
    1.07, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000381', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0206'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX8636 To CactusTanks (_####0979)',
    7168.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000382', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0206'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TEXAN # 8 VICTO VICTORIA TX 03/21',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000383', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0206'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TEXAN # 8 VICTO VICTORIA TX 03/21',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000384', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0206'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'POSTAL ANNEX X9014 KATY TX XX1883 03/21',
    50.79, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000385', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0206'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX0888 To P3Elevation (_########3380)',
    2200.77, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000386', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0206'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'H-E-B #160 MATHIS TX XX2702 03/21',
    100.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000387', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0206'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'H-E-B #160 MATHIS TX XX5861 03/21',
    500.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0207', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-22',
    'Deposit',
    'BOOK TRANSFER CREDIT B/O: HEATCORE INC FRISCO TX XXXXX-9485 US TRN: XXXXXX4082 ES',
    20922.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000388', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0207'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BOOK TRANSFER CREDIT B/O: HEATCORE INC FRISCO TX XXXXX-9485 US TRN: XXXXXX4082 ES',
    20922.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0208', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-22',
    'Expense',
    'MCCOYS #57 TOMBALL TX 03/22',
    0.0, 220.58999999999997, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000389', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0208'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCCOYS #57 TOMBALL TX 03/22',
    180.73, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000390', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0208'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCCOYS #57 TOMBALL TX 03/22',
    39.86, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0209', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-25',
    'Expense',
    'CIRCLE K # X1486 X7137 TOMBALL TX 03/25',
    0.0, 1491.97, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000391', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0209'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # X1486 X7137 TOMBALL TX 03/25',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000392', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0209'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CHICK-FIL-A #X1244 TOMBALL TX 03/25',
    21.97, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000393', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0209'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'PP*T GREEN SVCS HOUSTON TX 03/25',
    1050.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000394', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0209'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ATM WITHDRAWAL XX3777 03/XXX4202 FM',
    400.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0210', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-26',
    'Check',
    'CHECK # 5668',
    0.0, 10312.13, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000395', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0210'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CHECK # 5668',
    10312.13, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0211', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-26',
    'Check',
    'CHECK # 5674',
    0.0, 7347.5, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000396', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0211'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CHECK # 5674',
    7347.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0212', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-26',
    'Check',
    'CHECK # 5675 - Dec Gas payment',
    0.0, 430.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000397', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0212'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CHECK # 5675 - Dec Gas payment',
    430.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0213', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-26',
    'Deposit',
    'FEDWIRE CREDIT VIA: GUARANTY BANK & TRUST, N.A./XXXXX5327 B/O: OPERATION ORANGE LLC FORT WORTH TX X6109 REF: CHASE NYC/CTR/BNF=10NETZERO, INC. HOUSTON TX X7092- 6626 US/AC-XXXX0000 5231 RFB=O/B GUARANTY BK& OBI=INVOI CE 121 IMAD: 0326GMQFMPXXXX1572 TRN: XXXXXX1086 FF',
    69793.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000398', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0213'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'FEDWIRE CREDIT VIA: GUARANTY BANK & TRUST, N.A./XXXXX5327 B/O: OPERATION ORANGE LLC FORT WORTH TX X6109 REF: CHASE NYC/CTR/BNF=10NETZERO, INC. HOUSTON TX X7092- 6626 US/AC-XXXX0000 5231 RFB=O/B GUARANTY BK& OBI=INVOI CE 121 IMAD: 0326GMQFMPXXXX1572 TRN: XXXXXX1086 FF',
    69793.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0214', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-26',
    'Check',
    'CHECK # 5676',
    0.0, 3475.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000399', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0214'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CHECK # 5676',
    3475.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0215', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-27',
    'Expense',
    'Online ACH Payment XXXXXXX2307 To Bernardo (_######3816)',
    0.0, 13075.359999999999, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000400', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0215'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX2307 To Bernardo (_######3816)',
    12997.4, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000401', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0215'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LYFT *2 RIDES 03-2 HELP.LYFT.COM CA 03/29',
    44.96, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000402', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0215'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'GRADUALLYTHENSUDDENL GRADUALLYTHEN TX 03/27',
    33.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0216', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-28',
    'Expense',
    'Online ACH Payment XXXXXXX2307 To Bernardo (_######3816)',
    0.0, 42143.7, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000403', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0216'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX2307 To Bernardo (_######3816)',
    9680.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000404', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0216'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX3561 To McKainPower (_######4723)',
    24438.7, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000405', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0216'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX1613 To P3Elevation (_########3380)',
    6800.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000406', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0216'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Zelle payment to Fernando JPM99aefwldc',
    1225.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0217', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-30',
    'Expense',
    'ATT*BILL PAYMENT XXX-XXX-2020 TX 03/30',
    0.0, 242.91, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000407', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0217'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ATT*BILL PAYMENT XXX-XXX-2020 TX 03/30',
    242.91, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0218', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-01',
    'Expense',
    'BUC-EE''S #30 WHARTON TX 04/01',
    0.0, 85.35, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000408', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0218'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S #30 WHARTON TX 04/01',
    80.57, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000409', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0218'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'H-E-B #160 MATHIS TX XX2574 04/01',
    4.78, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0219', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-02',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX5985 04/02',
    0.0, 363.76, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000410', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0219'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX5985 04/02',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000411', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0219'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S #30 OUTSIDE WHARTON TX XX9719 04/02',
    88.1, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000412', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0219'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1495 KINGWOOD TX XX5508 04/02',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000413', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0219'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ALAMO LUMBER COMPANY M MATHIS TX XX2395 04/02',
    205.66, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0220', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-03',
    'Expense',
    'BUC-EE''S #30 WHARTON TX 04/02',
    0.0, 34842.34, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000414', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0220'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S #30 WHARTON TX 04/02',
    74.84, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000415', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0220'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SERVICE CHARGES FOR THE MONTH OF MARCH',
    17.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000416', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0220'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ONLINE DOMESTIC WIRE TRANSFER A/C: HEATCORE INC FRISCO TX XXXXX-9485 US REF: INVOICE XX0401 TRN: XXXXXX4094 ES 04/03',
    34750.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0221', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-04',
    'Expense',
    'IN *SPINDLETOP ENERGY XXX-XXX5863 TX 04/04',
    0.0, 200342.33, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000417', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0221'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'IN *SPINDLETOP ENERGY XXX-XXX5863 TX 04/04',
    342.33, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000418', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0221'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'DOMESTIC WIRE TRANSFER VIA: PNCBANK PITT/XXXXX0096 A/C: ACARI RESOURCES LTD. IMAD: 0404MMQFMP2MXX1835 TRN: XXXXXX4095 ES 04/04',
    200000.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0222', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-05',
    'Expense',
    'CHICK-FIL-A #X3312 BEAUMONT TX 04/05',
    0.0, 622.8199999999999, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000419', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0222'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CHICK-FIL-A #X3312 BEAUMONT TX 04/05',
    13.16, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000420', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0222'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:IPFSXXX-XXX-2621 ORIG ID:0 ADXXX4370 DESC DATE: CO ENTRY DESCR:IPFSPMTTXPSEC:CCD TRACE#:XXXXXXXX0910291 EED:240405 IND ID:62397 IND NAME:10 NET ZERO INC. GDxLk2vV TRN: XXXXXX0291 TC',
    559.66, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000421', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0222'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SPEEDY STOP 18 BEAUMONT TX 04/05',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000422', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0222'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '9235 CLAY ROAD HOUSTON TX 04/05',
    10.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0223', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-08',
    'Expense',
    'PANDADOC, INC. XXX-XXX-8755 CA 04/08',
    0.0, 1177.29, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000423', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0223'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'PANDADOC, INC. XXX-XXX-8755 CA 04/08',
    69.29, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000424', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0223'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX0230 To BobcatCrane (_####4024)',
    1108.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0224', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-09',
    'Expense',
    'EL TIEMPO CANTINA WASH XXX-XXX3645 TX 04/08',
    0.0, 4921.93, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000425', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0224'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'EL TIEMPO CANTINA WASH XXX-XXX3645 TX 04/08',
    56.93, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000426', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0224'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX0351 To MartinLegal (_#####2006)',
    4865.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0225', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-10',
    'Expense',
    'ADOBE *ADOBE XXX-XXX-6000 CA 04/10',
    0.0, 68.42, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000427', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0225'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ADOBE *ADOBE XXX-XXX-6000 CA 04/10',
    21.64, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000428', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0225'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WAL-MART #4111 RICHMOND TX 04/10',
    46.78, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0226', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-12',
    'Expense',
    'ORIG CO NAME:ROLLO INSURANCE ORIG ID:XXXXXX3381 DESC DATE: CO ENTRY DESCR:J2125 OOFFSEC:CCD TRACE#:XXXXXXXX7366559 EED:240412 IND ID:CZXX0006QXNPC IND NAME:10 N ET ZERO INC TRN*1 *CZXX0006QXNPC\RMR*IK*CABE092A B561 4CBC B77B 009B0B\ TRN: XXXXXX6559 TC',
    0.0, 3129.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000429', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0226'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:ROLLO INSURANCE ORIG ID:XXXXXX3381 DESC DATE: CO ENTRY DESCR:J2125 OOFFSEC:CCD TRACE#:XXXXXXXX7366559 EED:240412 IND ID:CZXX0006QXNPC IND NAME:10 N ET ZERO INC TRN*1 *CZXX0006QXNPC\RMR*IK*CABE092A B561 4CBC B77B 009B0B\ TRN: XXXXXX6559 TC',
    3129.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0227', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-14',
    'Expense',
    'TST* MARQUIS II HOUSTON TX 04/14',
    0.0, 6.31, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000430', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0227'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TST* MARQUIS II HOUSTON TX 04/14',
    6.31, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0228', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-15',
    'Expense',
    '7-ELEVEN HOUSTON TX 04/15',
    0.0, 20.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000431', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0228'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN HOUSTON TX 04/15',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0229', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-16',
    'Expense',
    '7-ELEVEN X1261 CYPRESS TX 04/16',
    0.0, 15334.81, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000432', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0229'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '7-ELEVEN X1261 CYPRESS TX 04/16',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000433', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0229'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX2293 To Kebo Oil and Gas, INC 04/16',
    6109.05, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000434', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0229'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX6028 To Hard Core Supply LLC 04/16',
    190.52, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000435', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0229'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX0670 To Hard Core Supply LLC 04/16',
    1035.83, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000436', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0229'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX5143 To Hard Core Supply LLC 04/16',
    2240.32, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000437', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0229'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX0663 To Lagarto Rental Tools, Inc 04/16',
    3717.24, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000438', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0229'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX3149 To 2W Services 04/16',
    977.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000439', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0229'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX6581 To HadCo Services 04/16',
    1044.35, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0230', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-18',
    'Expense',
    'CHICK-FIL-A #X1244 TOMBALL TX 04/18',
    0.0, 10.77, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000440', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0230'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CHICK-FIL-A #X1244 TOMBALL TX 04/18',
    10.77, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0231', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-19',
    'Expense',
    'Online ACH Payment XXXXXXX2307 To Bernardo (_######3816)',
    0.0, 4452.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000441', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0231'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX2307 To Bernardo (_######3816)',
    952.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000442', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0231'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX8996 To Jimmy Canton 04/19 - Gas Meter',
    3500.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0232', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-22',
    'Check',
    'CHECK # 1140',
    0.0, 1125.6, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000443', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0232'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CHECK # 1140',
    1125.6, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0233', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-22',
    'Expense',
    'Online ACH Payment XXXXXXX0245 To MckainRentals (_######4889)',
    0.0, 34796.799999999996, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000444', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0233'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX0245 To MckainRentals (_######4889)',
    23688.7, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000445', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0233'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX3319 To McKainPower (_######4723)',
    10313.83, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000446', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0233'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX0790 To United Oilfield Services 04/22',
    794.27, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0234', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-23',
    'Expense',
    'HOLT CAT-MC CORPUS CHRIST TX 04/23',
    0.0, 4651.51, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000447', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0234'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'HOLT CAT-MC CORPUS CHRIST TX 04/23',
    1833.55, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000448', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0234'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'HOLT CAT-MC XXX-XXX-2200 TX 04/23',
    2817.96, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0235', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-24',
    'Expense',
    'CHICK-FIL-A #X1244 TOMBALL TX 04/24',
    0.0, 2168.35, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000449', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0235'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CHICK-FIL-A #X1244 TOMBALL TX 04/24',
    26.35, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000450', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0235'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX5822 To Bernardo (_######3816)',
    2142.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0236', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-25',
    'Deposit',
    'Online Transfer from CHK ...5317 transaction#: XXXXXXX5149',
    150000.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000451', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0236'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Transfer from CHK ...5317 transaction#: XXXXXXX5149',
    150000.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0237', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-25',
    'Expense',
    'WITHDRAWAL 04/25 - Generator Repair Tomball',
    0.0, 40000.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000452', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0237'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WITHDRAWAL 04/25 - Generator Repair Tomball',
    40000.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0238', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-29',
    'Expense',
    'ATT* BILL PAYMENT XXX-XXX-0500 TX 04/29',
    0.0, 242.68, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000453', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0238'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ATT* BILL PAYMENT XXX-XXX-0500 TX 04/29',
    242.68, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0239', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-30',
    'Expense',
    'MURPHY7671ATWAL KATY TX 04/30',
    0.0, 20.01, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000454', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0239'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MURPHY7671ATWAL KATY TX 04/30',
    20.01, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0240', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-02',
    'Expense',
    'LinkedIn SN XXXXXX4626 XXX-XXX5653 CA 05/02',
    0.0, 106.59, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000455', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0240'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LinkedIn SN XXXXXX4626 XXX-XXX5653 CA 05/02',
    106.59, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0241', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-03',
    'Expense',
    'STAR STOP X0231 CLAY R HOUSTON TX 05/03',
    0.0, 8621.74, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000456', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0241'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'STAR STOP X0231 CLAY R HOUSTON TX 05/03',
    45.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000457', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0241'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SERVICE CHARGES FOR THE MONTH OF APRIL',
    25.45, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000458', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0241'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCDONALD''S FX9431 CYPRESS TX 05/03',
    8.32, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000459', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0241'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX8090 To 2W Services 05/03',
    6369.69, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000460', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0241'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ULINE *SHIP SUPPLIES XXX-XXX-5510 WI 05/04',
    2173.28, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0242', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-06',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX7787 05/06',
    0.0, 19.3, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000461', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0242'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX7787 05/06',
    10.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000462', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0242'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCDONALD''S FX9431 CYPRESS TX 05/06',
    9.3, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0243', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-07',
    'Expense',
    'ORIG CO NAME:IPFSXXX-XXX-2621 ORIG ID:0 ADXXX4370 DESC DATE: CO ENTRY DESCR:IPFSPMTTXPSEC:CCD TRACE#:XXXXXXXX7906413 EED:240507 IND ID:62397 IND NAME:10 NET ZERO INC. GDxLk2vV TRN: XXXXXX6413 TC',
    0.0, 559.66, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000463', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0243'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:IPFSXXX-XXX-2621 ORIG ID:0 ADXXX4370 DESC DATE: CO ENTRY DESCR:IPFSPMTTXPSEC:CCD TRACE#:XXXXXXXX7906413 EED:240507 IND ID:62397 IND NAME:10 NET ZERO INC. GDxLk2vV TRN: XXXXXX6413 TC',
    559.66, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0244', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-08',
    'Expense',
    'PANDADOC, INC. XXX-XXX-8755 CA 05/08',
    0.0, 69.29, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000464', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0244'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'PANDADOC, INC. XXX-XXX-8755 CA 05/08',
    69.29, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0245', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-09',
    'Expense',
    'NETLIFY HTTPSWWW.NETL CA 05/09',
    0.0, 1.25, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000465', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0245'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NETLIFY HTTPSWWW.NETL CA 05/09',
    1.25, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0246', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-13',
    'Expense',
    'PAPA JOHNS #X0035 LETHBRIDGE AB 05/13 CA DOLLAR 48.78 X 0.XXX7023 (EXCHG RTE)',
    0.0, 35.79, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000466', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0246'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'PAPA JOHNS #X0035 LETHBRIDGE AB 05/13 CA DOLLAR 48.78 X 0.XXX7023 (EXCHG RTE)',
    35.79, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0247', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-15',
    'Deposit',
    'Reversal: PAPA JOHNS #X0035 LETHBRIDGE AB 05/13 CA DOLLAR 48.78 X 0.XXX7023 (EXCHG RTE) ClaimId: XXXXX7244',
    35.79, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000467', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0247'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Reversal: PAPA JOHNS #X0035 LETHBRIDGE AB 05/13 CA DOLLAR 48.78 X 0.XXX7023 (EXCHG RTE) ClaimId: XXXXX7244',
    35.79, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0248', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-15',
    'Expense',
    'LA RIBERA TAQUERIA & RE REFUGIO TX 05/15',
    0.0, 371.72999999999996, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000468', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0248'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LA RIBERA TAQUERIA & RE REFUGIO TX 05/15',
    24.08, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000469', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0248'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'O''REILLY 1238 MATHIS TX XX0318 05/15',
    64.92, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000470', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0248'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'O''REILLY 1238 MATHIS TX XX1511 05/15',
    35.71, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000471', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0248'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SQ *FARMER TRAILER RENT RICHMOND TX 05/15',
    110.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000472', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0248'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'H-E-B GAS #234 REFUGIO TX XX3085 05/15',
    71.82, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000473', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0248'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TEXAN # 8 VICTO VICTORIA TX 05/15',
    65.2, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0249', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-16',
    'Expense',
    'CHEVRON XXX8122 RICHMOND TX 05/16',
    0.0, 1367.68, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000474', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0249'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CHEVRON XXX8122 RICHMOND TX 05/16',
    83.42, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000475', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0249'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TST* SMOLIKS SMOKEHOUSE Mathis TX 05/15',
    83.74, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000476', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0249'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'AZTEC RENTAL CENTER NO2 HOUSTON TX 05/16',
    1180.52, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000477', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0249'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '9235 CLAY ROAD HOUSTON TX 05/16',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0250', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-17',
    'Expense',
    'REVEILLE BARBECUE CO PINEHURST TX 05/17',
    0.0, 129.08, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000478', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0250'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'REVEILLE BARBECUE CO PINEHURST TX 05/17',
    56.74, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000479', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0250'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCCOYS #57 TOMBALL TX 05/17',
    37.88, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000480', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0250'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:LYFT RIDE ORIG ID:XXXXXX2264 DESC DATE:240516 CO ENTRY DESCR:PAYMENTS SEC:WEB TRACE#:XXXXXXXX7772966 EED:240517 IND ID:XXXXXXXX2051676 IND NAME:INC 10NETZERO TELECHK XXX-XXX-9263 TRN: XXXXXX2966 TC',
    34.46, false
) ON CONFLICT (line_id_display) DO NOTHING;

