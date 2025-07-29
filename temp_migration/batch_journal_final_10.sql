-- Journal Entries Final Batch 10

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0180', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-14',
    'Expense',
    '5062720',
    'Circle K',
    'CIRCLE K #XXX1540 ZAPATA TX XX9309 02/14'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0180'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 5.09,
    'CIRCLE K #XXX1540 ZAPATA TX XX9309 02/14'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0180'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 83.94,
    'SUNOCO XXXXXX1300 MATHIS TX 02/14'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0180'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 30.03,
    'CIRCLE K #XXX1540 ZAPATA TX XX8924 02/14'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0180'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 3.66,
    'NAPA MATHIS MATHIS TX 02/14'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0180'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 102.34,
    'NAPA MATHIS MATHIS TX 02/14'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0181', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-16',
    'Expense',
    '5062720',
    'GT Crane',
    'Online ACH Payment XXXXXXX6184 To GTCrane (_#####3597)'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0181'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 1200.0,
    'Online ACH Payment XXXXXXX6184 To GTCrane (_#####3597)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0182', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-19',
    'Expense',
    '5062720',
    'Circle K',
    'CIRCLE K # X6979 217 N REFUGIO TX 02/19'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0182'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 35.0,
    'CIRCLE K # X6979 217 N REFUGIO TX 02/19'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0182'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 40.0,
    'STAR STOP X0231 CLAY R HOUSTON TX 02/19'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0182'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 14.0,
    'LA RIBERA TAQUERIA & RE REFUGIO TX 02/19'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0183', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-20',
    'Expense',
    '5062720',
    'Shell',
    'SHELL SERVICE STATION EAST BERNARD TXXX2830 02/20'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0183'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 81.03,
    'SHELL SERVICE STATION EAST BERNARD TXXX2830 02/20'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0184', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-21',
    'Expense',
    '5062720',
    'Circle K',
    'BUC-EE''S #30 WHARTON TX XX7643 02/21'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0184'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 10.8,
    'BUC-EE''S #30 WHARTON TX XX7643 02/21'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0184'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 40.06,
    'CIRCLE K # X6979 217 N REFUGIO TX 02/21'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0184'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 9.0,
    'LA RIBERA TAQUERIA & RE REFUGIO TX 02/21'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0184'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 3290.0,
    'Online ACH Payment XXXXXXX0351 To MartinLegal (_#####2006)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0185', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-22',
    'Expense',
    '5062720',
    NULL,
    'NAPA MATHIS MATHIS TX 02/22'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0185'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 64.92,
    'NAPA MATHIS MATHIS TX 02/22'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0186', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-23',
    'Expense',
    '5062720',
    NULL,
    'FAST BREAK PETTUS TX XX2758 02/23'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0186'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 69.79,
    'FAST BREAK PETTUS TX XX2758 02/23'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0186'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 59.31,
    'PRASEK''S HILLJE SEALY TX 02/23'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0187', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-27',
    'Expense',
    '5062720',
    'Circle K',
    'BUC-EE''S #30 WHARTON TX 02/27'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0187'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 7.97,
    'BUC-EE''S #30 WHARTON TX 02/27'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0187'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 30.01,
    'BUC-EE''S #30 OUTSIDE WHARTON TX XX1466 02/27'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0187'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 40.9,
    'CIRCLE K #XXX1540 ZAPATA TX XX2691 02/27'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0187'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 64.36,
    'BUC-EE''S #30 OUTSIDE WHARTON TX XX2553 02/27'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0187'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 8.53,
    'MCDONALD''S FX8776 ZAPATA TX 02/27'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0187'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 13.21,
    'LA RIBERA TAQUERIA & RE REFUGIO TX 02/27'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0187'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    7,
    0, 1800.0,
    'ORIG CO NAME:Express Transpor ORIG ID:204876018 DESC DATE:Feb 27 CO ENTRY DESCR:10 net zerSEC:CCD TRACE#:XXXXXXXX7617945 EED:240227 IND ID:5 -X7295 IND NAME:10 n et zero TRN: XXXXXX7945 TC'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0187'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    8,
    0, 81.86,
    'H-E-B GAS #234 REFUGIO TX XX4753 02/27'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0187'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    9,
    0, 51.01,
    'VICTORIA TX XX2989 02/27'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0187'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    10,
    0, 4.97,
    'AMZN Mktp US*RZ8QA1U Amzn.com/bill WA 02/28'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0188', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-28',
    'Expense',
    '5062720',
    NULL,
    'GOODSON CAFE XXX-XXX5213 TX 02/28'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0188'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 74.47,
    'GOODSON CAFE XXX-XXX5213 TX 02/28'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0188'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 985.0,
    'Zelle payment to Alexis colon JPM99aa96d3w'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0189', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-02-29',
    'Expense',
    '5062720',
    'Home Depot',
    'THE HOME DEPOT #6525 HOUSTON TX XX4299 02/29'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0189'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 62.09,
    'THE HOME DEPOT #6525 HOUSTON TX XX4299 02/29'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0189'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 4165.0,
    'Online ACH Payment XXXXXXX2177 To 2WServices (_###4108)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0190', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-01',
    'Deposit',
    '5062720',
    'Alpha Centauri Contractors',
    'Credit Return: Online ACH Payment XXXXXXX1555 To AlphaCentauri (_#####4922)'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0190'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    11700.0, 0,
    'Credit Return: Online ACH Payment XXXXXXX1555 To AlphaCentauri (_#####4922)'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0190'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    1300.0, 0,
    'Credit Return: Online ACH Payment XXXXXXX1288 To JustinBallardLaw (_########9126)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0191', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-01',
    'Expense',
    '5062720',
    'Alpha Centauri Contractors',
    'Online ACH Payment XXXXXXX4869 To JustinBallardLaw (_########9126)'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0191'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 1300.0,
    'Online ACH Payment XXXXXXX4869 To JustinBallardLaw (_########9126)'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0191'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 11700.0,
    'Online ACH Payment XXXXXXX1555 To AlphaCentauri (_#####4922)'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0191'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 1556.25,
    'HWY 290 WRECKER HOCKLEY TX 02/29'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0191'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 242.91,
    'ATT*BILL PAYMENT XXX-XXX-2020 TX 02/29'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0192', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-04',
    'Expense',
    '5062720',
    'Circle K',
    'CIRCLE K # X6983 X0537 MATHIS TX 03/04'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0192'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 40.0,
    'CIRCLE K # X6983 X0537 MATHIS TX 03/04'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0192'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 35.0,
    'STAR STOP X0231 CLAY R HOUSTON TX 03/04'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0192'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 18.0,
    'TAQUERIA VALLARTA #2 MATHIS TX 03/04'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0192'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 4500.0,
    'WITHDRAWAL 03/04 - Trailers'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0192'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 17000.0,
    'WITHDRAWAL 03/04'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0193', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-05',
    'Expense',
    '5062720',
    NULL,
    'TIL*TP BLACKROCK BR083 HOUSTON TX 03/05'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0193'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 10.63,
    'TIL*TP BLACKROCK BR083 HOUSTON TX 03/05'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0193'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 99.58,
    'TST* MALA SICHUAN - CHI Houston TX 03/05'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0193'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 559.66,
    'ORIG CO NAME:IPFSXXX-XXX-2621 ORIG ID:0 ADXXX4370 DESC DATE: CO ENTRY DESCR:IPFSPMTTXPSEC:CCD TRACE#:XXXXXXXX4595203 EED:240305 IND ID:62397 IND NAME:10 NET ZERO INC. GDxLk2vV TRN: XXXXXX5203 TC'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0194', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-06',
    'Expense',
    '5062720',
    'Chevron',
    'CHEVRON XXX3521 TOMBALL TX 03/06'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0194'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 65.0,
    'CHEVRON XXX3521 TOMBALL TX 03/06'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0194'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 61.9,
    'GOODSON CAFE XXX-XXX5213 TX 03/06'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0194'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 29.01,
    'ASAP TRAILER SERVICE AN TOMBALL TX 03/06'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0194'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 132.96,
    'ASAP TRAILER SERVICE AN TOMBALL TX 03/06'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0194'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 570.0,
    'Zelle payment to Joey Headly XXXXXXX8602 - Trailer'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0194'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 1688.0,
    'ORIG CO NAME:RIGGING & WELDIN ORIG ID:XXXXXX6202 DESC DATE:240306 CO ENTRY DESCR:SALE SEC:CCD TRACE#:XXXXXXXX4074352 EED:240306 IND ID: IND NAME:10 NET ZERO TRN : XXXXXX4352TC'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0195', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-07',
    'Expense',
    '5062720',
    NULL,
    'CORPUS MM/GAS 0 CORPUS CHRIS TX 03/07'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0195'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 73.81,
    'CORPUS MM/GAS 0 CORPUS CHRIS TX 03/07'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0195'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 68.97,
    'TST* SMOLIKS SMOKEHOUSE Mathis TX 03/07'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0195'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 77.93,
    'Alamo Lumber Company M Mathis TX XX6384 03/07'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0196', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-08',
    'Deposit',
    '5062720',
    'Ballard Law',
    'Credit Return: Online ACH Payment XXXXXXX4869 To JustinBallardLaw (_########9126)'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0196'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    1300.0, 0,
    'Credit Return: Online ACH Payment XXXXXXX4869 To JustinBallardLaw (_########9126)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0197', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-08',
    'Expense',
    '5062720',
    'Kroger Fuel',
    'KROGER FUEL 7361 353 COLLEGE STATI TXXX3392 03/08'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0197'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 20.01,
    'KROGER FUEL 7361 353 COLLEGE STATI TXXX3392 03/08'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0197'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 35.0,
    'STAR STOP X0231 CLAY R HOUSTON TX 03/08'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0197'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 22.5,
    'BLUE BAKER 002 Q25 COLLEGE STATI TX 03/08'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0197'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 1300.0,
    'Online ACH Payment XXXXXXX4869 To JustinBallardLaw (_########9126)'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0197'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 11727.06,
    'Online ACH Payment XXXXXXX5384 To AlphaCentauri (_#####6780) - electrical work'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0198', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-10',
    'Expense',
    '5062720',
    'Walmart',
    'WAL-MART #4111 RICHMOND TX 03/10'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0198'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 80.02,
    'WAL-MART #4111 RICHMOND TX 03/10'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0198'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 27.04,
    'THE HOME DEPOT #6587 VICTORIA TX XX2402 03/10'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0199', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-03-11',
    'Expense',
    '5062720',
    'Circle K',
    'CIRCLE K # X6979 217 N REFUGIO TX 03/11'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0199'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 50.0,
    'CIRCLE K # X6979 217 N REFUGIO TX 03/11'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0199'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 11.07,
    'CIRCLE K # X6983 MATHIS TX 03/11'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0199'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 28.33,
    'TST* SMOLIKS SMOKEHOUSE Mathis TX 03/11'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0199'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 4500.0,
    'WITHDRAWAL 03/11'
);

