-- Journal Entries Final Batch 25

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0480', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-29',
    'Invoice',
    '1017',
    'Flober LLC',
    'Invoice - 2025-01-29'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0480'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    1,
    10990.99, 0,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0481', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-30',
    'Expense',
    '1017',
    'Gusto',
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250130 CO ENTRY DESCR:TAX XX1696SEC:CCD TRACE#:XXXXXXXX2645206 EED:250130 IND ID:6 semk3h0sr4 IND NAME:10NetZero, Inc. 6semjnbv8o0 TRN: XXXXXX5206 TC'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0481'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 8057.56,
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250130 CO ENTRY DESCR:TAX XX1696SEC:CCD TRACE#:XXXXXXXX2645206 EED:250130 IND ID:6 semk3h0sr4 IND NAME:10NetZero, Inc. 6semjnbv8o0 TRN: XXXXXX5206 TC'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0481'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 13904.94,
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250130 CO ENTRY DESCR:NET XX1698SEC:CCD TRACE#:XXXXXXXX2647273 EED:250130 IND ID:6 semk3h0sr3 IND NAME:10NetZero, Inc. 6semjnbv8o2 TRN: XXXXXX7273 TC'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0481'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 242.91,
    'ATT*BILL PAYMENT XXX-XXX-2020 TX 01/30'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0481'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 3280.65,
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250130 CO ENTRY DESCR:NET XX1704SEC:CCD TRACE#:XXXXXXXX2645817 EED:250130 IND ID:6 semk3h0roo IND NAME:10NetZero, Inc. 6semjnbv8o8 TRN: XXXXXX5817 TC'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0481'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 1342.27,
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250130 CO ENTRY DESCR:TAX XX1522SEC:CCD TRACE#:XXXXXXXX2644554 EED:250130 IND ID:6 semk3h0rop IND NAME:10NetZero, Inc. 6semjnbv8ii TRN: XXXXXX4554 TC'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0481'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 52.0,
    'CPA TEXAS TAX WWW.TEXAS.GOV TX 01/30'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0481'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    7,
    0, 51.0,
    'CPA TEXAS TAX WWW.TEXAS.GOV TX 01/30'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0481'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    8,
    0, 52.0,
    'CPA TEXAS TAX WWW.TEXAS.GOV TX 01/30'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0481'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    9,
    0, 52.0,
    'CPA TEXAS TAX WWW.TEXAS.GOV TX 01/30'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0481'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    10,
    0, 52.0,
    'CPA TEXAS TAX WWW.TEXAS.GOV TX 01/30'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0481'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    11,
    0, 52.0,
    'CPA TEXAS TAX WWW.TEXAS.GOV TX 01/30'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0481'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    12,
    0, 52.0,
    'CPA TEXAS TAX WWW.TEXAS.GOV TX 01/30'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0481'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    13,
    0, 52.0,
    'CPA TEXAS TAX WWW.TEXAS.GOV TX 01/30'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0481'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    14,
    0, 52.0,
    'CPA TEXAS TAX WWW.TEXAS.GOV TX 01/30'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0482', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-31',
    'Expense',
    '1017',
    'Exxon',
    'H-E-B GAS/CARWASH #109 HOUSTON TX XX4753 01/31'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0482'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 42.12,
    'H-E-B GAS/CARWASH #109 HOUSTON TX XX4753 01/31'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0482'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 192.38,
    'PERRYS STEAK HOUSE & G HOUSTON TX 01/31'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0482'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 28.99,
    'EXXON FULSHEAR RE LLC FULSHEAR TX 01/31'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0482'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 48.25,
    'APPLE LUMBER BRANCH 40 EAGLE LAKE TX XX7221 01/31'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0483', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-01',
    'Expense',
    '1017',
    'Kroger Fuel',
    'RAISING CANES 0162 CONROE TX 02/01'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0483'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 17.31,
    'RAISING CANES 0162 CONROE TX 02/01'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0483'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 68.03,
    'KROGER FUEL CTR X0355 CYPRESS TX XX3532 02/01'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0484', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-02',
    'Expense',
    '1017',
    'Unchained Capital',
    'UNCHAINED CAPITAL WWW.UNCHAINED TX 02/02'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0484'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 500.0,
    'UNCHAINED CAPITAL WWW.UNCHAINED TX 02/02'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0485', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-03',
    'Expense',
    '1017',
    'Circle K',
    'CIRCLE K # X6979 REFUGIO TX XX1175 02/03'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0485'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 4.69,
    'CIRCLE K # X6979 REFUGIO TX XX1175 02/03'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0485'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 205.63,
    'O''REILLY 1652 REFUGIO TX XX3513 02/03'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0485'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 43.49,
    'CIRCLE K # X6983 MATHIS TX XX6971 02/03'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0485'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 7.28,
    'LA RIBERA TAQUERIA & RE REFUGIO TX 02/03'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0485'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 36.63,
    'NAPA MATHIS MATHIS TX 02/03'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0485'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 10.82,
    'MCDONALD''S FX0850 MATHIS TX 02/03'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0485'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    7,
    0, 37.75,
    'TST*SMOLIKS SMOKEHOUSE Mathis TX 02/03'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0485'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    8,
    0, 25.01,
    'SHELL OIL XXXXXXX2008 EL CAMPO TX 02/03'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0485'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    9,
    0, 50.28,
    'NAPA MATHIS MATHIS TX 02/03'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0485'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    10,
    0, 2.89,
    'EXXON SPEEDY EXPRESS # MATHIS TX 02/03'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0485'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    11,
    0, 76.06,
    'Valero VICTORIA TX XX5329 02/03'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0485'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    12,
    0, 38.4,
    'ALAMO LUMBER COMPANY M MATHIS TX XX8596 02/03'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0486', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-03',
    'Payment',
    '1017',
    'Flober LLC',
    'Payment - 2025-02-03'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0486'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    10990.99, 0,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0487', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-04',
    'Expense',
    '1017',
    'Circle K',
    'MCDONALD''S FX0850 MATHIS TX 02/04'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0487'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 8.87,
    'MCDONALD''S FX0850 MATHIS TX 02/04'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0487'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 5.4,
    'CIRCLE K # X6983 MATHIS TX XX4220 02/04'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0487'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 53.0,
    'CIRCLE K # X6983 MATHIS TX XX2885 02/04'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0487'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 41.28,
    'CIRCLE K #XXX2369 HOUSTON TX XX4893 02/04'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0487'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 132.0,
    'FOREMAN.MN FOREMAN.MN MD 02/05'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0488', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-05',
    'Expense',
    '1017',
    'Love''s Country Stores',
    'SERVICE CHARGES FOR THE MONTH OF JANUARY'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0488'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 12.5,
    'SERVICE CHARGES FOR THE MONTH OF JANUARY'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0488'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 65.51,
    'LOVE''S #0617 OUTSIDE HUNGERFORD TX XX7664 02/05'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0488'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 16.39,
    'WHATABURGER 428 Q26 EDNA TX 02/05'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0488'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 9.83,
    'LA RIBERA TAQUERIA & RE REFUGIO TX 02/05'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0488'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 95.94,
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4007 DESC DATE:250205 CO ENTRY DESCR:FEE XX5253SEC:CCD TRACE#:XXXXXXXX2468539 EED:250205 IND ID:6 semk3jcn9p IND NAME:10NetZero, Inc. 6semjnc7tl5 TRN: XXXXXX8539 TC'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0489', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-06',
    'Expense',
    '1017',
    'Exxon',
    'O''REILLY 6123 EAGLE LAKE TX XX5049 02/06'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0489'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 9.19,
    'O''REILLY 6123 EAGLE LAKE TX XX5049 02/06'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0489'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 10.0,
    'DEL FRISCOS HOUSTON HOUSTON TX 02/07'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0489'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 76.28,
    'EXXON FULSHEAR RE LLC FULSHEAR TX 02/06'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0489'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 14.5,
    'VINCEKS SMOKEHOUSE IN EAST BERNARD TX 02/06'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0490', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-07',
    'Expense',
    '1017',
    'Circle K',
    'CORPUS MM/GAS XX0273 CORPUS CHRIS TX XX4618 02/07'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0490'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 61.73,
    'CORPUS MM/GAS XX0273 CORPUS CHRIS TX XX4618 02/07'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0490'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 33.38,
    'CIRCLE K #XXX0565 HOUSTON TX XX5077 02/07'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0490'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 25000.0,
    'ONLINE DOMESTIC WIRE TRANSFER VIA: PROSPERITY BK ELCA/XXXXX2655 A/C: CHIRON FINANCIAL LLC HOUSTON TX X7010 US REF: ATTENTION TODD A. HASS - INVOICE XXXX25-01/TI ME/17:07 IMAD: 0207MMQFMP2LXX4630 TRN: XXXXXX5038 ES 02/07'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0490'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 10.65,
    'ARLO TECHNOLOGIES INC XXX-XXX-3750 CA 02/09'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0490'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 38.81,
    'LYFT *1 RIDE 02-05 HELP.LYFT.COM CA 02/07'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0491', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-08',
    'Expense',
    '1017',
    NULL,
    'LYFT *1 RIDE 02-06 HELP.LYFT.COM CA 02/08'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0491'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 25.36,
    'LYFT *1 RIDE 02-06 HELP.LYFT.COM CA 02/08'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0492', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-09',
    'Expense',
    '1017',
    NULL,
    'Valero VICTORIA TX XX3296 02/09'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0492'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 67.52,
    'Valero VICTORIA TX XX3296 02/09'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0492'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 40.5,
    'NETLIFY NETLIFY.COM CA 02/09'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0493', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-10',
    'Expense',
    '1018',
    'Circle K',
    'CIRCLE K #XXX2369 HOUSTON TX XX6235 02/10'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0493'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 41.1,
    'CIRCLE K #XXX2369 HOUSTON TX XX6235 02/10'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0493'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 13.53,
    'PANDA EXPRESS # 3059 WILLIS TX 02/10'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0493'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 21.64,
    'ADOBE *XXX-XXX-6687 ADOBE.LY/ENUS CA 02/11'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0493'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 1050.0,
    'DARK HORSE CPAS WWW.DARKHORSE CA 02/10'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0493'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 350.0,
    'LEGALZOOM* TRADEMARK XXX-XXX0151 CA 02/10'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0493'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 135.0,
    'CORPORATE FILINGS LLC XXX-XXX8466 WY 02/10'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0493'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    7,
    0, 12966.38,
    'Online ACH Payment XXXXXXX2049 To 2WServices (_###4108)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0494', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-10',
    'Invoice',
    '1018',
    'WasteWatt Ventures LLC',
    'Invoice - 2025-02-10'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0494'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    1,
    27835.88, 0,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0495', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-10',
    'Payment',
    '1018',
    'HeatCore Inc',
    'Payment - 2025-02-10'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0495'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    20218.0, 0,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0496', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-11',
    'Expense',
    '1018',
    'Circle K',
    'CIRCLE K #XXX2369 HOUSTON TX XX2986 02/11'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0496'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 20.0,
    'CIRCLE K #XXX2369 HOUSTON TX XX2986 02/11'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0496'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 53.57,
    'CORPUS MM/GAS XX0273 CORPUS CHRIS TX XX0421 02/11'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0496'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 5250.0,
    'DARK HORSE CPAS WWW.DARKHORSE CA 02/11'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0497', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-12',
    'Expense',
    '1018',
    'Sunoco',
    'BUC-EE''S #30 WHARTON TX 02/12'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0497'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 30.0,
    'BUC-EE''S #30 WHARTON TX 02/12'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0497'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 4.5,
    'SUNOCO XXXXXX1300 MATHIS TX XX4856 02/12'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0497'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 19.99,
    'CIRCLE K # X6979 REFUGIO TX XX7712 02/12'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0497'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 42.07,
    'CIRCLE K # X6979 REFUGIO TX XX1347 02/12'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0497'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 6.81,
    'SPEEDY EXPRESS #38 MATHIS TX XX3818 02/12'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0497'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 63.44,
    'TEXAN # 8 VICTORIA VICTORIA TX XX7250 02/12'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0498', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-12',
    'Payment',
    '1018',
    'WasteWatt Ventures LLC',
    'Payment - 2025-02-12'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0498'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    27835.88, 0,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0499', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-13',
    'Expense',
    '1018',
    'Circle K',
    'O''REILLY 1652 REFUGIO TX XX6433 02/13'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0499'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 154.75,
    'O''REILLY 1652 REFUGIO TX XX6433 02/13'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0499'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 50.14,
    'CIRCLE K # X6979 REFUGIO TX XX6135 02/13'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0499'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 69.29,
    'INTUIT *QBooks Onlin CL.INTUIT.COM CA 11/13'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0499'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 43.28,
    'NAPA MATHIS MATHIS TX 02/13'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0499'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 30.0,
    'BUC-EE''S #30 WHARTON TX 02/13'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0499'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 5.41,
    'MCDONALD''S FX2899 REFUGIO TX 02/13'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0499'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    7,
    0, 2.98,
    'BUC-EE''S #30 WHARTON TX 02/13'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0499'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    8,
    0, 1611.0,
    'Online Payment XXXXXXX9718 To Easley''s Crane Service 02/13'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0499'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    9,
    0, 2500.0,
    'Online Payment XXXXXXX9887 To 6J Farm & Ranch Construction , LLC 02/13'
);

