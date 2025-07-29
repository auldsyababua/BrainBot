-- Journal Entries Final Batch 26

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0500', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-14',
    'Deposit',
    '1018',
    NULL,
    'ORIG CO NAME:INTUIT ORIG ID:XXXXXX6206 DESC DATE:250214 CO ENTRY DESCR:ACCTVERIFYSEC:PPD TRACE#:XXXXXXXX3003159 EED:250214 IND ID: IND NAME:10NETZERO, INC. TRN: XXXXXX3159TC'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0500'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0.17, 0,
    'ORIG CO NAME:INTUIT ORIG ID:XXXXXX6206 DESC DATE:250214 CO ENTRY DESCR:ACCTVERIFYSEC:PPD TRACE#:XXXXXXXX3003159 EED:250214 IND ID: IND NAME:10NETZERO, INC. TRN: XXXXXX3159TC'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0501', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-14',
    'Expense',
    '1018',
    'Martin Legal PLLC',
    'Online ACH Payment XXXXXXX0351 To MartinLegal (_#####2006)'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0501'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 840.0,
    'Online ACH Payment XXXXXXX0351 To MartinLegal (_#####2006)'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0501'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 0.19,
    'INTUIT *QBooks Onlin CL.INTUIT.COM CA 11/13'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0502', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-14',
    'Check',
    '5670',
    NULL,
    'CHECK # 5670'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0502'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 1900.0,
    'CHECK # 5670'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0503', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-15',
    'Expense',
    '5670',
    NULL,
    'TACTACAM WWW.REVEALCEL MN 02/15'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0503'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 9.0,
    'TACTACAM WWW.REVEALCEL MN 02/15'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0503'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 9.0,
    'TACTACAM WWW.REVEALCEL MN 02/15'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0504', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-17',
    'Expense',
    '5670',
    'Circle K',
    'CIRCLE K #XXX0595 RIVERSIDE TX XX1442 02/17'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0504'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 45.0,
    'CIRCLE K #XXX0595 RIVERSIDE TX XX1442 02/17'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0504'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 22.79,
    'CHIPOTLE 0170 HOUSTON TX 02/17'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0504'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 50.0,
    'BROOKSHIRE BROTHERS #8 CROCKETT TX XX6896 02/17'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0505', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-18',
    'Expense',
    '5670',
    'Walmart',
    'WAL-MART #4111 RICHMOND TX XX1300 02/18'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0505'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 61.89,
    'WAL-MART #4111 RICHMOND TX XX1300 02/18'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0506', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-19',
    'Expense',
    '5670',
    'FedEx',
    'BUC-EE''S 24 XXX-XXX-6390 TX 02/19'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0506'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 45.0,
    'BUC-EE''S 24 XXX-XXX-6390 TX 02/19'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0506'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 2262.21,
    'Online Payment XXXXXXX4220 To UNITED RENTALS (NORTH AMERICA),INC. 02/19'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0506'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 81.13,
    'FEDEXXXXXX3729 XXX-XXX3339 TN 02/20'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0507', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-20',
    'Expense',
    '5670',
    'Gusto',
    'TX.GOV*SERVICEFEE-DI WWW.TEXAS.GOV TX 02/20'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0507'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 6.0,
    'TX.GOV*SERVICEFEE-DI WWW.TEXAS.GOV TX 02/20'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0507'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 3280.67,
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250220 CO ENTRY DESCR:NET XX2394SEC:CCD TRACE#:XXXXXXXX0705880 EED:250220 IND ID:6 semk3nvpst IND NAME:10NetZero, Inc. 6semjncmfjq TRN: XXXXXX5880 TC'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0507'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 1204.73,
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250220 CO ENTRY DESCR:TAX XX2424SEC:CCD TRACE#:XXXXXXXX0730773 EED:250220 IND ID:6 semk3nvpsu IND NAME:10NetZero, Inc. 6semjncmfko TRN: XXXXXX0773 TC'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0507'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 574.75,
    'FORT BEND VEHREG WWW.TEXAS.GOV TX 02/20'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0507'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 179.76,
    'J & W PARTS EAGLE LAKE TX 02/20'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0507'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 128.02,
    'J & W PARTS EAGLE LAKE TX 02/20'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0508', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-21',
    'Deposit',
    '5670',
    NULL,
    'J & W PARTS EAGLE LAKE TX 02/21'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0508'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    244.57, 0,
    'J & W PARTS EAGLE LAKE TX 02/21'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0509', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-21',
    'Expense',
    '5670',
    NULL,
    'O''REILLY 6123 EAGLE LAKE TX 02/21'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0509'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 242.33,
    'O''REILLY 6123 EAGLE LAKE TX 02/21'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0509'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 6.32,
    'APPLE LUMBER BRANCH 40 EAGLE LAKE TX XX5596 02/21'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0509'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 57.39,
    'TAQUERIA AZTECA D.F EAGLE LAKE TX 02/21'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0509'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 222.98,
    'APPLE LUMBER BRANCH 40 EAGLE LAKE TX XX8523 02/21'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0510', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-24',
    'Expense',
    '5670',
    'Circle K',
    'CIRCLE K #XXX2369 HOUSTON TX XX1769 02/24'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0510'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 20.0,
    'CIRCLE K #XXX2369 HOUSTON TX XX1769 02/24'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0510'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 15.59,
    'PHOENICIA MKT BAR HOUSTON TX 02/24'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0510'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 66.28,
    'J & K KORNER STORE EAGLE LAKE TX XX9516 02/24'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0510'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 25.0,
    'X1538-HOUSTON CENTER GA HOUSTON TX 02/24'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0511', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-25',
    'Expense',
    '5670',
    NULL,
    'Online ACH Payment XXXXXXX0977 To Zedcire (_########0274)'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0511'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 2435.63,
    'Online ACH Payment XXXXXXX0977 To Zedcire (_########0274)'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0511'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 2500.0,
    'DARK HORSE CPAS WWW.DARKHORSE CA 02/25'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0511'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 5500.0,
    'Online ACH Payment XXXXXXX0489 To MaximalistIII (_####9857)'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0511'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 1104.15,
    'Online ACH Payment XXXXXXX1411 To Zedcire (_########0274)'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0511'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 78.57,
    'Online ACH Payment XXXXXXX3838 To Zedcire (_########0274)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0512', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-26',
    'Expense',
    '5670',
    'Taco Bell',
    'TST*TACOS DONA LENA Houston TX 02/26'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0512'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 34.21,
    'TST*TACOS DONA LENA Houston TX 02/26'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0512'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 1754.24,
    'FEDEXXXXXX5675 XXX-XXX3339 TN 02/27'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0513', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-27',
    'Expense',
    '5670',
    'Circle K',
    'CORPUS MM/GAS XX0273 CORPUS CHRIS TX XX9531 02/27'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0513'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 74.0,
    'CORPUS MM/GAS XX0273 CORPUS CHRIS TX XX9531 02/27'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0513'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 2162.0,
    'Online Payment XXXXXXX2209 To Kebo Oil and Gas, INC 02/27'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0513'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 44.0,
    'CIRCLE K # X6983 MATHIS TX XX5629 02/27'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0513'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 6.5,
    'MCDONALD''S FX0850 MATHIS TX 02/27'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0513'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 40.0,
    'CIRCLE K #XXX1403 ROSENBERG TX XX6977 02/27'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0513'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 559.27,
    'ATT*BILL PAYMENT XXX-XXX-2020 TX 02/28'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0513'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    7,
    0, 3280.67,
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250227 CO ENTRY DESCR:NET XX2028SEC:CCD TRACE#:XXXXXXXX0527508 EED:250227 IND ID:6 semk3pkgj4 IND NAME:10NetZero, Inc. 6semjncsiic TRN: XXXXXX7508 TC'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0513'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    8,
    0, 1204.73,
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250227 CO ENTRY DESCR:TAX XX2096SEC:CCD TRACE#:XXXXXXXX0525579 EED:250227 IND ID:6 semk3pkgj5 IND NAME:10NetZero, Inc. 6semjncsikg TRN: XXXXXX5579 TC'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0513'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    9,
    0, 238.13,
    'BEST BUY XXXX6031 VICTORIA TX XX2038 02/27'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0514', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-04',
    'Invoice',
    '1019',
    'WasteWatt Ventures LLC',
    'Invoice - 2025-03-04'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0514'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    1,
    3332.33, 0,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0515', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-04',
    'Invoice',
    '1026',
    'Upstream Data, LLC',
    'Invoice - 2025-03-04'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0515'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    1,
    3110.0, 0,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0516', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-04',
    'Expense',
    '1027',
    NULL,
    'BUC-EE''S 24 XXX-XXX-6390 TX 03/04'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0516'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 30.0,
    'BUC-EE''S 24 XXX-XXX-6390 TX 03/04'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0516'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 132.0,
    'FOREMAN.MN FOREMAN.MN MD 03/05'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0517', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-04',
    'Invoice',
    '1027',
    'Upstream Data, LLC',
    'Invoice - 2025-03-04'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0517'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    1,
    6759.74, 0,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0518', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-05',
    'Expense',
    '1027',
    'Gusto',
    'SERVICE CHARGES FOR THE MONTH OF FEBRUARY'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0518'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 51.05,
    'SERVICE CHARGES FOR THE MONTH OF FEBRUARY'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0518'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 95.94,
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4007 DESC DATE:250305 CO ENTRY DESCR:FEE XX0183SEC:CCD TRACE#:XXXXXXXX1590107 EED:250305 IND ID:6 semk3s5sqo IND NAME:10NetZero, Inc. 6semjnd526n TRN: XXXXXX0107 TC'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0519', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-03-05',
    'Payment',
    '1027',
    'WasteWatt Ventures LLC',
    'Payment - 2025-03-05'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0519'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    3332.33, 0,
    ''
);

