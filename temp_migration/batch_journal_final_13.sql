-- Journal Entries Final Batch 13

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0240', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-02',
    'Expense',
    '1140',
    'LinkedIn',
    'LinkedIn SN XXXXXX4626 XXX-XXX5653 CA 05/02'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0240'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 106.59,
    'LinkedIn SN XXXXXX4626 XXX-XXX5653 CA 05/02'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0241', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-03',
    'Expense',
    '1140',
    '2W Services',
    'STAR STOP X0231 CLAY R HOUSTON TX 05/03'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0241'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 45.0,
    'STAR STOP X0231 CLAY R HOUSTON TX 05/03'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0241'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 25.45,
    'SERVICE CHARGES FOR THE MONTH OF APRIL'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0241'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 8.32,
    'MCDONALD''S FX9431 CYPRESS TX 05/03'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0241'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 6369.69,
    'Online Payment XXXXXXX8090 To 2W Services 05/03'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0241'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 2173.28,
    'ULINE *SHIP SUPPLIES XXX-XXX-5510 WI 05/04'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0242', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-06',
    'Expense',
    '1140',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX7787 05/06'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0242'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 10.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX7787 05/06'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0242'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 9.3,
    'MCDONALD''S FX9431 CYPRESS TX 05/06'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0243', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-07',
    'Expense',
    '1140',
    NULL,
    'ORIG CO NAME:IPFSXXX-XXX-2621 ORIG ID:0 ADXXX4370 DESC DATE: CO ENTRY DESCR:IPFSPMTTXPSEC:CCD TRACE#:XXXXXXXX7906413 EED:240507 IND ID:62397 IND NAME:10 NET ZERO INC. GDxLk2vV TRN: XXXXXX6413 TC'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0243'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 559.66,
    'ORIG CO NAME:IPFSXXX-XXX-2621 ORIG ID:0 ADXXX4370 DESC DATE: CO ENTRY DESCR:IPFSPMTTXPSEC:CCD TRACE#:XXXXXXXX7906413 EED:240507 IND ID:62397 IND NAME:10 NET ZERO INC. GDxLk2vV TRN: XXXXXX6413 TC'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0244', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-08',
    'Expense',
    '1140',
    NULL,
    'PANDADOC, INC. XXX-XXX-8755 CA 05/08'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0244'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 69.29,
    'PANDADOC, INC. XXX-XXX-8755 CA 05/08'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0245', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-09',
    'Expense',
    '1140',
    NULL,
    'NETLIFY HTTPSWWW.NETL CA 05/09'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0245'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 1.25,
    'NETLIFY HTTPSWWW.NETL CA 05/09'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0246', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-13',
    'Expense',
    '1140',
    'Papa John''s',
    'PAPA JOHNS #X0035 LETHBRIDGE AB 05/13 CA DOLLAR 48.78 X 0.XXX7023 (EXCHG RTE)'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0246'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 35.79,
    'PAPA JOHNS #X0035 LETHBRIDGE AB 05/13 CA DOLLAR 48.78 X 0.XXX7023 (EXCHG RTE)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0247', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-15',
    'Deposit',
    '1140',
    NULL,
    'Reversal: PAPA JOHNS #X0035 LETHBRIDGE AB 05/13 CA DOLLAR 48.78 X 0.XXX7023 (EXCHG RTE) ClaimId: XXXXX7244'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0247'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    35.79, 0,
    'Reversal: PAPA JOHNS #X0035 LETHBRIDGE AB 05/13 CA DOLLAR 48.78 X 0.XXX7023 (EXCHG RTE) ClaimId: XXXXX7244'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0248', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-15',
    'Expense',
    '1140',
    NULL,
    'LA RIBERA TAQUERIA & RE REFUGIO TX 05/15'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0248'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 24.08,
    'LA RIBERA TAQUERIA & RE REFUGIO TX 05/15'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0248'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 64.92,
    'O''REILLY 1238 MATHIS TX XX0318 05/15'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0248'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 35.71,
    'O''REILLY 1238 MATHIS TX XX1511 05/15'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0248'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 110.0,
    'SQ *FARMER TRAILER RENT RICHMOND TX 05/15'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0248'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 71.82,
    'H-E-B GAS #234 REFUGIO TX XX3085 05/15'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0248'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 65.2,
    'TEXAN # 8 VICTO VICTORIA TX 05/15'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0249', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-16',
    'Expense',
    '1140',
    'Chevron',
    'CHEVRON XXX8122 RICHMOND TX 05/16'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0249'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 83.42,
    'CHEVRON XXX8122 RICHMOND TX 05/16'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0249'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 83.74,
    'TST* SMOLIKS SMOKEHOUSE Mathis TX 05/15'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0249'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 1180.52,
    'AZTEC RENTAL CENTER NO2 HOUSTON TX 05/16'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0249'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 20.0,
    '9235 CLAY ROAD HOUSTON TX 05/16'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0250', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-17',
    'Expense',
    '1140',
    NULL,
    'REVEILLE BARBECUE CO PINEHURST TX 05/17'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0250'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 56.74,
    'REVEILLE BARBECUE CO PINEHURST TX 05/17'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0250'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 37.88,
    'MCCOYS #57 TOMBALL TX 05/17'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0250'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 34.46,
    'ORIG CO NAME:LYFT RIDE ORIG ID:XXXXXX2264 DESC DATE:240516 CO ENTRY DESCR:PAYMENTS SEC:WEB TRACE#:XXXXXXXX7772966 EED:240517 IND ID:XXXXXXXX2051676 IND NAME:INC 10NETZERO TELECHK XXX-XXX-9263 TRN: XXXXXX2966 TC'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0251', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-18',
    'Expense',
    '1140',
    'Express Transport',
    'HANDI STOP # 54 HOUSTON TX 05/18'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0251'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 10.0,
    'HANDI STOP # 54 HOUSTON TX 05/18'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0251'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 1683.0,
    'ORIG CO NAME:Express Transpor ORIG ID:204876018 DESC DATE:May 20 CO ENTRY DESCR:10 net zerSEC:CCD TRACE#:XXXXXXXX3742200 EED:240520 IND ID:5 -X8615 IND NAME:10 n et zero TRN: XXXXXX2200 TC'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0252', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-20',
    'Deposit',
    '1140',
    NULL,
    'Credit Return: Online Payment XXXXXXX1475 To Certified Production Services, LLC'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0252'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    5763.21, 0,
    'Credit Return: Online Payment XXXXXXX1475 To Certified Production Services, LLC'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0253', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-20',
    'Expense',
    '1140',
    NULL,
    'AZTEC RENTAL CENTER NO2 HOUSTON TX 05/20'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0253'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 620.33,
    'AZTEC RENTAL CENTER NO2 HOUSTON TX 05/20'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0254', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-21',
    'Expense',
    '1140',
    'Chevron',
    'CHEVRON XXX3521 TOMBALL TX 05/21'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0254'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 46.15,
    'CHEVRON XXX3521 TOMBALL TX 05/21'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0254'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 19.74,
    'CHEVRON XXX3521 TOMBALL TX 05/21'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0254'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 1047.28,
    'TOMBALL RENTAL CENTER TOMBALL TX 05/21'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0255', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-22',
    'Expense',
    '1140',
    'Sonic',
    'SONIC DRIVE IN #5047 TOMBALL TX 05/22'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0255'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 7.56,
    'SONIC DRIVE IN #5047 TOMBALL TX 05/22'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0255'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 96.85,
    'LOWE''S #1052 TOMBALL TX XX6519 05/22'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0255'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 20.0,
    '9235 CLAY ROAD HOUSTON TX 05/22'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0256', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-23',
    'Deposit',
    '1140',
    NULL,
    'TOMBALL RENTAL CENTER TOMBALL TX 05/23'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0256'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    500.0, 0,
    'TOMBALL RENTAL CENTER TOMBALL TX 05/23'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0257', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-23',
    'Expense',
    '1140',
    'Chevron',
    'CHEVRON XXX3521 TOMBALL TX 05/23'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0257'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 8.42,
    'CHEVRON XXX3521 TOMBALL TX 05/23'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0257'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 24.93,
    'WHATABURGER 134 Q26 HOUSTON TX 05/23'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0257'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 60.64,
    'ELLIOTT ELECTRIC XXXXXX7941 TX 05/23'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0257'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 24.79,
    'LOWE''S #1052 TOMBALL TX XX1633 05/23'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0258', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-24',
    'Expense',
    '1140',
    NULL,
    'RAISING CANES 0419 TOMBALL TX 05/24'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0258'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 29.71,
    'RAISING CANES 0419 TOMBALL TX 05/24'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0258'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 10.0,
    '9235 CLAY ROAD HOUSTON TX 05/24'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0259', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-05-25',
    'Expense',
    '1140',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX4588 05/25'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0259'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 14.98,
    'CIRCLE K #XXX1915 CYPRESS TX XX4588 05/25'
);

