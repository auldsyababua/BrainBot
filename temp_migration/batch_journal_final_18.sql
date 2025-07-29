-- Journal Entries Final Batch 18

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0340', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-16',
    'Expense',
    'DH38',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX5258 08/16'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0340'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 30.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX5258 08/16'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0340'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 50000.0,
    'Online ACH Payment XXXXXXX4372 To F3XJamesandDusty (_#####7276)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0341', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-20',
    'Expense',
    'DH38',
    'Kebo Oil and Gas',
    'Online Payment XXXXXXX0394 To Kebo Oil and Gas, INC 08/20'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0341'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 3421.0,
    'Online Payment XXXXXXX0394 To Kebo Oil and Gas, INC 08/20'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0341'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 9555.3,
    'Online ACH Payment XXXXXXX2856 To JohnSchillereff (_#####5067)'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0341'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 2689.0,
    'Online ACH Payment XXXXXXX2779 To Bernardo (_######3816)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0342', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-23',
    'Journal Entry',
    'DH1',
    NULL,
    'To reclassify the shipping expense from the balance sheet to the P&L under "Shipping & postage."'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0342'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1310'),
    1,
    0, 1300.0,
    'To reclassify the shipping expense from the balance sheet to the P&L under "Shipping & postage."'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0343', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-23',
    'Expense',
    'DH38',
    'Kebo Oil and Gas',
    'Online Payment XXXXXXX8633 To Kebo Oil and Gas, INC 08/23'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0343'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 2250.0,
    'Online Payment XXXXXXX8633 To Kebo Oil and Gas, INC 08/23'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0343'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 2325.0,
    'Online Payment XXXXXXX8213 To Kebo Oil and Gas, INC 08/23'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0343'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 5723.51,
    'Online ACH Payment XXXXXXX5973 To Bernardo (_######3816)'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0343'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 1300.0,
    'ORIG CO NAME:Express Transpor ORIG ID:204876018 DESC DATE:Aug 23 CO ENTRY DESCR:10 net zerSEC:CCD TRACE#:XXXXXXXX1320822 EED:240823 IND ID:connie IND NAME:10 ne t zero TRN: XXXXXX0822 TC'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0344', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-26',
    'Expense',
    'DH1',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX1601 08/26'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0344'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 3.44,
    'CIRCLE K #XXX1915 CYPRESS TX XX1601 08/26'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0344'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 30.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX7030 08/26'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0345', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-27',
    'Expense',
    'DH1',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX0503 08/27'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0345'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 20.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX0503 08/27'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0345'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 500.0,
    'WITHDRAWAL 08/27'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0346', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-28',
    'Deposit',
    'DH1',
    'Malama Energy',
    'FEDWIRE CREDIT VIA: WELLS FARGO BANK, N.A./XXXXX0248 B/O: MALAMA ENERGY INC CA X0803 REF: CHASE NYC/CTR/BNF=10NETZERO, INC. HOUSTON TX XXXXX-6626 US/AC-XXXX0000 5231 RFB=OWXXXXXXXXXX7284 BBI=/CHGS/USD0,00/ IMAD: 0828I1B7033RXX2415 TRN: XXXXXX1241 FF'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0346'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    8800.0, 0,
    'FEDWIRE CREDIT VIA: WELLS FARGO BANK, N.A./XXXXX0248 B/O: MALAMA ENERGY INC CA X0803 REF: CHASE NYC/CTR/BNF=10NETZERO, INC. HOUSTON TX XXXXX-6626 US/AC-XXXX0000 5231 RFB=OWXXXXXXXXXX7284 BBI=/CHGS/USD0,00/ IMAD: 0828I1B7033RXX2415 TRN: XXXXXX1241 FF'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0347', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-28',
    'Expense',
    'DH1',
    'Lowe''s',
    'RAISING CANES 0419 TOMBALL TX 08/28'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0347'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 29.63,
    'RAISING CANES 0419 TOMBALL TX 08/28'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0347'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 6.56,
    'LOWE''S #1052 TOMBALL TX XX5955 08/28'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0347'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 220.0,
    'SQ *FARMER TRAILER RENT RICHMOND TX 08/28'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0348', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-29',
    'Expense',
    'DH1',
    'Love''s Country Stores',
    'LOVE''S #0617 OUTSIDE HUNGERFORD TX 08/29'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0348'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 77.05,
    'LOVE''S #0617 OUTSIDE HUNGERFORD TX 08/29'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0348'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 3500.08,
    'Basic Online Payroll Payment XXXXXXX1202 to #########4504'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0348'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 10.0,
    '9235 CLAY ROAD BUSINES HOUSTON TX XX3890 08/29'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0348'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 425.0,
    'Online ACH Payment XXXXXXX0322 To GTCrane (_#####3597)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0349', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-30',
    'Expense',
    'DH1',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX1625 08/30'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0349'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 20.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX1625 08/30'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0349'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 20.0,
    'CIRCLE K #XXX1487 CYPRESS TX XX8073 08/30'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0349'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 1676.16,
    'Online ACH Payment XXXXXXX3776 To Encore (_######6224)'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0349'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 1902.59,
    'Online ACH Payment XXXXXXX3585 To Encore (_######6224)'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0349'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 937.13,
    'Online ACH Payment XXXXXXX1375 To Encore (_######6224)'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0349'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 40.0,
    'WAL-MART SUPER CENTER TOMBALL TX XX9084 08/30'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0350', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-31',
    'Expense',
    'DH1',
    'Chevron',
    'CHEVRON XXX4813 TOMBALL TX 08/30'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0350'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 92.19,
    'CHEVRON XXX4813 TOMBALL TX 08/30'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0350'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 110.0,
    'SQ *FARMER TRAILER RENT RICHMOND TX 08/30'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0351', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-09-03',
    'Expense',
    'DH1',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX7201 09/03'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0351'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 20.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX7201 09/03'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0351'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 2455.0,
    'Online ACH Payment XXXXXXX7962 To BobcatCrane (_####4024)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0352', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-09-04',
    'Expense',
    'DH1',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX0473 09/04'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0352'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 20.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX0473 09/04'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0352'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 64.93,
    'LOWE''S #1052 TOMBALL TX XX2068 09/04'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0353', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-09-05',
    'Expense',
    'DH1',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX2027 09/05'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0353'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 10.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX2027 09/05'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0353'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 40.0,
    'SERVICE CHARGES FOR THE MONTH OF AUGUST'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0353'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 559.66,
    'ORIG CO NAME:IPFSXXX-XXX-2621 ORIG ID:0 ADXXX4370 DESC DATE: CO ENTRY DESCR:IPFSPMTTXPSEC:CCD TRACE#:XXXXXXXX3590087 EED:240905 IND ID:62397 IND NAME:10 NET ZERO INC. GDxLk2vV TRN: XXXXXX0087 TC'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0353'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 1538.0,
    'Online ACH Payment XXXXXXX2982 To JohnSchillereff (_#####5067)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0354', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-09-08',
    'Expense',
    'DH1',
    NULL,
    'ARLO TECHNOLOGIES INC XXX-XXX-3750 CA 09/09'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0354'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 8.52,
    'ARLO TECHNOLOGIES INC XXX-XXX-3750 CA 09/09'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0355', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-09-09',
    'Expense',
    'DH1',
    NULL,
    'NETLIFY HTTPSWWW.NETL CA 09/09'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0355'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 20.25,
    'NETLIFY HTTPSWWW.NETL CA 09/09'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0356', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-09-10',
    'Expense',
    'DH1',
    'Adobe',
    'ADOBE *XXX-XXX-6687 ADOBE.LY/ENUS CA 09/11'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0356'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 21.64,
    'ADOBE *XXX-XXX-6687 ADOBE.LY/ENUS CA 09/11'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0357', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-09-11',
    'Expense',
    'DH1',
    'Single Source Supply LLC',
    'Online ACH Payment XXXXXXX2346 To JoeSingleSourceLufkin (_#####6386)'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0357'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 6765.63,
    'Online ACH Payment XXXXXXX2346 To JoeSingleSourceLufkin (_#####6386)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0358', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-09-12',
    'Expense',
    'DH1',
    NULL,
    'PHOENICIA MKT BAR HOUSTON TX 09/12'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0358'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 135.06,
    'PHOENICIA MKT BAR HOUSTON TX 09/12'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0359', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-09-13',
    'Expense',
    '1002',
    'Spindletop Energy Products',
    'Online ACH Payment XXXXXXX7421 To Spindletop (_####7533)'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0359'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 2790.71,
    'Online ACH Payment XXXXXXX7421 To Spindletop (_####7533)'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0359'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 18.66,
    'INTUIT *QBooks Onlin CL.INTUIT.COM CA 09/13'
);

