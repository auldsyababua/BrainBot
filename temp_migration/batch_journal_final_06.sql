-- Journal Entries Final Batch 6

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0100', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-04-03',
    'Expense',
    '9',
    NULL,
    'Orig CO Name:Bright Line Busi Orig ID:9215986202 Dase Date:230402 CO Entry Descr:Sale Sec:CCD Trace/l:021000025108083 Eed:230403 Ind ID: Orig CO Name:Bright Line Busi Orig ID:9215986202 Dase Date:230402 CO Entry Descr:Sale Sec:CCD Trace/l:021000025108083 Eed:230403 Ind ID:'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0100'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 285.0,
    'Orig CO Name:Bright Line Busi Orig ID:9215986202 Dase Date:230402 CO Entry Descr:Sale Sec:CCD Trace/l:021000025108083 Eed:230403 Ind ID: Orig CO Name:Bright Line Busi Orig ID:9215986202 Dase Date:230402 CO Entry Descr:Sale Sec:CCD Trace/l:021000025108083 Eed:230403 Ind ID:'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0100'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 25.0,
    'Online Stop Payment Fee'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0101', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-04-04',
    'Expense',
    '9',
    NULL,
    'Check No. 1748 - Pay to The Order Of: Crane Rental Division, Inc.'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0101'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 942.0,
    'Check No. 1748 - Pay to The Order Of: Crane Rental Division, Inc.'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0102', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-04-05',
    'Expense',
    '9',
    NULL,
    'Orig CO Name:Google Orig ID:F770493581 Deso Date: CO Entry Descr:Apps_Commesec:CCD Trace/1:091000016369241 Eed:230405 Ind ID:US003Txfwl Ind Name:Joel Fulford 
013148088 Debit Trn: 0956369241Tc'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0102'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 89.54,
    'Orig CO Name:Google Orig ID:F770493581 Deso Date: CO Entry Descr:Apps_Commesec:CCD Trace/1:091000016369241 Eed:230405 Ind ID:US003Txfwl Ind Name:Joel Fulford 
013148088 Debit Trn: 0956369241Tc'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0103', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-04-12',
    'Expense',
    '9',
    NULL,
    'Check No. 1749 - Pay to The Order Of: Dalton Trucking'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0103'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 2160.0,
    'Check No. 1749 - Pay to The Order Of: Dalton Trucking'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0104', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-04-13',
    'Expense',
    '9',
    NULL,
    'Overdraft Fee For Check 111749 IN The Amount of S2 160.00'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0104'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 34.0,
    'Overdraft Fee For Check 111749 IN The Amount of S2 160.00'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0105', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-04-17',
    'Deposit',
    '9',
    NULL,
    'Deposit 1155781395 - 10 Net Zero'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0105'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    211.25, 0,
    'Deposit 1155781395 - 10 Net Zero'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0106', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-06-06',
    'Deposit',
    '9',
    NULL,
    'Write-Off'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0106'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    1986.29, 0,
    'Write-Off'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0107', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-07-02',
    'Journal Entry',
    '3',
    NULL,
    'Journal Entry - 2023-07-02'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0107'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-6010'),
    1,
    25000.0, 0,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0108', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-07-26',
    'Deposit',
    '3',
    'David',
    'DEPOSIT  ID NUMBER  44150'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0108'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    50000.0, 0,
    'DEPOSIT  ID NUMBER  44150'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0109', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-08-08',
    'Expense',
    '3',
    'ACARI RESOURCES LLC',
    'DOMESTIC WIRE TRANSFER VIA: PNCBANK PITT/043000096 A/C: ACARI RESOURCES LTD. REF: DOWN PAYMENT IMAD: 0808B1QGC02C001521 TRN: 3673763219ES 08/08

MWM Generator purchase - sold to Operation Orange'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0109'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 50000.0,
    'DOMESTIC WIRE TRANSFER VIA: PNCBANK PITT/043000096 A/C: ACARI RESOURCES LTD. REF: DOWN PAYMENT IMAD: 0808B1QGC02C001521 TRN: 3673763219ES 08/08

MWM Generator purchase - sold to Operation Orange'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0109'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 35.0,
    'DOMESTIC WIRE FEE'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0110', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-08-10',
    'Deposit',
    '3',
    'Asics Miners US',
    'CHIPS CREDIT VIA: BANK OF AMERICA, N.A./0959 B/O: ASIC MINERS US LLC LATHROP, CA, 95330 US REF: NBNF=10NETZERO, INC. HOUSTON TX 77080-1526 US/AC-000000005231 ORG=/325 177590254 LATHROP, CA, 95330 US OGB =BANK OF AMERICA, N.A. NEW YORK NY US OBI=INVOICE 106 BBI=/CHGS/USD0,/ SSN: 0454183 TRN: 1069800222FC'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0110'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    49189.0, 0,
    'CHIPS CREDIT VIA: BANK OF AMERICA, N.A./0959 B/O: ASIC MINERS US LLC LATHROP, CA, 95330 US REF: NBNF=10NETZERO, INC. HOUSTON TX 77080-1526 US/AC-000000005231 ORG=/325 177590254 LATHROP, CA, 95330 US OGB =BANK OF AMERICA, N.A. NEW YORK NY US OBI=INVOICE 106 BBI=/CHGS/USD0,/ SSN: 0454183 TRN: 1069800222FC'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0111', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-08-10',
    'Expense',
    '3',
    NULL,
    'DOMESTIC INCOMING WIRE FEE'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0111'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 15.0,
    'DOMESTIC INCOMING WIRE FEE'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0112', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-08-11',
    'Expense',
    '3',
    NULL,
    'ATM WITHDRAWAL                       005935  08/119704 KATY'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0112'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 420.0,
    'ATM WITHDRAWAL                       005935  08/119704 KATY'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0113', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-08-14',
    'Expense',
    '3',
    'United Oilfield Services',
    'Online ACH Payment 11027377566 To UnitedOFS (_#####2100)'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0113'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 1140.6,
    'Online ACH Payment 11027377566 To UnitedOFS (_#####2100)'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0113'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 1090.0,
    'Online ACH Payment 11027378428 To MartinLG (_######7156)'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0113'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 500.0,
    'ATM WITHDRAWAL                       006886  08/129704 KATY'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0113'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 20.0,
    'ATM WITHDRAWAL                       007857  08/139704 KATY'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0113'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 100.0,
    'ATM WITHDRAWAL                       008174  08/149704 KATY'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0113'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 805.8,
    'CHECK 1139'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0114', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-08-17',
    'Expense',
    '3',
    NULL,
    'ATM WITHDRAWAL                       000035  08/179704 KATY'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0114'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 660.0,
    'ATM WITHDRAWAL                       000035  08/179704 KATY'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0115', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-08-18',
    'Expense',
    '3',
    'Joel Fulford',
    'ORIG CO NAME:BANK OF AMERICA        ORIG ID:941687665G DESC DATE:230817 CO ENTRY DESCR:Payment   SEC:TEL    TRACE#:111000027042130 EED:230818   IND ID:qftmlixpr                    IND NAME:FULFORD, JOEL TRN: 2307042130TC'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0115'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 511.03,
    'ORIG CO NAME:BANK OF AMERICA        ORIG ID:941687665G DESC DATE:230817 CO ENTRY DESCR:Payment   SEC:TEL    TRACE#:111000027042130 EED:230818   IND ID:qftmlixpr                    IND NAME:FULFORD, JOEL TRN: 2307042130TC'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0115'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 1135.28,
    'ORIG CO NAME:BANK OF AMERICA        ORIG ID:941687665G DESC DATE:230817 CO ENTRY DESCR:Payment   SEC:TEL    TRACE#:111000027042133 EED:230818   IND ID:15uv7rhdt                    IND NAME:FULFORD, JOEL TRN: 2307042133TC'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0116', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-08-21',
    'Expense',
    '3',
    NULL,
    'GEICO  *AUTO 800-841-3000 DC                 08/20'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0116'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 689.48,
    'GEICO  *AUTO 800-841-3000 DC                 08/20'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0117', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-08-22',
    'Expense',
    '3',
    '2W Services',
    'Online ACH Payment 11028118576 To 2WServices (_###4108)'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0117'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 4365.0,
    'Online ACH Payment 11028118576 To 2WServices (_###4108)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0118', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-08-23',
    'Deposit',
    '3',
    'David',
    'DEPOSIT  ID NUMBER  66994'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0118'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    50000.0, 0,
    'DEPOSIT  ID NUMBER  66994'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0119', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-08-23',
    'Expense',
    '3',
    'Petroleum Producing Services',
    'Online ACH Payment 11028171343 To PPS (_######9165)'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0119'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 9027.0,
    'Online ACH Payment 11028171343 To PPS (_######9165)'
);

