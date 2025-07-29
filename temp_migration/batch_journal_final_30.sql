-- Journal Entries Final Batch 30

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0580', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-17',
    'Invoice',
    '1048',
    'Flober LLC',
    'Invoice - 2025-04-17'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0580'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    1,
    4675.0, 0,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0581', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-18',
    'Expense',
    '1048',
    'Zoro Tools',
    'BUC-EE''S 24 XXX-XXX-6390 TX 04/18'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0581'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 4.52,
    'BUC-EE''S 24 XXX-XXX-6390 TX 04/18'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0581'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 30.0,
    'BUC-EE''S 24 XXX-XXX-6390 TX 04/18'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0581'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 53.82,
    'ZORO TOOLS INC XXX-XXX9676 IL 04/18'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0582', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-19',
    'Payment',
    '1048',
    'WasteWatt Ventures LLC',
    'Payment - 2025-04-19'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0582'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    4000.0, 0,
    ''
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0582'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    315.36, 0,
    ''
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0582'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    4000.0, 0,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0583', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-21',
    'Expense',
    'PB-26',
    'Sam''s Club',
    'WAL SAMSCLUB #4712 000 HOUSTON TX XX4521 04/21'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0583'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 129.73,
    'WAL SAMSCLUB #4712 000 HOUSTON TX XX4521 04/21'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0583'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 64.83,
    'ZORO TOOLS INC XXX-XXX9676 IL 04/21'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0584', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-21',
    'Invoice',
    'PB-26',
    'Operation Orange LLC',
    'Invoice - 2025-04-21'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0584'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    1,
    2435.63, 0,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0585', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-22',
    'Expense',
    'PB-26',
    'Sunoco',
    'HONEY FARMS #845 HOUSTON TX XX9000 04/22'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0585'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 20.15,
    'HONEY FARMS #845 HOUSTON TX XX9000 04/22'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0585'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 30.0,
    'SUNOCO XXXXXX2300 REFUGIO TX XX4600 04/22'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0585'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 40.0,
    'CIRCLE K #XXX2369 HOUSTON TX XX4980 04/22'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0585'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 9.56,
    'LA RIBERA TAQUERIA & RE REFUGIO TX 04/22'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0585'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 25.58,
    'AIRTABLE.COM/BILL AIRTABLE.COM CA 04/22'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0585'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 70.03,
    'LOVE''S #0617 OUTSIDE HUNGERFORD TX XX3480 04/22'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0585'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    7,
    0, 206.49,
    'NAVY EXCHANGE XX0060 CORPUS CHRIST TXXX9787 04/22'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0585'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    8,
    0, 299.0,
    'TYPINGMIND.COM WWW.TYPINGMIN WY 04/22'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0585'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    9,
    0, 20.0,
    'CURSOR, AI POWERED IDE CURSOR.COM NY 04/22'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0585'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    10,
    0, 19.0,
    'UIZARD COPENHAGEN 04/22'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0585'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    11,
    0, 20.0,
    'TST*SMOLIKS SMOKEHOUSE Mathis TX 04/22'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0586', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-23',
    'Expense',
    'PB-26',
    NULL,
    'TST* ROAMING RONIN CORPUS CHRIST TX 04/23'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0586'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 115.96,
    'TST* ROAMING RONIN CORPUS CHRIST TX 04/23'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0586'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 69.01,
    'MIDWEST HOSE - HOUSTO XXX-XXX-9092 TX 04/23'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0586'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 14.06,
    'TST*TX BURGER - CROCKET Crockett TX 04/23'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0586'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 40.0,
    'BIG''S 3830 CROCKETT TX XX0214 04/23'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0587', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-25',
    'Expense',
    'PB-26',
    'Circle K',
    'O''REILLY 1238 MATHIS TX XX3749 04/25'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0587'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 29.41,
    'O''REILLY 1238 MATHIS TX XX3749 04/25'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0587'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 1.07,
    'CIRCLE K # X6983 MATHIS TX XX1086 04/25'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0587'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 79.48,
    'CIRCLE K # X6983 MATHIS TX XX0082 04/25'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0588', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-28',
    'Payment',
    'PB-26',
    'Flober LLC',
    'Payment - 2025-04-28'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0588'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    10799.73, 0,
    ''
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0588'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    2665.85, 0,
    ''
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0588'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    5487.91, 0,
    ''
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0588'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    6252.37, 0,
    ''
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0588'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    20448.9, 0,
    ''
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0588'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    7910.83, 0,
    ''
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0588'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    7,
    4675.0, 0,
    ''
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0588'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    8,
    30284.1, 0,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0589', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-29',
    'Expense',
    'PB-26',
    'Tractor Supply',
    'TRACTOR SUPPLY C 2340 SEALY TX XX1195 04/29'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0589'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 31.36,
    'TRACTOR SUPPLY C 2340 SEALY TX XX1195 04/29'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0589'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 7.89,
    '7-ELEVEN HOUSTON TX XX6292 04/29'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0589'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 68.32,
    'BUC-EE''S #18 WALLER TX 04/29'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0589'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 40.0,
    'BUC-EE''S 24 XXX-XXX-6390 TX 04/29'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0589'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 13.16,
    'BUC-EE''S 24 XXX-XXX-6390 TX 04/29'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0590', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-04-30',
    'Expense',
    'PB-26',
    'Sunoco',
    'SUNOCO XXXXXX2300 REFUGIO TX XX9300 04/30'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0590'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 40.0,
    'SUNOCO XXXXXX2300 REFUGIO TX XX9300 04/30'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0590'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 20.07,
    'SUNOCO XXXXXX1300 MATHIS TX XX1573 04/30'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0590'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 15.0,
    'LA RIBERA TAQUERIA & RE REFUGIO TX 04/30'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0590'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 13.77,
    'LA RIBERA TAQUERIA & RE REFUGIO TX 04/30'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0590'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 20.0,
    'CIRCLE K # X6979 REFUGIO TX XX5818 04/30'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0590'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 10.66,
    'NAME-CHEAP.COM* JAZS WWW.NAMECHEAP AZ 05/01'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0591', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-01',
    'Expense',
    'PB-26',
    'Sunoco',
    'SUNOCO XXXXXX1300 MATHIS TX XX8146 05/01'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0591'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 14.86,
    'SUNOCO XXXXXX1300 MATHIS TX XX8146 05/01'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0591'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 40.0,
    'REPLIT, INC. REPLIT.COM CA 05/01'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0591'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 497.92,
    'BEST BUY #235 CORPUS CHRIST TX XX0005 05/01'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0591'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 34.06,
    'STRIPES XXXXXX2700 CORPUS CHRIST TX XX2400 05/01'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0591'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 22.97,
    'STRIPES XXXXXX2700 CORPUS CHRIST TX XX5286 05/01'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0592', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-02',
    'Expense',
    'PB-26',
    'Amazon',
    '7-ELEVEN HOUSTON TX XX1471 05/02'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0592'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 30.0,
    '7-ELEVEN HOUSTON TX XX1471 05/02'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0592'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 11.0,
    'GLAMA.AI GLAMA.AI WY 05/02'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0592'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 122.57,
    'Amazon web services aws.amazon.co WA 05/03'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0592'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 10.66,
    'ZAPIER.COM/CHARGE ZAPIER.COM CA 05/02'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0592'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 21.0,
    'TAQUERIA AZTECA D.F EAGLE LAKE TX 05/02'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0592'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 3.82,
    'RENDER.COM RENDER.COM CA 05/02'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0592'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    7,
    0, 36.78,
    'APPLE LUMBER BRANCH 40 EAGLE LAKE TX XX3468 05/02'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0593', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-03',
    'Expense',
    'PB-26',
    'Gusto',
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4007 DESC DATE:250505 CO ENTRY DESCR:FEE XX2756SEC:CCD TRACE#:XXXXXXXX9784427 EED:250505 IND ID:6 semk4fu58d IND NAME:10NetZero, Inc. 6semjnfchs4 TRN: XXXXXX4427 TC'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0593'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 127.92,
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4007 DESC DATE:250505 CO ENTRY DESCR:FEE XX2756SEC:CCD TRACE#:XXXXXXXX9784427 EED:250505 IND ID:6 semk4fu58d IND NAME:10NetZero, Inc. 6semjnfchs4 TRN: XXXXXX4427 TC'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0594', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-04',
    'Expense',
    'PB-26',
    NULL,
    'FOREMAN.MN FOREMAN.MN MD 05/05'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0594'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 132.0,
    'FOREMAN.MN FOREMAN.MN MD 05/05'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0595', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-05',
    'Expense',
    'PB-26',
    NULL,
    '7-ELEVEN HOUSTON TX XX8049 05/05'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0595'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 40.0,
    '7-ELEVEN HOUSTON TX XX8049 05/05'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0595'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 52.5,
    'SERVICE CHARGES FOR THE MONTH OF APRIL'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0595'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 62.62,
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/05'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0595'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 11.25,
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/05'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0596', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-06',
    'Expense',
    'PB-26',
    'Circle K',
    'BUC-EE''S #30 WHARTON TX 05/06'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0596'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 40.0,
    'BUC-EE''S #30 WHARTON TX 05/06'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0596'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 40.0,
    'CIRCLE K # X6983 MATHIS TX XX6936 05/06'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0596'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 19.43,
    'TAQUERIA AZTECA D.F EAGLE LAKE TX 05/06'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0596'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 17.31,
    'APPLE LUMBER BRANCH 40 EAGLE LAKE TX XX4308 05/06'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0597', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-07',
    'Expense',
    'PB-26',
    NULL,
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/07'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0597'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 40.0,
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/07'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0597'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 25.0,
    '7-ELEVEN HOUSTON TX XX5097 05/07'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0597'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 10.65,
    'ARLO TECHNOLOGIES INC XXX-XXX-3750 CA 05/09'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0598', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-08',
    'Expense',
    'PB-26',
    NULL,
    'TEXAN # 8 VICTORIA VICTORIA TX XX0900 05/08'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0598'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 45.09,
    'TEXAN # 8 VICTORIA VICTORIA TX XX0900 05/08'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0598'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 86.99,
    'CONNER''S CORNER STORE EDNA TX XX7000 05/08'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0598'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 15.0,
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/08'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0598'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 2.5,
    'CTLP*Glitz Air RICHMOND TX 05/08'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0599', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-09',
    'Expense',
    'PB-27',
    'Tractor Supply',
    '7-ELEVEN HOUSTON TX XX9875 05/09'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0599'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 20.0,
    '7-ELEVEN HOUSTON TX XX9875 05/09'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0599'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 793.35,
    'TRACTOR SUPPLY C 2340 SEALY TX XX8766 05/09'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0599'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 2.0,
    'TX.GOV*SERVICEFEE-DI WWW.TEXAS.GOV TX 05/09'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0599'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 2.0,
    'TX.GOV*SERVICEFEE-DI WWW.TEXAS.GOV TX 05/09'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0599'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 2.0,
    'TX.GOV*SERVICEFEE-DI WWW.TEXAS.GOV TX 05/09'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0599'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 12.3,
    'J & K KORNER STORE EAGLE LAKE TX 05/09'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0599'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    7,
    0, 225.75,
    'FORT BEND VEHREG WWW.TEXAS.GOV TX 05/09'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0599'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    8,
    0, 20.25,
    'NETLIFY NETLIFY.COM CA 05/09'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0599'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    9,
    0, 225.75,
    'FORT BEND VEHREG WWW.TEXAS.GOV TX 05/09'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0599'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    10,
    0, 225.75,
    'FORT BEND VEHREG WWW.TEXAS.GOV TX 05/09'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0599'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    11,
    0, 187.25,
    'APPLE LUMBER BRANCH 40 EAGLE LAKE TX XX2823 05/09'
);

