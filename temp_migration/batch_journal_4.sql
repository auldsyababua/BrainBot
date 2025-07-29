-- Journal Entries Batch 4

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0151', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-29',
    'Expense',
    'DOMESTIC WIRE FEE',
    0.0, 361283.27, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000229', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0151'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'DOMESTIC WIRE FEE',
    35.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000230', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0151'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'DOMESTIC INCOMING WIRE FEE',
    15.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000231', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0151'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'DOMESTIC WIRE TRANSFER A/C: HEATCORE INC FRISCO TX 75035-9485 US REF: INVOICE 2312252 TRN: 3889343363ES 12/29

Transfer of Heatcore Containers to Zapata II',
    361233.27, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0152', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-31',
    'Journal Entry',
    '6% annum on $12,912.50 Loan from S. Bryan Aulds II',
    0.0, 774.75, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000232', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0152'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    '6% annum on $12,912.50 Loan from S. Bryan Aulds II',
    774.75, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0153', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-31',
    'Journal Entry',
    '6% annum on $12,912.50 Loan from Colin Aulds',
    0.0, 4563.52, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000233', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0153'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    '6% annum on $12,912.50 Loan from Colin Aulds',
    4563.52, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0154', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-31',
    'Journal Entry',
    'Journal Entry - 2023-12-31',
    0.0, 4662.22, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000234', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0154'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    '',
    4662.22, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0155', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-31',
    'Journal Entry',
    'Shwan Leary $100K - 5.46% annum',
    0.0, 5457.21, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000235', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0155'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    'Shwan Leary $100K - 5.46% annum',
    5457.21, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0156', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-31',
    'Journal Entry',
    'Scott Aulds Sr Loan $100,000 - Interest accrual on 5.54% annum',
    0.0, 5535.45, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000236', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0156'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    'Scott Aulds Sr Loan $100,000 - Interest accrual on 5.54% annum',
    5535.45, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0157', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-31',
    'Journal Entry',
    'To record 2023 current year depreciation expense for Hashhut#1 and Hashhut#2',
    52570.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000237', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0157'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-8000'),
    'To record 2023 current year depreciation expense for Hashhut#1 and Hashhut#2',
    52570.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0158', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-31',
    'Journal Entry',
    'To record additional purchase of common stocks',
    0.0, 53.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000238', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0158'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-3110'),
    'To record additional purchase of common stocks',
    53.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0159', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-01-01',
    'Journal Entry',
    'Scarborough money to house Andrew''s miners',
    5000.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000239', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0159'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-6400'),
    'Scarborough money to house Andrew''s miners',
    5000.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0160', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-01-02',
    'Deposit',
    'WIRE REVERSAL B/O: JPMC CB FUNDS TRANSFER SAME DAY TAMPA FL XXXXX-9128 US ORG: ABA/XXXXX8777 SUTTON BANK REF:/BNF/OUR REF JPMXXXXXX-XX9200 CHASEREFXXXXXX1002FF RTN DTD 01/02/20 2 4 TRN XXXXXX4002 ES AS NOT A VALID SUT TON ACCT # NOT A VALID SUTTON ACCT# TRN: XXXXXX0002 HH',
    3000.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000240', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0160'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WIRE REVERSAL B/O: JPMC CB FUNDS TRANSFER SAME DAY TAMPA FL XXXXX-9128 US ORG: ABA/XXXXX8777 SUTTON BANK REF:/BNF/OUR REF JPMXXXXXX-XX9200 CHASEREFXXXXXX1002FF RTN DTD 01/02/20 2 4 TRN XXXXXX4002 ES AS NOT A VALID SUT TON ACCT # NOT A VALID SUTTON ACCT# TRN: XXXXXX0002 HH',
    3000.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0161', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-01-02',
    'Expense',
    'ONLINE DOMESTIC WIRE FEE',
    0.0, 12245.91, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000241', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0161'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ONLINE DOMESTIC WIRE FEE',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000242', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0161'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'THE UPS STORE 2667 XXX-XXX6159 TX 01/02',
    375.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000243', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0161'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Basic Online Payroll Payment XXXXXXX0952 to #####8563',
    1873.45, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000244', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0161'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Basic Online Payroll Payment XXXXXXX0951 to ######3267',
    4126.55, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000245', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0161'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ONLINE DOMESTIC WIRE TRANSFER VIA: SUTTON ATTICA/XXXXX8777 A/C: ABA/XXXXX5663 ATTICA OH US BEN: JOEL FULFORD HOUSTON TX X7080 US IMAD: 0102MMQFMP2KXX2010 TRN: 4 XXXXX4002ES 01/02',
    3000.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000246', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0161'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Advanced Crypto Orig ID:0000335892 Deso Data:220302 CO Entry Descr:8554693729Sec:Web Traoa#:021000020713908 Eed:220302 Ind ID:2487473 
Ind Name:Joel ''Futtord',
    2325.26, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000247', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0161'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Att Orig ID:9864031004 Dase Data:022722 CO Entry Descr:Payment Sec:PPD Trace#:0311002036054 t 4 Eed:220301 Ind ID: Ind Nam0:Jo0I Futtord Trn: 0603605414Tc',
    520.65, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0162', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-01-03',
    'Expense',
    'ONLINE DOMESTIC WIRE FEE',
    0.0, 3025.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000248', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0162'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ONLINE DOMESTIC WIRE FEE',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000249', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0162'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ONLINE DOMESTIC WIRE TRANSFER VIA: WELLS FARGO NA/XXXXX0248 A/C: JOEL FULFORD HOUSTON TX X7080 US REF:/TIME/16:26 IMAD: 0103MMQFMP2MXX8341 TRN: XXXXXX4003 ES 01/ 03',
    3000.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0163', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-01-04',
    'Deposit',
    'ORIG CO NAME:JPMorgan Chase ORIG ID:XXXXXX2233 DESC DATE:240104 CO ENTRY DESCR:ACCTVERIFYSEC:CCD TRACE#:XXXXXXXX2758701 EED:240104 IND ID:XXXXXXX6503 IND NAME:A uth TRN: XXXXXX8701 TC',
    0.35, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000250', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0163'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:JPMorgan Chase ORIG ID:XXXXXX2233 DESC DATE:240104 CO ENTRY DESCR:ACCTVERIFYSEC:CCD TRACE#:XXXXXXXX2758701 EED:240104 IND ID:XXXXXXX6503 IND NAME:A uth TRN: XXXXXX8701 TC',
    0.14, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000251', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0163'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:JPMorgan Chase ORIG ID:XXXXXX2233 DESC DATE:240104 CO ENTRY DESCR:ACCTVERIFYSEC:CCD TRACE#:XXXXXXXX2758679 EED:240104 IND ID:XXXXXXX6501 IND NAME:A uth TRN: XXXXXX8679 TC',
    0.21, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0164', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-01-04',
    'Expense',
    'ORIG CO NAME:JPMorgan Chase ORIG ID:XXXXXX2233 DESC DATE:240104 CO ENTRY DESCR:ACCTVERIFYSEC:CCD TRACE#:XXXXXXXX2206976 EED:240104 IND ID:XXXXXXX6504 IND NAME:A uth TRN: XXXXXX6976 TC',
    0.0, 0.35, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000252', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0164'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:JPMorgan Chase ORIG ID:XXXXXX2233 DESC DATE:240104 CO ENTRY DESCR:ACCTVERIFYSEC:CCD TRACE#:XXXXXXXX2206976 EED:240104 IND ID:XXXXXXX6504 IND NAME:A uth TRN: XXXXXX6976 TC',
    0.35, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0165', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-01-05',
    'Expense',
    'ORIG CO NAME:IPFSXXX-XXX-2621 ORIG ID:0 ADXXX4370 DESC DATE: CO ENTRY DESCR:IPFSPMTTXPSEC:CCD TRACE#:XXXXXXXX5505665 EED:240105 IND ID:62397 IND NAME:10 NET ZERO INC. GDxLk2vV TRN: XXXXXX5665 TC',
    0.0, 559.66, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000253', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0165'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:IPFSXXX-XXX-2621 ORIG ID:0 ADXXX4370 DESC DATE: CO ENTRY DESCR:IPFSPMTTXPSEC:CCD TRACE#:XXXXXXXX5505665 EED:240105 IND ID:62397 IND NAME:10 NET ZERO INC. GDxLk2vV TRN: XXXXXX5665 TC',
    559.66, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0166', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-01-19',
    'Deposit',
    'BOOK TRANSFER CREDIT B/O: ASIC MINERS US LLC ANDREW B GILTON LATHROP CA X5330 US TRN: XXXXXX4019 ES',
    1500.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000254', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0166'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BOOK TRANSFER CREDIT B/O: ASIC MINERS US LLC ANDREW B GILTON LATHROP CA X5330 US TRN: XXXXXX4019 ES',
    1500.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0167', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-01-22',
    'Expense',
    'Online ACH Payment XXXXXXX0302 To McKainPower (_######4723)',
    0.0, 30350.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000255', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0167'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX0302 To McKainPower (_######4723)',
    4050.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000256', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0167'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX0317 To McKainPower (_######4723)',
    26300.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0168', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-01-23',
    'Deposit',
    'BOOK TRANSFER CREDIT B/O: LIQUID IMMERSION WORLDWIDE LLC LATHROP CA X5330 US TRN: XXXXXX4023 ES',
    1000.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000257', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0168'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BOOK TRANSFER CREDIT B/O: LIQUID IMMERSION WORLDWIDE LLC LATHROP CA X5330 US TRN: XXXXXX4023 ES',
    1000.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0169', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-01-24',
    'Expense',
    'TST* BLUE SUSHI HOUSTON Houston TX 01/24',
    0.0, 124.69, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000258', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0169'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TST* BLUE SUSHI HOUSTON Houston TX 01/24',
    124.69, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0170', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-01-26',
    'Expense',
    'TST* SMOLIKS SMOKEHOUSE Mathis TX 01/26',
    0.0, 75.83, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000259', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0170'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TST* SMOLIKS SMOKEHOUSE Mathis TX 01/26',
    57.88, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000260', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0170'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LA RIBERA TAQUERIA & RE REFUGIO TX 01/26',
    17.95, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0171', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-01-30',
    'Expense',
    'ATT*BILL PAYMENT XXX-XXX-2020 TX 01/30',
    0.0, 280.58, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000261', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0171'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ATT*BILL PAYMENT XXX-XXX-2020 TX 01/30',
    280.58, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0172', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-01',
    'Expense',
    'Online ACH Payment XXXXXXX5778 To AlphaCentauri (_#####4922)',
    0.0, 24600.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000262', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0172'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX5778 To AlphaCentauri (_#####4922)',
    24600.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0173', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-01',
    'Check',
    'STANDARD ACH PMNTS INITIAL FEE QTY = 5',
    0.0, 12.5, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000263', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0173'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'STANDARD ACH PMNTS INITIAL FEE QTY = 5',
    12.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0174', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-02',
    'Expense',
    'Online Payment XXXXXXX2632 To Petroleum producing services LLC 02/02',
    0.0, 12761.46, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000264', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0174'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX2632 To Petroleum producing services LLC 02/02',
    3105.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000265', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0174'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX2159 To Hard Core Supply LLC 02/02',
    6426.46, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000266', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0174'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX0606 To 2W Services 02/02',
    2730.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000267', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0174'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'UNCHAINED CAPITAL WWW.UNCHAINED TX 02/02',
    500.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0175', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-06',
    'Expense',
    'ORIG CO NAME:IPFSXXX-XXX-2621 ORIG ID:0 ADXXX4370 DESC DATE: CO ENTRY DESCR:IPFSPMTTXPSEC:CCD TRACE#:XXXXXXXX8081591 EED:240206 IND ID:62397 IND NAME:10 NET ZERO INC. GDxLk2vV TRN: XXXXXX1591 TC',
    0.0, 559.66, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000268', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0175'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:IPFSXXX-XXX-2621 ORIG ID:0 ADXXX4370 DESC DATE: CO ENTRY DESCR:IPFSPMTTXPSEC:CCD TRACE#:XXXXXXXX8081591 EED:240206 IND ID:62397 IND NAME:10 NET ZERO INC. GDxLk2vV TRN: XXXXXX1591 TC',
    559.66, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0176', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-07',
    'Expense',
    'Online ACH Payment XXXXXXX4934 To McKainPower (_######4723)',
    0.0, 2704.12, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000269', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0176'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX4934 To McKainPower (_######4723)',
    2704.12, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0177', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-10',
    'Expense',
    'Conner''s Corner EDNA TX 02/10',
    0.0, 6191.9400000000005, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000270', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0177'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Conner''s Corner EDNA TX 02/10',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000271', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0177'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'STAR STOP X0231 CLAY R HOUSTON TX 02/10',
    40.8, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000272', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0177'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LA RIBERA TAQUERIA & RE REFUGIO TX 02/10',
    7.28, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000273', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0177'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'O''REILLY 1238 MATHIS TX XX4424 02/10',
    108.17, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000274', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0177'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'O''REILLY 1238 MATHIS TX XX2881 02/10',
    232.48, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000275', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0177'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX1475 To Certified Production Services, LLC 02/12',
    5763.21, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0178', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-12',
    'Expense',
    'CITY MARKET LULING TX 02/12',
    0.0, 549510.71, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000276', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0178'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CITY MARKET LULING TX 02/12',
    10.71, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000277', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0178'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'DOMESTIC WIRE TRANSFER VIA: THIRD COAST SSB/XXXXX4149 A/C: MCKAIN POWER SYSTEMS CONSULTING LLC IMAD: 0212MMQFMP2NXX0383 TRN: XXXXXX4043 ES 02/12',
    317000.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000278', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0178'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'DOMESTIC WIRE TRANSFER VIA: PNCBANK PITT/XXXXX0096 A/C: ACARI RESOURCES LLC IMAD: 0212MMQFMP2LXX0624 TRN: XXXXXX4043 ES 02/12',
    232500.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0179', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-13',
    'Expense',
    'LA RIBERA TAQUERIA & RE REFUGIO TX 02/13',
    0.0, 11120.47, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000279', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0179'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LA RIBERA TAQUERIA & RE REFUGIO TX 02/13',
    18.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000280', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0179'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TST* ROAMING RONIN Corpus Christ TX 02/13',
    156.76, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000281', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0179'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NAPA MATHIS MATHIS TX 02/13',
    111.96, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000282', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0179'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'H-E-B #270 CORPUS CHRIST TX XX0241 02/13',
    7.3, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000283', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0179'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LYFT *1 RIDE 02-13 HELP.LYFT.COM CA 02/15',
    25.95, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000284', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0179'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WITHDRAWAL 02/13',
    10800.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0180', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-14',
    'Expense',
    'CIRCLE K #XXX1540 ZAPATA TX XX9309 02/14',
    0.0, 225.06, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000285', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0180'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1540 ZAPATA TX XX9309 02/14',
    5.09, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000286', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0180'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SUNOCO XXXXXX1300 MATHIS TX 02/14',
    83.94, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000287', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0180'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1540 ZAPATA TX XX8924 02/14',
    30.03, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000288', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0180'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NAPA MATHIS MATHIS TX 02/14',
    3.66, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000289', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0180'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NAPA MATHIS MATHIS TX 02/14',
    102.34, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0181', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-16',
    'Expense',
    'Online ACH Payment XXXXXXX6184 To GTCrane (_#####3597)',
    0.0, 1200.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000290', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0181'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX6184 To GTCrane (_#####3597)',
    1200.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0182', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-19',
    'Expense',
    'CIRCLE K # X6979 217 N REFUGIO TX 02/19',
    0.0, 89.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000291', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0182'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # X6979 217 N REFUGIO TX 02/19',
    35.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000292', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0182'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'STAR STOP X0231 CLAY R HOUSTON TX 02/19',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000293', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0182'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LA RIBERA TAQUERIA & RE REFUGIO TX 02/19',
    14.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0183', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-20',
    'Expense',
    'SHELL SERVICE STATION EAST BERNARD TXXX2830 02/20',
    0.0, 81.03, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000294', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0183'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SHELL SERVICE STATION EAST BERNARD TXXX2830 02/20',
    81.03, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0184', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-21',
    'Expense',
    'BUC-EE''S #30 WHARTON TX XX7643 02/21',
    0.0, 3349.86, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000295', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0184'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S #30 WHARTON TX XX7643 02/21',
    10.8, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000296', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0184'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # X6979 217 N REFUGIO TX 02/21',
    40.06, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000297', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0184'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LA RIBERA TAQUERIA & RE REFUGIO TX 02/21',
    9.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000298', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0184'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX0351 To MartinLegal (_#####2006)',
    3290.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0185', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-22',
    'Expense',
    'NAPA MATHIS MATHIS TX 02/22',
    0.0, 64.92, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000299', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0185'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NAPA MATHIS MATHIS TX 02/22',
    64.92, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0186', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-23',
    'Expense',
    'FAST BREAK PETTUS TX XX2758 02/23',
    0.0, 129.10000000000002, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000300', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0186'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'FAST BREAK PETTUS TX XX2758 02/23',
    69.79, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000301', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0186'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'PRASEK''S HILLJE SEALY TX 02/23',
    59.31, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0187', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-27',
    'Expense',
    'BUC-EE''S #30 WHARTON TX 02/27',
    0.0, 2102.8199999999997, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000302', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0187'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S #30 WHARTON TX 02/27',
    7.97, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000303', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0187'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S #30 OUTSIDE WHARTON TX XX1466 02/27',
    30.01, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000304', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0187'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1540 ZAPATA TX XX2691 02/27',
    40.9, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000305', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0187'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S #30 OUTSIDE WHARTON TX XX2553 02/27',
    64.36, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000306', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0187'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCDONALD''S FX8776 ZAPATA TX 02/27',
    8.53, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000307', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0187'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LA RIBERA TAQUERIA & RE REFUGIO TX 02/27',
    13.21, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000308', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0187'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:Express Transpor ORIG ID:204876018 DESC DATE:Feb 27 CO ENTRY DESCR:10 net zerSEC:CCD TRACE#:XXXXXXXX7617945 EED:240227 IND ID:5 -X7295 IND NAME:10 n et zero TRN: XXXXXX7945 TC',
    1800.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000309', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0187'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'H-E-B GAS #234 REFUGIO TX XX4753 02/27',
    81.86, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000310', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0187'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'VICTORIA TX XX2989 02/27',
    51.01, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000311', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0187'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'AMZN Mktp US*RZ8QA1U Amzn.com/bill WA 02/28',
    4.97, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0188', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-28',
    'Expense',
    'GOODSON CAFE XXX-XXX5213 TX 02/28',
    0.0, 1059.47, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000312', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0188'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'GOODSON CAFE XXX-XXX5213 TX 02/28',
    74.47, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000313', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0188'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Zelle payment to Alexis colon JPM99aa96d3w',
    985.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0189', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-29',
    'Expense',
    'THE HOME DEPOT #6525 HOUSTON TX XX4299 02/29',
    0.0, 4227.09, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000314', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0189'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'THE HOME DEPOT #6525 HOUSTON TX XX4299 02/29',
    62.09, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000315', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0189'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX2177 To 2WServices (_###4108)',
    4165.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0190', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-01',
    'Deposit',
    'Credit Return: Online ACH Payment XXXXXXX1555 To AlphaCentauri (_#####4922)',
    13000.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000316', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0190'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Credit Return: Online ACH Payment XXXXXXX1555 To AlphaCentauri (_#####4922)',
    11700.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000317', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0190'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Credit Return: Online ACH Payment XXXXXXX1288 To JustinBallardLaw (_########9126)',
    1300.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0191', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-01',
    'Expense',
    'Online ACH Payment XXXXXXX4869 To JustinBallardLaw (_########9126)',
    0.0, 14799.16, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000318', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0191'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX4869 To JustinBallardLaw (_########9126)',
    1300.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000319', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0191'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX1555 To AlphaCentauri (_#####4922)',
    11700.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000320', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0191'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'HWY 290 WRECKER HOCKLEY TX 02/29',
    1556.25, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000321', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0191'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ATT*BILL PAYMENT XXX-XXX-2020 TX 02/29',
    242.91, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0192', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-04',
    'Expense',
    'CIRCLE K # X6983 X0537 MATHIS TX 03/04',
    0.0, 21593.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000322', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0192'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # X6983 X0537 MATHIS TX 03/04',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000323', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0192'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'STAR STOP X0231 CLAY R HOUSTON TX 03/04',
    35.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000324', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0192'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TAQUERIA VALLARTA #2 MATHIS TX 03/04',
    18.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000325', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0192'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WITHDRAWAL 03/04 - Trailers',
    4500.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000326', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0192'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WITHDRAWAL 03/04',
    17000.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0193', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-05',
    'Expense',
    'TIL*TP BLACKROCK BR083 HOUSTON TX 03/05',
    0.0, 669.87, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000327', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0193'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TIL*TP BLACKROCK BR083 HOUSTON TX 03/05',
    10.63, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000328', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0193'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TST* MALA SICHUAN - CHI Houston TX 03/05',
    99.58, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000329', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0193'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:IPFSXXX-XXX-2621 ORIG ID:0 ADXXX4370 DESC DATE: CO ENTRY DESCR:IPFSPMTTXPSEC:CCD TRACE#:XXXXXXXX4595203 EED:240305 IND ID:62397 IND NAME:10 NET ZERO INC. GDxLk2vV TRN: XXXXXX5203 TC',
    559.66, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0194', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-06',
    'Expense',
    'CHEVRON XXX3521 TOMBALL TX 03/06',
    0.0, 2546.87, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000330', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0194'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CHEVRON XXX3521 TOMBALL TX 03/06',
    65.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000331', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0194'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'GOODSON CAFE XXX-XXX5213 TX 03/06',
    61.9, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000332', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0194'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ASAP TRAILER SERVICE AN TOMBALL TX 03/06',
    29.01, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000333', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0194'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ASAP TRAILER SERVICE AN TOMBALL TX 03/06',
    132.96, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000334', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0194'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Zelle payment to Joey Headly XXXXXXX8602 - Trailer',
    570.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000335', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0194'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:RIGGING & WELDIN ORIG ID:XXXXXX6202 DESC DATE:240306 CO ENTRY DESCR:SALE SEC:CCD TRACE#:XXXXXXXX4074352 EED:240306 IND ID: IND NAME:10 NET ZERO TRN : XXXXXX4352TC',
    1688.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0195', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-07',
    'Expense',
    'CORPUS MM/GAS 0 CORPUS CHRIS TX 03/07',
    0.0, 220.71, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000336', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0195'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CORPUS MM/GAS 0 CORPUS CHRIS TX 03/07',
    73.81, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000337', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0195'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TST* SMOLIKS SMOKEHOUSE Mathis TX 03/07',
    68.97, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000338', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0195'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Alamo Lumber Company M Mathis TX XX6384 03/07',
    77.93, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0196', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-08',
    'Deposit',
    'Credit Return: Online ACH Payment XXXXXXX4869 To JustinBallardLaw (_########9126)',
    1300.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000339', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0196'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Credit Return: Online ACH Payment XXXXXXX4869 To JustinBallardLaw (_########9126)',
    1300.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0197', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-08',
    'Expense',
    'KROGER FUEL 7361 353 COLLEGE STATI TXXX3392 03/08',
    0.0, 13104.57, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000340', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0197'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'KROGER FUEL 7361 353 COLLEGE STATI TXXX3392 03/08',
    20.01, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000341', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0197'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'STAR STOP X0231 CLAY R HOUSTON TX 03/08',
    35.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000342', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0197'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BLUE BAKER 002 Q25 COLLEGE STATI TX 03/08',
    22.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000343', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0197'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX4869 To JustinBallardLaw (_########9126)',
    1300.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000344', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0197'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX5384 To AlphaCentauri (_#####6780) - electrical work',
    11727.06, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0198', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-10',
    'Expense',
    'WAL-MART #4111 RICHMOND TX 03/10',
    0.0, 107.06, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000345', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0198'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WAL-MART #4111 RICHMOND TX 03/10',
    80.02, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000346', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0198'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'THE HOME DEPOT #6587 VICTORIA TX XX2402 03/10',
    27.04, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0199', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-11',
    'Expense',
    'CIRCLE K # X6979 217 N REFUGIO TX 03/11',
    0.0, 4589.4, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000347', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0199'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # X6979 217 N REFUGIO TX 03/11',
    50.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000348', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0199'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # X6983 MATHIS TX 03/11',
    11.07, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000349', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0199'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TST* SMOLIKS SMOKEHOUSE Mathis TX 03/11',
    28.33, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000350', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0199'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WITHDRAWAL 03/11',
    4500.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0200', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-12',
    'Expense',
    'JACK IN THE BOX TOMBALL TX XX0612 03/12',
    0.0, 839.49, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000351', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0200'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'JACK IN THE BOX TOMBALL TX XX0612 03/12',
    5.96, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000352', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0200'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCCOYS #57 TOMBALL TX 03/12',
    26.37, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000353', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0200'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TRACTOR-SUPPLY-C X7400 TOMBALL TX XX9613 03/12',
    135.29, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000354', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0200'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Zelle payment to Cody Tedesco JPM99abctlpp',
    300.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000355', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0200'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'PMT*FT BEND CO TAX OFFI RICHMOND TX 03/12',
    371.87, false
) ON CONFLICT (line_id_display) DO NOTHING;

