-- Journal Entries Final Batch 12

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0220', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-03',
    'Expense',
    '5675',
    'HeatCore Inc',
    'BUC-EE''S #30 WHARTON TX 04/02'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0220'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 74.84,
    'BUC-EE''S #30 WHARTON TX 04/02'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0220'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 17.5,
    'SERVICE CHARGES FOR THE MONTH OF MARCH'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0220'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 34750.0,
    'ONLINE DOMESTIC WIRE TRANSFER A/C: HEATCORE INC FRISCO TX XXXXX-9485 US REF: INVOICE XX0401 TRN: XXXXXX4094 ES 04/03'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0221', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-04',
    'Expense',
    '5675',
    'ACARI RESOURCES LLC',
    'IN *SPINDLETOP ENERGY XXX-XXX5863 TX 04/04'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0221'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 342.33,
    'IN *SPINDLETOP ENERGY XXX-XXX5863 TX 04/04'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0221'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 200000.0,
    'DOMESTIC WIRE TRANSFER VIA: PNCBANK PITT/XXXXX0096 A/C: ACARI RESOURCES LTD. IMAD: 0404MMQFMP2MXX1835 TRN: XXXXXX4095 ES 04/04'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0222', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-05',
    'Expense',
    '5675',
    'Chick-Fil-A',
    'CHICK-FIL-A #X3312 BEAUMONT TX 04/05'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0222'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 13.16,
    'CHICK-FIL-A #X3312 BEAUMONT TX 04/05'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0222'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 559.66,
    'ORIG CO NAME:IPFSXXX-XXX-2621 ORIG ID:0 ADXXX4370 DESC DATE: CO ENTRY DESCR:IPFSPMTTXPSEC:CCD TRACE#:XXXXXXXX0910291 EED:240405 IND ID:62397 IND NAME:10 NET ZERO INC. GDxLk2vV TRN: XXXXXX0291 TC'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0222'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 40.0,
    'SPEEDY STOP 18 BEAUMONT TX 04/05'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0222'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 10.0,
    '9235 CLAY ROAD HOUSTON TX 04/05'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0223', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-08',
    'Expense',
    '5675',
    'Bobcat Crane',
    'PANDADOC, INC. XXX-XXX-8755 CA 04/08'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0223'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 69.29,
    'PANDADOC, INC. XXX-XXX-8755 CA 04/08'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0223'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 1108.0,
    'Online ACH Payment XXXXXXX0230 To BobcatCrane (_####4024)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0224', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-09',
    'Expense',
    '5675',
    'Martin Legal PLLC',
    'EL TIEMPO CANTINA WASH XXX-XXX3645 TX 04/08'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0224'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 56.93,
    'EL TIEMPO CANTINA WASH XXX-XXX3645 TX 04/08'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0224'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 4865.0,
    'Online ACH Payment XXXXXXX0351 To MartinLegal (_#####2006)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0225', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-10',
    'Expense',
    '5675',
    'Adobe',
    'ADOBE *ADOBE XXX-XXX-6000 CA 04/10'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0225'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 21.64,
    'ADOBE *ADOBE XXX-XXX-6000 CA 04/10'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0225'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 46.78,
    'WAL-MART #4111 RICHMOND TX 04/10'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0226', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-12',
    'Expense',
    '5675',
    NULL,
    'ORIG CO NAME:ROLLO INSURANCE ORIG ID:XXXXXX3381 DESC DATE: CO ENTRY DESCR:J2125 OOFFSEC:CCD TRACE#:XXXXXXXX7366559 EED:240412 IND ID:CZXX0006QXNPC IND NAME:10 N ET ZERO INC TRN*1 *CZXX0006QXNPC\RMR*IK*CABE092A B561 4CBC B77B 009B0B\ TRN: XXXXXX6559 TC'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0226'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 3129.0,
    'ORIG CO NAME:ROLLO INSURANCE ORIG ID:XXXXXX3381 DESC DATE: CO ENTRY DESCR:J2125 OOFFSEC:CCD TRACE#:XXXXXXXX7366559 EED:240412 IND ID:CZXX0006QXNPC IND NAME:10 N ET ZERO INC TRN*1 *CZXX0006QXNPC\RMR*IK*CABE092A B561 4CBC B77B 009B0B\ TRN: XXXXXX6559 TC'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0227', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-14',
    'Expense',
    '5675',
    NULL,
    'TST* MARQUIS II HOUSTON TX 04/14'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0227'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 6.31,
    'TST* MARQUIS II HOUSTON TX 04/14'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0228', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-15',
    'Expense',
    '5675',
    NULL,
    '7-ELEVEN HOUSTON TX 04/15'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0228'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 20.0,
    '7-ELEVEN HOUSTON TX 04/15'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0229', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-16',
    'Expense',
    '5675',
    'Kebo Oil and Gas',
    '7-ELEVEN X1261 CYPRESS TX 04/16'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0229'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 20.0,
    '7-ELEVEN X1261 CYPRESS TX 04/16'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0229'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 6109.05,
    'Online Payment XXXXXXX2293 To Kebo Oil and Gas, INC 04/16'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0229'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 190.52,
    'Online Payment XXXXXXX6028 To Hard Core Supply LLC 04/16'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0229'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 1035.83,
    'Online Payment XXXXXXX0670 To Hard Core Supply LLC 04/16'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0229'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 2240.32,
    'Online Payment XXXXXXX5143 To Hard Core Supply LLC 04/16'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0229'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 3717.24,
    'Online Payment XXXXXXX0663 To Lagarto Rental Tools, Inc 04/16'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0229'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    7,
    0, 977.5,
    'Online Payment XXXXXXX3149 To 2W Services 04/16'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0229'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    8,
    0, 1044.35,
    'Online Payment XXXXXXX6581 To HadCo Services 04/16'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0230', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-18',
    'Expense',
    '5675',
    'Chick-Fil-A',
    'CHICK-FIL-A #X1244 TOMBALL TX 04/18'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0230'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 10.77,
    'CHICK-FIL-A #X1244 TOMBALL TX 04/18'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0231', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-19',
    'Expense',
    '5675',
    'Murillo Lease Service LLC',
    'Online ACH Payment XXXXXXX2307 To Bernardo (_######3816)'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0231'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 952.0,
    'Online ACH Payment XXXXXXX2307 To Bernardo (_######3816)'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0231'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 3500.0,
    'Online Payment XXXXXXX8996 To Jimmy Canton 04/19 - Gas Meter'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0232', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-22',
    'Check',
    '1140',
    'Joel Fulford',
    'CHECK # 1140'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0232'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 1125.6,
    'CHECK # 1140'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0233', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-22',
    'Expense',
    '5675',
    'McKain Power Systems',
    'Online ACH Payment XXXXXXX0245 To MckainRentals (_######4889)'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0233'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 23688.7,
    'Online ACH Payment XXXXXXX0245 To MckainRentals (_######4889)'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0233'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 10313.83,
    'Online ACH Payment XXXXXXX3319 To McKainPower (_######4723)'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0233'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 794.27,
    'Online Payment XXXXXXX0790 To United Oilfield Services 04/22'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0234', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-23',
    'Expense',
    '1140',
    'Holt CAT',
    'HOLT CAT-MC CORPUS CHRIST TX 04/23'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0234'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 1833.55,
    'HOLT CAT-MC CORPUS CHRIST TX 04/23'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0234'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 2817.96,
    'HOLT CAT-MC XXX-XXX-2200 TX 04/23'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0235', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-24',
    'Expense',
    '1140',
    'Chick-Fil-A',
    'CHICK-FIL-A #X1244 TOMBALL TX 04/24'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0235'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 26.35,
    'CHICK-FIL-A #X1244 TOMBALL TX 04/24'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0235'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 2142.0,
    'Online ACH Payment XXXXXXX5822 To Bernardo (_######3816)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0236', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-25',
    'Deposit',
    '1140',
    'Zapata II, LLC',
    'Online Transfer from CHK ...5317 transaction#: XXXXXXX5149'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0236'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    150000.0, 0,
    'Online Transfer from CHK ...5317 transaction#: XXXXXXX5149'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0237', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-25',
    'Expense',
    '1140',
    'F3X Energy Services',
    'WITHDRAWAL 04/25 - Generator Repair Tomball'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0237'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 40000.0,
    'WITHDRAWAL 04/25 - Generator Repair Tomball'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0238', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-29',
    'Expense',
    '1140',
    'AT&T',
    'ATT* BILL PAYMENT XXX-XXX-0500 TX 04/29'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0238'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 242.68,
    'ATT* BILL PAYMENT XXX-XXX-0500 TX 04/29'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0239', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-04-30',
    'Expense',
    '1140',
    NULL,
    'MURPHY7671ATWAL KATY TX 04/30'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0239'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 20.01,
    'MURPHY7671ATWAL KATY TX 04/30'
);

