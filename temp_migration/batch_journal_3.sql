-- Journal Entries Batch 3

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0101', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-04-04',
    'Expense',
    'Check No. 1748 - Pay to The Order Of: Crane Rental Division, Inc.',
    0.0, 942.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000147', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0101'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Check No. 1748 - Pay to The Order Of: Crane Rental Division, Inc.',
    942.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0102', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-04-05',
    'Expense',
    'Orig CO Name:Google Orig ID:F770493581 Deso Date: CO Entry Descr:Apps_Commesec:CCD Trace/1:091000016369241 Eed:230405 Ind ID:US003Txfwl Ind Name:Joel Fulford 
013148088 Debit Trn: 0956369241Tc',
    0.0, 89.54, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000148', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0102'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Google Orig ID:F770493581 Deso Date: CO Entry Descr:Apps_Commesec:CCD Trace/1:091000016369241 Eed:230405 Ind ID:US003Txfwl Ind Name:Joel Fulford 
013148088 Debit Trn: 0956369241Tc',
    89.54, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0103', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-04-12',
    'Expense',
    'Check No. 1749 - Pay to The Order Of: Dalton Trucking',
    0.0, 2160.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000149', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0103'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Check No. 1749 - Pay to The Order Of: Dalton Trucking',
    2160.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0104', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-04-13',
    'Expense',
    'Overdraft Fee For Check 111749 IN The Amount of S2 160.00',
    0.0, 34.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000150', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0104'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Overdraft Fee For Check 111749 IN The Amount of S2 160.00',
    34.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0105', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-04-17',
    'Deposit',
    'Deposit 1155781395 - 10 Net Zero',
    211.25, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000151', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0105'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Deposit 1155781395 - 10 Net Zero',
    211.25, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0106', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-06-06',
    'Deposit',
    'Write-Off',
    1986.29, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000152', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0106'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Write-Off',
    1986.29, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0107', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-07-02',
    'Journal Entry',
    'Journal Entry - 2023-07-02',
    25000.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000153', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0107'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-6010'),
    '',
    25000.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0108', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-07-26',
    'Deposit',
    'DEPOSIT  ID NUMBER  44150',
    50000.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000154', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0108'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'DEPOSIT  ID NUMBER  44150',
    50000.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0109', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-08-08',
    'Expense',
    'DOMESTIC WIRE TRANSFER VIA: PNCBANK PITT/043000096 A/C: ACARI RESOURCES LTD. REF: DOWN PAYMENT IMAD: 0808B1QGC02C001521 TRN: 3673763219ES 08/08

MWM Generator purchase - sold to Operation Orange',
    0.0, 50035.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000155', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0109'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'DOMESTIC WIRE TRANSFER VIA: PNCBANK PITT/043000096 A/C: ACARI RESOURCES LTD. REF: DOWN PAYMENT IMAD: 0808B1QGC02C001521 TRN: 3673763219ES 08/08

MWM Generator purchase - sold to Operation Orange',
    50000.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000156', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0109'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'DOMESTIC WIRE FEE',
    35.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0110', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-08-10',
    'Deposit',
    'CHIPS CREDIT VIA: BANK OF AMERICA, N.A./0959 B/O: ASIC MINERS US LLC LATHROP, CA, 95330 US REF: NBNF=10NETZERO, INC. HOUSTON TX 77080-1526 US/AC-000000005231 ORG=/325 177590254 LATHROP, CA, 95330 US OGB =BANK OF AMERICA, N.A. NEW YORK NY US OBI=INVOICE 106 BBI=/CHGS/USD0,/ SSN: 0454183 TRN: 1069800222FC',
    49189.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000157', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0110'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CHIPS CREDIT VIA: BANK OF AMERICA, N.A./0959 B/O: ASIC MINERS US LLC LATHROP, CA, 95330 US REF: NBNF=10NETZERO, INC. HOUSTON TX 77080-1526 US/AC-000000005231 ORG=/325 177590254 LATHROP, CA, 95330 US OGB =BANK OF AMERICA, N.A. NEW YORK NY US OBI=INVOICE 106 BBI=/CHGS/USD0,/ SSN: 0454183 TRN: 1069800222FC',
    49189.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0111', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-08-10',
    'Expense',
    'DOMESTIC INCOMING WIRE FEE',
    0.0, 15.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000158', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0111'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'DOMESTIC INCOMING WIRE FEE',
    15.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0112', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-08-11',
    'Expense',
    'ATM WITHDRAWAL                       005935  08/119704 KATY',
    0.0, 420.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000159', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0112'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ATM WITHDRAWAL                       005935  08/119704 KATY',
    420.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0113', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-08-14',
    'Expense',
    'Online ACH Payment 11027377566 To UnitedOFS (_#####2100)',
    0.0, 3656.3999999999996, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000160', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0113'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment 11027377566 To UnitedOFS (_#####2100)',
    1140.6, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000161', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0113'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment 11027378428 To MartinLG (_######7156)',
    1090.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000162', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0113'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ATM WITHDRAWAL                       006886  08/129704 KATY',
    500.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000163', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0113'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ATM WITHDRAWAL                       007857  08/139704 KATY',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000164', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0113'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ATM WITHDRAWAL                       008174  08/149704 KATY',
    100.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000165', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0113'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CHECK 1139',
    805.8, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0114', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-08-17',
    'Expense',
    'ATM WITHDRAWAL                       000035  08/179704 KATY',
    0.0, 660.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000166', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0114'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ATM WITHDRAWAL                       000035  08/179704 KATY',
    660.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0115', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-08-18',
    'Expense',
    'ORIG CO NAME:BANK OF AMERICA        ORIG ID:941687665G DESC DATE:230817 CO ENTRY DESCR:Payment   SEC:TEL    TRACE#:111000027042130 EED:230818   IND ID:qftmlixpr                    IND NAME:FULFORD, JOEL TRN: 2307042130TC',
    0.0, 1646.31, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000167', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0115'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:BANK OF AMERICA        ORIG ID:941687665G DESC DATE:230817 CO ENTRY DESCR:Payment   SEC:TEL    TRACE#:111000027042130 EED:230818   IND ID:qftmlixpr                    IND NAME:FULFORD, JOEL TRN: 2307042130TC',
    511.03, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000168', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0115'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:BANK OF AMERICA        ORIG ID:941687665G DESC DATE:230817 CO ENTRY DESCR:Payment   SEC:TEL    TRACE#:111000027042133 EED:230818   IND ID:15uv7rhdt                    IND NAME:FULFORD, JOEL TRN: 2307042133TC',
    1135.28, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0116', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-08-21',
    'Expense',
    'GEICO  *AUTO 800-841-3000 DC                 08/20',
    0.0, 689.48, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000169', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0116'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'GEICO  *AUTO 800-841-3000 DC                 08/20',
    689.48, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0117', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-08-22',
    'Expense',
    'Online ACH Payment 11028118576 To 2WServices (_###4108)',
    0.0, 4365.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000170', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0117'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment 11028118576 To 2WServices (_###4108)',
    4365.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0118', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-08-23',
    'Deposit',
    'DEPOSIT  ID NUMBER  66994',
    50000.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000171', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0118'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'DEPOSIT  ID NUMBER  66994',
    50000.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0119', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-08-23',
    'Expense',
    'Online ACH Payment 11028171343 To PPS (_######9165)',
    0.0, 9027.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000172', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0119'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment 11028171343 To PPS (_######9165)',
    9027.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0120', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-08-24',
    'Expense',
    'ATT*BILL PAYMENT 800-288-2020 TX             08/23',
    0.0, 583.54, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000173', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0120'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ATT*BILL PAYMENT 800-288-2020 TX             08/23',
    343.08, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000174', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0120'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ATT*BILL PAYMENT 800-288-2020 TX             08/23',
    240.46, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0121', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-09-01',
    'Expense',
    'ONLINE DOMESTIC WIRE FEE',
    0.0, 27525.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000175', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0121'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ONLINE DOMESTIC WIRE FEE',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000176', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0121'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ONLINE DOMESTIC WIRE TRANSFER VIA: PNCBANK PITT/043000096 A/C: ACARI RESOURCES LTD DALLAS TX 75225 US IMAD: 0901B1QGC08C032111 TRN: 3990393244ES 09/01

MWM Generator purchase - sold to Operation Orange',
    27500.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0122', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-09-05',
    'Expense',
    'ONLINE DOMESTIC WIRE FEE',
    0.0, 50025.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000177', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0122'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ONLINE DOMESTIC WIRE FEE',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000178', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0122'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ONLINE DOMESTIC WIRE TRANSFER VIA: PNCBANK PITT/043000096 A/C: ACARI RESOURCES LTD DALLAS TX 75225 US IMAD: 0905B1QGC01C013925 TRN: 3925283248ES 09/05

MWM Generator purchase - sold to Operation Orange',
    50000.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0123', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-09-06',
    'Expense',
    'CIRCLE K # 06983 10537 MATHIS TX             09/06',
    0.0, 92.46000000000001, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000179', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0123'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # 06983 10537 MATHIS TX             09/06',
    35.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000180', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0123'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'STAR STOP 127 10231 CL HOUSTON TX    743069  09/06',
    57.46, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0124', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-09-07',
    'Deposit',
    'FEDWIRE CREDIT VIA: WELLS FARGO BANK, N.A./121000248 B/O: MACY FULFORD TX 77080 REF: CHASE NYC/CTR/BNF=10NETZERO, INC. HOUSTON TX 77080-1526 US/AC-00000000 5231 RFB=OW00003603562374 BBI=/CHGS/USD0,00/ IMAD: 0907I1B7032R020448 TRN: 1004230250FF',
    3535.79, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000181', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0124'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'FEDWIRE CREDIT VIA: WELLS FARGO BANK, N.A./121000248 B/O: MACY FULFORD TX 77080 REF: CHASE NYC/CTR/BNF=10NETZERO, INC. HOUSTON TX 77080-1526 US/AC-00000000 5231 RFB=OW00003603562374 BBI=/CHGS/USD0,00/ IMAD: 0907I1B7032R020448 TRN: 1004230250FF',
    3535.79, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0125', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-09-07',
    'Expense',
    'DOMESTIC INCOMING WIRE FEE',
    0.0, 15.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000182', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0125'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'DOMESTIC INCOMING WIRE FEE',
    15.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0126', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-09-11',
    'Expense',
    'THE HOME DEPOT #6525 HOUSTON TX      197308  09/11',
    0.0, 158.09, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000183', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0126'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'THE HOME DEPOT #6525 HOUSTON TX      197308  09/11',
    44.12, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000184', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0126'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WAL-MART #5460 PORTLAND TX                   09/11',
    113.97, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0127', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-09-14',
    'Expense',
    'HARBOR FREIGHT TOOLS 5 HOUSTON TX            09/14',
    0.0, 326.93, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000185', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0127'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'HARBOR FREIGHT TOOLS 5 HOUSTON TX            09/14',
    49.81, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000186', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0127'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WAL-MART #2257 HOUSTON TX                    09/14',
    277.12, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0128', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-09-15',
    'Expense',
    'CIRCLE K # 06979 217 N REFUGIO TX            09/15',
    0.0, 112.34, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000187', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0128'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # 06979 217 N REFUGIO TX            09/15',
    50.02, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000188', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0128'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'STAR STOP 127 10231 CL HOUSTON TX    419391  09/15',
    50.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000189', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0128'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Wal-Mart Super Center PORTLAND TX            09/15',
    12.32, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0129', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-09-18',
    'Expense',
    'THE HOME DEPOT #6525 HOUSTON TX      604317  09/18',
    0.0, 39.79, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000190', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0129'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'THE HOME DEPOT #6525 HOUSTON TX      604317  09/18',
    39.79, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0130', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-09-22',
    'Expense',
    'CIRCLE K # 06985 PORTLAND TX                 09/20',
    0.0, 100.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000191', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0130'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # 06985 PORTLAND TX                 09/20',
    50.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000192', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0130'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SPEEDY STOP 18 BEAUMONT TX                   09/22',
    50.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0131', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-10-12',
    'Deposit',
    'DEPOSIT  ID NUMBER 731777',
    20.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000193', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0131'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'DEPOSIT  ID NUMBER 731777',
    20.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0132', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-10-17',
    'Expense',
    'Online ACH Payment 11111604950 To 2WServices (_###4108)',
    0.0, 3235.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000194', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0132'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment 11111604950 To 2WServices (_###4108)',
    3235.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0133', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-11-01',
    'Deposit',
    'BOOK TRANSFER CREDIT B/O: ASIC MINERS US LLC ANDREW B GILTON LATHROP CA 95330 US TRN: 3740283305ES',
    20000.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000195', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0133'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BOOK TRANSFER CREDIT B/O: ASIC MINERS US LLC ANDREW B GILTON LATHROP CA 95330 US TRN: 3740283305ES',
    19000.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000196', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0133'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BOOK TRANSFER CREDIT B/O: ASIC MINERS US LLC ANDREW B GILTON LATHROP CA 95330 US TRN: 3710463305ES',
    1000.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0134', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-11-01',
    'Expense',
    'STANDARD ACH PMNTS INITIAL FEE',
    0.0, 7716.25, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000197', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0134'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'STANDARD ACH PMNTS INITIAL FEE',
    2.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000198', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0134'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment 11113070562 To 2WServices (_###4108)',
    7713.75, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0135', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-11-13',
    'Expense',
    'ATT*BILL PAYMENT 800-288-2020 TX             11/10',
    0.0, 485.01, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000199', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0135'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ATT*BILL PAYMENT 800-288-2020 TX             11/10',
    485.01, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0136', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-11-27',
    'Expense',
    'MURPHY7018ATWAL WHARTON TX                   11/27',
    0.0, 1618.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000200', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0136'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MURPHY7018ATWAL WHARTON TX                   11/27',
    52.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000201', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0136'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment 11115322057 To PPS (_######9165)',
    1530.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000202', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0136'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BREAKTIME HOUSTON TX                         11/27',
    36.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0137', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-11-29',
    'Expense',
    'CIRCLE K # 06983 10537 MATHIS TX             11/29',
    0.0, 140.97, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000203', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0137'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # 06983 10537 MATHIS TX             11/29',
    49.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000204', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0137'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Alamo Lumber Company M Mathis TX     531499  11/29',
    59.51, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000205', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0137'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Alamo Lumber Company M Mathis TX     900676  11/29',
    32.46, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0138', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-11-30',
    'Expense',
    'NAPA MATHIS MATHIS TX                        11/29',
    0.0, 550.61, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000206', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0138'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NAPA MATHIS MATHIS TX                        11/29',
    7.57, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000207', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0138'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TALBOTT PROPANE 361-5753872 TX               11/29',
    529.49, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000208', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0138'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'FARM INDUSTRIAL VICTORIA TX                  11/29',
    13.55, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0139', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-01',
    'Expense',
    'CIRCLE K # 06983 10537 MATHIS TX             12/01',
    0.0, 77.00999999999999, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000209', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0139'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # 06983 10537 MATHIS TX             12/01',
    40.01, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000210', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0139'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'STANDARD ACH PMNTS INITIAL FEE QTY = 2',
    5.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000211', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0139'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BREAKTIME HOUSTON TX                         12/01',
    32.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0140', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-04',
    'Expense',
    'S M HERSCHAP ORANGE GROVE TX                 12/01',
    0.0, 91.96, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000212', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0140'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'S M HERSCHAP ORANGE GROVE TX                 12/01',
    91.96, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0141', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-05',
    'Expense',
    'ORIG CO NAME:ROLLO INSURANCE        ORIG ID:8263863381 DESC DATE:       CO ENTRY DESCR:J1996 OOFFSEC:CCD    TRACE#:111000028580367 EED:231205   IND ID:CZ10000584DAC                IND NAME:10NET ZERO INC.            TRN*1*CZ10000584DACRMR*IK*2D4865EB  CF27 42BD 8DEF B3C95B TRN: 3398580367TC',
    0.0, 1631.29, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000213', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0141'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:ROLLO INSURANCE        ORIG ID:8263863381 DESC DATE:       CO ENTRY DESCR:J1996 OOFFSEC:CCD    TRACE#:111000028580367 EED:231205   IND ID:CZ10000584DAC                IND NAME:10NET ZERO INC.            TRN*1*CZ10000584DACRMR*IK*2D4865EB  CF27 42BD 8DEF B3C95B TRN: 3398580367TC',
    1555.28, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000214', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0141'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # 06983 10537 MATHIS TX             12/05',
    34.01, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000215', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0141'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BREAKTIME HOUSTON TX                         12/05',
    42.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0142', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-07',
    'Expense',
    'Alamo Lumber Company M Mathis TX     255758  12/07',
    0.0, 44.34, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000216', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0142'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Alamo Lumber Company M Mathis TX     255758  12/07',
    11.34, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000217', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0142'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BREAKTIME HOUSTON TX                         12/07',
    33.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0143', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-09',
    'Journal Entry',
    'Acari Resources Generator Purchase',
    0.0, 232500.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000218', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0143'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2000'),
    'Acari Resources Generator Purchase',
    232500.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0144', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-11',
    'Expense',
    'STAR STOP 127 10231 CL HOUSTON TX    129164  12/11',
    0.0, 150.65, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000219', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0144'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'STAR STOP 127 10231 CL HOUSTON TX    129164  12/11',
    42.57, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000220', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0144'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # 06979 REFUGIO TX                  12/07',
    32.96, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000221', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0144'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'PANTRY STORE G UP BEEVILLE TX        388400  12/11',
    44.31, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000222', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0144'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'AGI*TMO SERVICE FEE 866-866-6285 PA          12/09',
    30.81, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0145', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-12',
    'Expense',
    'S M HERSCHAP ORANGE GROVE TX                 12/11',
    0.0, 120.84, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000223', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0145'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'S M HERSCHAP ORANGE GROVE TX                 12/11',
    120.84, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0146', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-13',
    'Expense',
    'FESCO LTD 3616617000X15 TX                   12/12',
    0.0, 66.95, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000224', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0146'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'FESCO LTD 3616617000X15 TX                   12/12',
    66.95, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0147', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-21',
    'Expense',
    'SHELL OIL 10003969002 FULSHEAR TX            12/20',
    0.0, 39.38, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000225', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0147'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SHELL OIL 10003969002 FULSHEAR TX            12/20',
    39.38, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0148', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-28',
    'Deposit',
    'Online Transfer from CHK ...5317 transaction#: 19418685359',
    1165000.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000226', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0148'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Transfer from CHK ...5317 transaction#: 19418685359',
    1165000.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0149', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-29',
    'Journal Entry',
    'Journal Entry - 2023-12-29',
    12912.5, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000227', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0149'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1410'),
    '',
    12912.5, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0150', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-29',
    'Deposit',
    'FEDWIRE CREDIT VIA: GUARANTY BANK & TRUST, N.A./111915327 B/O: OPERATION ORANGE LLC FORT WORTH TEXAS 76109 REF: CHASE NYC/CTR/BNF=10NETZERO, INC. HOUSTON TX 77080-1526 US/AC-00000000 5231 RFB=O/B GUARANTY BK& IMAD: 1229GMQFMP01037690 TRN: 1304351363FF',
    250000.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000228', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0150'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'FEDWIRE CREDIT VIA: GUARANTY BANK & TRUST, N.A./111915327 B/O: OPERATION ORANGE LLC FORT WORTH TEXAS 76109 REF: CHASE NYC/CTR/BNF=10NETZERO, INC. HOUSTON TX 77080-1526 US/AC-00000000 5231 RFB=O/B GUARANTY BK& IMAD: 1229GMQFMP01037690 TRN: 1304351363FF',
    250000.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

