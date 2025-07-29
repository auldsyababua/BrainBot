-- Journal Entries Batch 8

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0351', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-09-03',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX7201 09/03',
    0.0, 2475.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000726', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0351'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX7201 09/03',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000727', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0351'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX7962 To BobcatCrane (_####4024)',
    2455.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0352', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-09-04',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX0473 09/04',
    0.0, 84.93, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000728', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0352'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX0473 09/04',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000729', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0352'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LOWE''S #1052 TOMBALL TX XX2068 09/04',
    64.93, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0353', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-09-05',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX2027 09/05',
    0.0, 2147.66, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000730', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0353'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX2027 09/05',
    10.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000731', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0353'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SERVICE CHARGES FOR THE MONTH OF AUGUST',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000732', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0353'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:IPFSXXX-XXX-2621 ORIG ID:0 ADXXX4370 DESC DATE: CO ENTRY DESCR:IPFSPMTTXPSEC:CCD TRACE#:XXXXXXXX3590087 EED:240905 IND ID:62397 IND NAME:10 NET ZERO INC. GDxLk2vV TRN: XXXXXX0087 TC',
    559.66, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000733', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0353'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX2982 To JohnSchillereff (_#####5067)',
    1538.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0354', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-09-08',
    'Expense',
    'ARLO TECHNOLOGIES INC XXX-XXX-3750 CA 09/09',
    0.0, 8.52, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000734', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0354'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ARLO TECHNOLOGIES INC XXX-XXX-3750 CA 09/09',
    8.52, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0355', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-09-09',
    'Expense',
    'NETLIFY HTTPSWWW.NETL CA 09/09',
    0.0, 20.25, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000735', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0355'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NETLIFY HTTPSWWW.NETL CA 09/09',
    20.25, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0356', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-09-10',
    'Expense',
    'ADOBE *XXX-XXX-6687 ADOBE.LY/ENUS CA 09/11',
    0.0, 21.64, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000736', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0356'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ADOBE *XXX-XXX-6687 ADOBE.LY/ENUS CA 09/11',
    21.64, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0357', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-09-11',
    'Expense',
    'Online ACH Payment XXXXXXX2346 To JoeSingleSourceLufkin (_#####6386)',
    0.0, 6765.63, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000737', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0357'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX2346 To JoeSingleSourceLufkin (_#####6386)',
    6765.63, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0358', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-09-12',
    'Expense',
    'PHOENICIA MKT BAR HOUSTON TX 09/12',
    0.0, 135.06, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000738', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0358'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'PHOENICIA MKT BAR HOUSTON TX 09/12',
    135.06, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0359', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-09-13',
    'Expense',
    'Online ACH Payment XXXXXXX7421 To Spindletop (_####7533)',
    0.0, 2809.37, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000739', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0359'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX7421 To Spindletop (_####7533)',
    2790.71, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000740', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0359'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'INTUIT *QBooks Onlin CL.INTUIT.COM CA 09/13',
    18.66, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0360', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-09-13',
    'Invoice',
    'WasteWatt Miner Install -  Mathis',
    4942.76, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000741', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0360'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    'WasteWatt Miner Install -  Mathis',
    4942.76, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0361', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-09-13',
    'Payment',
    'Payment - 2024-09-13',
    4942.76, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000742', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0361'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    4942.76, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0362', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-09-17',
    'Expense',
    'Online ACH Payment XXXXXXX0676 To MBX (_#####6908)',
    0.0, 3800.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000743', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0362'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX0676 To MBX (_#####6908)',
    3800.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0363', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-09-19',
    'Expense',
    'WHATABURGER 428 Q26 EDNA TX 09/19',
    0.0, 213.16, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000744', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0363'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WHATABURGER 428 Q26 EDNA TX 09/19',
    12.22, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000745', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0363'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LA RIBERA TAQUERIA & RE REFUGIO TX 09/19',
    18.68, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000746', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0363'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SUNOCO XXXXXX2300 REFUGIO TX 09/19',
    67.94, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000747', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0363'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S #30 WHARTON TX 09/19',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000748', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0363'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LOVE''S #0297 OUTSIDE EDNA TX 09/19',
    44.32, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000749', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0363'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CONNER''S CORNER STORE EDNA TX XX5529 09/19',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0364', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-09-23',
    'Expense',
    'Online Payment XXXXXXX3453 To Kebo Oil and Gas, INC 09/23',
    0.0, 3214.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000750', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0364'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX3453 To Kebo Oil and Gas, INC 09/23',
    3214.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0365', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-09-24',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX3913 09/24',
    0.0, 10.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000751', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0365'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX3913 09/24',
    10.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0366', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-09-26',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX3641 09/26',
    0.0, 48.7, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000752', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0366'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX3641 09/26',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000753', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0366'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'INTUIT *QBooks Onlin CL.INTUIT.COM CA 09/27',
    28.7, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0367', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-10-02',
    'Expense',
    '9235 CLAY ROAD BUSINES HOUSTON TX XX7729 10/02',
    0.0, 79.34, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000754', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0367'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '9235 CLAY ROAD BUSINES HOUSTON TX XX7729 10/02',
    40.17, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000755', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0367'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'PICK N PAY BEAUMONT TX XX5019 10/02',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000756', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0367'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MAX DONUTS HOUSTON TX 10/02',
    6.76, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000757', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0367'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'RAISING CANES 0393 BEAUMONT TX 10/02',
    12.41, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0368', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-10-03',
    'Deposit',
    'Online Transfer from CHK ...5317 transaction#: XXXXXXX4854',
    6765.63, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000758', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0368'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Transfer from CHK ...5317 transaction#: XXXXXXX4854',
    6765.63, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0369', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-10-03',
    'Expense',
    'SERVICE CHARGES FOR THE MONTH OF SEPTEMBER',
    0.0, 55.9, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000759', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0369'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SERVICE CHARGES FOR THE MONTH OF SEPTEMBER',
    55.9, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0370', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-10-05',
    'Expense',
    'ORIG CO NAME:IPFSXXX-XXX-2621 ORIG ID:0 ADXXX4370 DESC DATE: CO ENTRY DESCR:IPFSPMTTXPSEC:CCD TRACE#:XXXXXXXX1114351 EED:241007 IND ID:62397 IND NAME:10 NET ZERO INC. GDxLk2vV TRN: XXXXXX4351 TC',
    0.0, 559.66, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000760', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0370'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:IPFSXXX-XXX-2621 ORIG ID:0 ADXXX4370 DESC DATE: CO ENTRY DESCR:IPFSPMTTXPSEC:CCD TRACE#:XXXXXXXX1114351 EED:241007 IND ID:62397 IND NAME:10 NET ZERO INC. GDxLk2vV TRN: XXXXXX4351 TC',
    559.66, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0371', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-10-07',
    'Expense',
    'O''REILLY 1238 MATHIS TX XX2145 10/07',
    0.0, 646.96, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000761', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0371'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'O''REILLY 1238 MATHIS TX XX2145 10/07',
    401.53, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000762', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0371'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # X6979 REFUGIO TX 10/07',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000763', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0371'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TST*SMOLIKS SMOKEHOUSE Mathis TX 10/07',
    65.02, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000764', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0371'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LA RIBERA TAQUERIA & RE REFUGIO TX 10/07',
    17.68, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000765', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0371'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ARLO TECHNOLOGIES INC XXX-XXX-3750 CA 10/09',
    8.52, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000766', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0371'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'H-E-B #234 REFUGIO TX XX1371 10/07',
    19.46, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000767', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0371'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'H-E-B GAS #234 REFUGIO TX XX7209 10/07',
    59.75, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000768', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0371'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '9235 CLAY ROAD BUSINES HOUSTON TX XX4927 10/07',
    15.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000769', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0371'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '9235 CLAY ROAD BUSINES HOUSTON TX XX4927 10/07',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0372', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-10-09',
    'Expense',
    'NETLIFY HTTPSWWW.NETL CA 10/09',
    0.0, 20.25, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000770', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0372'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NETLIFY HTTPSWWW.NETL CA 10/09',
    20.25, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0373', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-10-10',
    'Expense',
    'ADOBE *XXX-XXX-6687 ADOBE.LY/ENUS CA 10/11',
    0.0, 21.64, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000771', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0373'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ADOBE *XXX-XXX-6687 ADOBE.LY/ENUS CA 10/11',
    21.64, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0374', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-10-10',
    'Invoice',
    'Invoice - 2024-10-10',
    1000.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000772', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0374'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    1000.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0375', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-10-10',
    'Payment',
    'Payment - 2024-10-10',
    1000.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000773', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0375'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    1000.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0376', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-10-11',
    'Expense',
    'Online ACH Payment XXXXXXX0351 To MartinLegal (_#####2006)',
    0.0, 3099.36, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000774', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0376'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX0351 To MartinLegal (_#####2006)',
    3099.36, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0377', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-10-13',
    'Expense',
    'INTUIT *QBooks Onlin CL.INTUIT.COM CA 10/13',
    0.0, 69.29, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000775', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0377'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'INTUIT *QBooks Onlin CL.INTUIT.COM CA 10/13',
    69.29, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0378', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-10-15',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX5591 10/15',
    0.0, 864.83, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000776', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0378'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX5591 10/15',
    10.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000777', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0378'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX9021 10/15',
    10.59, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000778', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0378'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TACTACAM WWW.REVEALCEL MN 10/15',
    120.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000779', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0378'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LOWE''S #1052 TOMBALL TX XX8097 10/15',
    77.88, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000780', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0378'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ACADEMY SPORTS #165 KATY TX 10/15',
    378.84, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000781', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0378'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ACADEMY SPORTS & OUTDO TOMBALL TX XX8747 10/15',
    162.52, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000782', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0378'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TACTACAM WWW.REVEALCEL MN 10/15',
    9.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000783', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0378'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TACTACAM WWW.REVEALCEL MN 10/15',
    96.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0379', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-10-16',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX8717 10/16',
    0.0, 704.4499999999999, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000784', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0379'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX8717 10/16',
    15.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000785', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0379'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ACADEMY SPORTS #165 KATY TX 10/16',
    238.12, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000786', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0379'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TACTACAM WWW.REVEALCEL MN 10/16',
    95.76, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000787', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0379'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SPYPOINT PREM-ANNUAL VICTORIAVILLE QC 10/16',
    129.9, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000788', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0379'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TACTACAM WWW.REVEALCEL MN 10/16',
    95.77, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000789', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0379'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SPYPOINT PREM-ANNUAL VICTORIAVILLE QC 10/16',
    129.9, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0380', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-10-17',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX2852 10/17',
    0.0, 2578.79, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000790', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0380'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX2852 10/17',
    15.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000791', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0380'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX1772 To BOC LOGISTICS LLC 10/17',
    1440.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000792', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0380'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX5121 To BOC LOGISTICS LLC 10/17',
    1020.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000793', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0380'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TARGET T-1904 TOMBALL TX XX5238 10/17',
    23.79, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000794', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0380'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'THECOMMONDESK WWW.THECOMMON TX 10/17',
    80.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0381', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-10-18',
    'Expense',
    'Zelle payment to Joel Fulford JPM99apltaae',
    0.0, 1024.16, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000795', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0381'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Zelle payment to Joel Fulford JPM99apltaae',
    353.09, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000796', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0381'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WWW.REVEALCELLCAM.CO WWW.REVEALCEL MN 10/18',
    671.07, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0382', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-10-21',
    'Expense',
    'WAL-MART #4512 KATY TX XX1300 10/21',
    0.0, 45.12, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000797', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0382'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WAL-MART #4512 KATY TX XX1300 10/21',
    45.12, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0383', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-10-23',
    'Expense',
    'TST*SMOLIKS SMOKEHOUSE Mathis TX 10/23',
    0.0, 351.62, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000798', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0383'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TST*SMOLIKS SMOKEHOUSE Mathis TX 10/23',
    57.6, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000799', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0383'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'H-E-B GAS #234 REFUGIO TX XX0232 10/23',
    42.34, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000800', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0383'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TACTACAM WWW.REVEALCEL MN 10/24',
    117.33, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000801', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0383'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TACTACAM WWW.REVEALCEL MN 10/23',
    6.66, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000802', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0383'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TACTACAM WWW.REVEALCEL MN 10/23',
    117.34, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000803', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0383'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ALAMO LUMBER COMPANY M MATHIS TX XX8061 10/23',
    10.35, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0384', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-10-28',
    'Expense',
    'Online Payment XXXXXXX5518 To Kebo Oil and Gas, INC 10/28',
    0.0, 4793.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000804', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0384'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX5518 To Kebo Oil and Gas, INC 10/28',
    4793.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0385', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-10-31',
    'Journal Entry',
    'Shwan Leary $100K - 5.46% annum',
    0.0, 4560.14, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000805', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0385'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    'Shwan Leary $100K - 5.46% annum',
    4560.14, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0386', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-10-31',
    'Journal Entry',
    'Scott Aulds Sr Loan $100,000 - Interest accrual on 5.45% annum',
    0.0, 4625.52, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000806', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0386'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    'Scott Aulds Sr Loan $100,000 - Interest accrual on 5.45% annum',
    4625.52, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0387', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-01',
    'Journal Entry',
    'Convertible Note Converted to equity',
    100000.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000807', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0387'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2520'),
    'Convertible Note Converted to equity',
    100000.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0388', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-01',
    'Journal Entry',
    'Convertible Note Converted to equity',
    12912.5, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000808', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0388'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2530'),
    'Convertible Note Converted to equity',
    12912.5, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0389', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-01',
    'Journal Entry',
    '6% annum on $12,912.50 Loan from S. Bryan Aulds II',
    0.0, 651.64, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000809', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0389'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    '6% annum on $12,912.50 Loan from S. Bryan Aulds II',
    651.64, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0390', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-01',
    'Journal Entry',
    '6% annum on $12,912.50 Loan from Colin Aulds',
    0.0, 3825.85, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000810', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0390'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    '6% annum on $12,912.50 Loan from Colin Aulds',
    3825.85, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0391', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-01',
    'Journal Entry',
    'Journal Entry - 2024-11-01',
    0.0, 3908.6, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000811', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0391'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    '',
    3908.6, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0392', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-01',
    'Journal Entry',
    'converted loan is converted to equity',
    15685.51, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000812', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0392'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    'converted loan is converted to equity',
    15685.51, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0393', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-01',
    'Journal Entry',
    'Convertible Loan conversion',
    100000.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000813', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0393'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2550'),
    'Convertible Loan conversion',
    100000.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0394', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-01',
    'Journal Entry',
    'Convertible Loan converted to equity',
    100000.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000814', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0394'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2540'),
    'Convertible Loan converted to equity',
    100000.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0395', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-04',
    'Expense',
    'AT&T BILL PAYMENT XXX-XXX-0500 TX 11/05',
    0.0, 500.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000815', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0395'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'AT&T BILL PAYMENT XXX-XXX-0500 TX 11/05',
    500.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0396', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-05',
    'Expense',
    'SERVICE CHARGES FOR THE MONTH OF OCTOBER',
    0.0, 42.5, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000816', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0396'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SERVICE CHARGES FOR THE MONTH OF OCTOBER',
    42.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0397', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-06',
    'Invoice',
    'Invoice - 2024-11-06',
    1616.6, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000817', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0397'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    1616.6, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0398', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-06',
    'Expense',
    'HUNT ROAD PIT STOP EXP BROOKSHIRE TX XX9571 11/06',
    0.0, 68.34, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000818', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0398'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'HUNT ROAD PIT STOP EXP BROOKSHIRE TX XX9571 11/06',
    68.34, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0399', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-06',
    'Invoice',
    'Invoice - 2024-11-06',
    1210.52, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000819', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0399'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    1210.52, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0400', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-07',
    'Expense',
    'ARLO TECHNOLOGIES INC XXX-XXX-3750 CA 11/09',
    0.0, 657.52, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000820', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0400'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ARLO TECHNOLOGIES INC XXX-XXX-3750 CA 11/09',
    8.52, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000821', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0400'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LEGALZOOM* TRADEMARK XXX-XXX0151 CA 11/07',
    649.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

