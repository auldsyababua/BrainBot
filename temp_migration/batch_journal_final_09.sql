-- Journal Entries Final Batch 9

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0160', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-01-02',
    'Deposit',
    '1015031',
    'Joel Fulford',
    'WIRE REVERSAL B/O: JPMC CB FUNDS TRANSFER SAME DAY TAMPA FL XXXXX-9128 US ORG: ABA/XXXXX8777 SUTTON BANK REF:/BNF/OUR REF JPMXXXXXX-XX9200 CHASEREFXXXXXX1002FF RTN DTD 01/02/20 2 4 TRN XXXXXX4002 ES AS NOT A VALID SUT TON ACCT # NOT A VALID SUTTON ACCT# TRN: XXXXXX0002 HH'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0160'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    3000.0, 0,
    'WIRE REVERSAL B/O: JPMC CB FUNDS TRANSFER SAME DAY TAMPA FL XXXXX-9128 US ORG: ABA/XXXXX8777 SUTTON BANK REF:/BNF/OUR REF JPMXXXXXX-XX9200 CHASEREFXXXXXX1002FF RTN DTD 01/02/20 2 4 TRN XXXXXX4002 ES AS NOT A VALID SUT TON ACCT # NOT A VALID SUTTON ACCT# TRN: XXXXXX0002 HH'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0161', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-01-02',
    'Expense',
    '1015031',
    'UPS',
    'ONLINE DOMESTIC WIRE FEE'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0161'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 25.0,
    'ONLINE DOMESTIC WIRE FEE'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0161'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 375.0,
    'THE UPS STORE 2667 XXX-XXX6159 TX 01/02'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0161'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 1873.45,
    'Basic Online Payroll Payment XXXXXXX0952 to #####8563'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0161'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 4126.55,
    'Basic Online Payroll Payment XXXXXXX0951 to ######3267'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0161'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 3000.0,
    'ONLINE DOMESTIC WIRE TRANSFER VIA: SUTTON ATTICA/XXXXX8777 A/C: ABA/XXXXX5663 ATTICA OH US BEN: JOEL FULFORD HOUSTON TX X7080 US IMAD: 0102MMQFMP2KXX2010 TRN: 4 XXXXX4002ES 01/02'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0161'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 2325.26,
    'Orig CO Name:Advanced Crypto Orig ID:0000335892 Deso Data:220302 CO Entry Descr:8554693729Sec:Web Traoa#:021000020713908 Eed:220302 Ind ID:2487473 
Ind Name:Joel ''Futtord'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0161'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    7,
    0, 520.65,
    'Orig CO Name:Att Orig ID:9864031004 Dase Data:022722 CO Entry Descr:Payment Sec:PPD Trace#:0311002036054 t 4 Eed:220301 Ind ID: Ind Nam0:Jo0I Futtord Trn: 0603605414Tc'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0162', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-01-03',
    'Expense',
    '1015031',
    'Joel Fulford',
    'ONLINE DOMESTIC WIRE FEE'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0162'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 25.0,
    'ONLINE DOMESTIC WIRE FEE'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0162'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 3000.0,
    'ONLINE DOMESTIC WIRE TRANSFER VIA: WELLS FARGO NA/XXXXX0248 A/C: JOEL FULFORD HOUSTON TX X7080 US REF:/TIME/16:26 IMAD: 0103MMQFMP2MXX8341 TRN: XXXXXX4003 ES 01/ 03'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0163', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-01-04',
    'Deposit',
    '1015031',
    NULL,
    'ORIG CO NAME:JPMorgan Chase ORIG ID:XXXXXX2233 DESC DATE:240104 CO ENTRY DESCR:ACCTVERIFYSEC:CCD TRACE#:XXXXXXXX2758701 EED:240104 IND ID:XXXXXXX6503 IND NAME:A uth TRN: XXXXXX8701 TC'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0163'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0.14, 0,
    'ORIG CO NAME:JPMorgan Chase ORIG ID:XXXXXX2233 DESC DATE:240104 CO ENTRY DESCR:ACCTVERIFYSEC:CCD TRACE#:XXXXXXXX2758701 EED:240104 IND ID:XXXXXXX6503 IND NAME:A uth TRN: XXXXXX8701 TC'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0163'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0.21, 0,
    'ORIG CO NAME:JPMorgan Chase ORIG ID:XXXXXX2233 DESC DATE:240104 CO ENTRY DESCR:ACCTVERIFYSEC:CCD TRACE#:XXXXXXXX2758679 EED:240104 IND ID:XXXXXXX6501 IND NAME:A uth TRN: XXXXXX8679 TC'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0164', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-01-04',
    'Expense',
    '1015031',
    NULL,
    'ORIG CO NAME:JPMorgan Chase ORIG ID:XXXXXX2233 DESC DATE:240104 CO ENTRY DESCR:ACCTVERIFYSEC:CCD TRACE#:XXXXXXXX2206976 EED:240104 IND ID:XXXXXXX6504 IND NAME:A uth TRN: XXXXXX6976 TC'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0164'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 0.35,
    'ORIG CO NAME:JPMorgan Chase ORIG ID:XXXXXX2233 DESC DATE:240104 CO ENTRY DESCR:ACCTVERIFYSEC:CCD TRACE#:XXXXXXXX2206976 EED:240104 IND ID:XXXXXXX6504 IND NAME:A uth TRN: XXXXXX6976 TC'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0165', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-01-05',
    'Expense',
    '1015031',
    NULL,
    'ORIG CO NAME:IPFSXXX-XXX-2621 ORIG ID:0 ADXXX4370 DESC DATE: CO ENTRY DESCR:IPFSPMTTXPSEC:CCD TRACE#:XXXXXXXX5505665 EED:240105 IND ID:62397 IND NAME:10 NET ZERO INC. GDxLk2vV TRN: XXXXXX5665 TC'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0165'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 559.66,
    'ORIG CO NAME:IPFSXXX-XXX-2621 ORIG ID:0 ADXXX4370 DESC DATE: CO ENTRY DESCR:IPFSPMTTXPSEC:CCD TRACE#:XXXXXXXX5505665 EED:240105 IND ID:62397 IND NAME:10 NET ZERO INC. GDxLk2vV TRN: XXXXXX5665 TC'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0166', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-01-19',
    'Deposit',
    '1015031',
    'Asics Miners US',
    'BOOK TRANSFER CREDIT B/O: ASIC MINERS US LLC ANDREW B GILTON LATHROP CA X5330 US TRN: XXXXXX4019 ES'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0166'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    1500.0, 0,
    'BOOK TRANSFER CREDIT B/O: ASIC MINERS US LLC ANDREW B GILTON LATHROP CA X5330 US TRN: XXXXXX4019 ES'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0167', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-01-22',
    'Expense',
    '1015031',
    'McKain Power Systems',
    'Online ACH Payment XXXXXXX0302 To McKainPower (_######4723)'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0167'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 4050.0,
    'Online ACH Payment XXXXXXX0302 To McKainPower (_######4723)'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0167'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 26300.0,
    'Online ACH Payment XXXXXXX0317 To McKainPower (_######4723)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0168', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-01-23',
    'Deposit',
    '1015031',
    'Asics Miners US',
    'BOOK TRANSFER CREDIT B/O: LIQUID IMMERSION WORLDWIDE LLC LATHROP CA X5330 US TRN: XXXXXX4023 ES'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0168'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    1000.0, 0,
    'BOOK TRANSFER CREDIT B/O: LIQUID IMMERSION WORLDWIDE LLC LATHROP CA X5330 US TRN: XXXXXX4023 ES'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0169', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-01-24',
    'Expense',
    '1015031',
    NULL,
    'TST* BLUE SUSHI HOUSTON Houston TX 01/24'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0169'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 124.69,
    'TST* BLUE SUSHI HOUSTON Houston TX 01/24'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0170', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-01-26',
    'Expense',
    '1015031',
    NULL,
    'TST* SMOLIKS SMOKEHOUSE Mathis TX 01/26'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0170'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 57.88,
    'TST* SMOLIKS SMOKEHOUSE Mathis TX 01/26'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0170'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 17.95,
    'LA RIBERA TAQUERIA & RE REFUGIO TX 01/26'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0171', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-01-30',
    'Expense',
    '1015031',
    'AT&T',
    'ATT*BILL PAYMENT XXX-XXX-2020 TX 01/30'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0171'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 280.58,
    'ATT*BILL PAYMENT XXX-XXX-2020 TX 01/30'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0172', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-01',
    'Expense',
    '1015031',
    'Alpha Centauri Contractors',
    'Online ACH Payment XXXXXXX5778 To AlphaCentauri (_#####4922)'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0172'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 24600.0,
    'Online ACH Payment XXXXXXX5778 To AlphaCentauri (_#####4922)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0173', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-01',
    'Check',
    '5062720',
    NULL,
    'STANDARD ACH PMNTS INITIAL FEE QTY = 5'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0173'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 12.5,
    'STANDARD ACH PMNTS INITIAL FEE QTY = 5'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0174', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-02',
    'Expense',
    '5062720',
    'Hard Core Supply LLC',
    'Online Payment XXXXXXX2632 To Petroleum producing services LLC 02/02'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0174'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 3105.0,
    'Online Payment XXXXXXX2632 To Petroleum producing services LLC 02/02'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0174'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 6426.46,
    'Online Payment XXXXXXX2159 To Hard Core Supply LLC 02/02'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0174'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 2730.0,
    'Online Payment XXXXXXX0606 To 2W Services 02/02'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0174'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 500.0,
    'UNCHAINED CAPITAL WWW.UNCHAINED TX 02/02'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0175', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-06',
    'Expense',
    '5062720',
    NULL,
    'ORIG CO NAME:IPFSXXX-XXX-2621 ORIG ID:0 ADXXX4370 DESC DATE: CO ENTRY DESCR:IPFSPMTTXPSEC:CCD TRACE#:XXXXXXXX8081591 EED:240206 IND ID:62397 IND NAME:10 NET ZERO INC. GDxLk2vV TRN: XXXXXX1591 TC'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0175'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 559.66,
    'ORIG CO NAME:IPFSXXX-XXX-2621 ORIG ID:0 ADXXX4370 DESC DATE: CO ENTRY DESCR:IPFSPMTTXPSEC:CCD TRACE#:XXXXXXXX8081591 EED:240206 IND ID:62397 IND NAME:10 NET ZERO INC. GDxLk2vV TRN: XXXXXX1591 TC'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0176', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-07',
    'Expense',
    '5062720',
    'McKain Power Systems',
    'Online ACH Payment XXXXXXX4934 To McKainPower (_######4723)'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0176'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 2704.12,
    'Online ACH Payment XXXXXXX4934 To McKainPower (_######4723)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0177', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-10',
    'Expense',
    '5062720',
    NULL,
    'Conner''s Corner EDNA TX 02/10'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0177'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 40.0,
    'Conner''s Corner EDNA TX 02/10'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0177'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 40.8,
    'STAR STOP X0231 CLAY R HOUSTON TX 02/10'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0177'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 7.28,
    'LA RIBERA TAQUERIA & RE REFUGIO TX 02/10'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0177'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 108.17,
    'O''REILLY 1238 MATHIS TX XX4424 02/10'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0177'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 232.48,
    'O''REILLY 1238 MATHIS TX XX2881 02/10'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0177'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 5763.21,
    'Online Payment XXXXXXX1475 To Certified Production Services, LLC 02/12'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0178', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-12',
    'Expense',
    '5062720',
    'City Market',
    'CITY MARKET LULING TX 02/12'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0178'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 10.71,
    'CITY MARKET LULING TX 02/12'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0178'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 317000.0,
    'DOMESTIC WIRE TRANSFER VIA: THIRD COAST SSB/XXXXX4149 A/C: MCKAIN POWER SYSTEMS CONSULTING LLC IMAD: 0212MMQFMP2NXX0383 TRN: XXXXXX4043 ES 02/12'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0178'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 232500.0,
    'DOMESTIC WIRE TRANSFER VIA: PNCBANK PITT/XXXXX0096 A/C: ACARI RESOURCES LLC IMAD: 0212MMQFMP2LXX0624 TRN: XXXXXX4043 ES 02/12'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0179', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-13',
    'Expense',
    '5062720',
    'Joey Headly',
    'LA RIBERA TAQUERIA & RE REFUGIO TX 02/13'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0179'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 18.5,
    'LA RIBERA TAQUERIA & RE REFUGIO TX 02/13'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0179'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 156.76,
    'TST* ROAMING RONIN Corpus Christ TX 02/13'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0179'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 111.96,
    'NAPA MATHIS MATHIS TX 02/13'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0179'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 7.3,
    'H-E-B #270 CORPUS CHRIST TX XX0241 02/13'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0179'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 25.95,
    'LYFT *1 RIDE 02-13 HELP.LYFT.COM CA 02/15'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0179'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 10800.0,
    'WITHDRAWAL 02/13'
);

