-- Journal Entries Final Batch 22

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0420', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-11',
    'Expense',
    '1006',
    NULL,
    'TST*COLLINAS ITALIAN CA Houston TX 12/11'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0420'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 78.96,
    'TST*COLLINAS ITALIAN CA Houston TX 12/11'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0421', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-13',
    'Expense',
    '1006',
    'QuickBooks Payments',
    'INTUIT *QBooks Onlin CL.INTUIT.COM CA 11/13'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0421'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 69.29,
    'INTUIT *QBooks Onlin CL.INTUIT.COM CA 11/13'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0421'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 44.0,
    'CIRCLE K # X6979 REFUGIO TX XX0711 12/13'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0421'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 93.29,
    'O''REILLY 1652 REFUGIO TX XX9702 12/13'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0421'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 50.39,
    'SUNOCO XXXXXX2300 REFUGIO TX XX8000 12/13'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0421'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 378.73,
    'O''REILLY 1652 REFUGIO TX XX0308 12/13'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0421'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 2.52,
    'H-E-B #234 REFUGIO TX XX9523 12/13'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0421'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    7,
    0, 100.65,
    'NAPA MATHIS MATHIS TX 12/13'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0421'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    8,
    0, 26.51,
    'TST*SMOLIKS SMOKEHOUSE Mathis TX 12/13'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0421'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    9,
    0, 37.09,
    'STAR STOP 127 HOUSTON TX 12/13'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0421'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    10,
    0, 10.0,
    'LA RIBERA TAQUERIA & RE REFUGIO TX 12/13'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0422', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-15',
    'Expense',
    '1006',
    NULL,
    'TACTACAM WWW.REVEALCEL MN 12/15'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0422'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 9.0,
    'TACTACAM WWW.REVEALCEL MN 12/15'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0422'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 9.0,
    'TACTACAM WWW.REVEALCEL MN 12/15'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0423', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-16',
    'Invoice',
    '1007',
    'WasteWatt Ventures LLC',
    'Invoice - 2024-12-16'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0423'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    1,
    3682.23, 0,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0424', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-16',
    'Expense',
    '1008',
    NULL,
    'Online Payment XXXXXXX5500 To Kebo Oil and Gas, INC 12/16'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0424'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 1923.0,
    'Online Payment XXXXXXX5500 To Kebo Oil and Gas, INC 12/16'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0425', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-16',
    'Invoice',
    '1008',
    'WasteWatt Ventures LLC',
    'Invoice - 2024-12-16'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0425'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    1,
    27602.0, 0,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0426', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-17',
    'Expense',
    '1008',
    NULL,
    'FSP*TEXAS GRIME DUMPS XXX-XXX-2979 TX 12/17'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0426'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 412.97,
    'FSP*TEXAS GRIME DUMPS XXX-XXX-2979 TX 12/17'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0427', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-17',
    'Journal Entry',
    'DH39',
    NULL,
    '2month - RSU vested'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0427'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-3160'),
    1,
    0, 0.29,
    '2month - RSU vested'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0428', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-18',
    'Expense',
    'DH39',
    'Circle K',
    'CIRCLE K # X6983 MATHIS TX XX7145 12/18'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0428'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 2.47,
    'CIRCLE K # X6983 MATHIS TX XX7145 12/18'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0428'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 74.01,
    'EXXON 7-ELEVEN X6525 VICTORIA TX 12/18'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0428'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 70.27,
    'TST*SMOLIKS SMOKEHOUSE Mathis TX 12/18'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0428'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 32066.79,
    'Online ACH Payment XXXXXXX4752 To JohnSchillereff (_#####5067)'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0428'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 12.81,
    'H-E-B #234 REFUGIO TX XX5278 12/18'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0429', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-19',
    'Expense',
    'DH39',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX3913 12/19'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0429'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 30.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX3913 12/19'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0429'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 8.43,
    'JACK IN THE BOX 3980 TOMBALL TX 12/19'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0429'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 20.0,
    'INTIME CLAY HOUSTON TX XX1353 12/19'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0429'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 59.94,
    'WM SUPERCENTER #4512 KATY TX XX7603 12/19'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0429'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 5033.04,
    'Basic Online Payroll Payment XXXXXXX6485 to #########4504'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0429'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 4574.09,
    'Basic Online Payroll Payment XXXXXXX6484 to ######3267'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0430', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-20',
    'Expense',
    'DH39',
    NULL,
    'MIDWEST HOSE - HOUSTO XXX-XXX-9092 TX 12/20'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0430'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 188.42,
    'MIDWEST HOSE - HOUSTO XXX-XXX-9092 TX 12/20'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0430'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 5.41,
    'MIDWEST HOSE - HOUSTO XXX-XXX-9092 TX 12/20'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0431', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-23',
    'Expense',
    '1009',
    NULL,
    'EASY MART 2 CYPRESS TX 12/23'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0431'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 66.68,
    'EASY MART 2 CYPRESS TX 12/23'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0432', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-23',
    'Invoice',
    '1009',
    'WasteWatt Ventures LLC',
    'Invoice - 2024-12-23'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0432'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    1,
    25000.0, 0,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0433', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-23',
    'Payment',
    '1009',
    'WasteWatt Ventures LLC',
    'Payment - 2024-12-23'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0433'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    3682.23, 0,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0434', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-24',
    'Expense',
    '1009',
    NULL,
    'FSP*TEXAS GRIME DUMPS XXX-XXX-2979 TX 12/24'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0434'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 56.3,
    'FSP*TEXAS GRIME DUMPS XXX-XXX-2979 TX 12/24'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0435', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-24',
    'Payment',
    '1009',
    'WasteWatt Ventures LLC',
    'Payment - 2024-12-24'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0435'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    27602.0, 0,
    ''
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0435'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    25000.0, 0,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0436', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-27',
    'Expense',
    '1009',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX3674 12/26'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0436'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 20.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX3674 12/26'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0436'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 11.34,
    'CIRCLE K #XXX1915 CYPRESS TX XX1040 12/27'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0437', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-30',
    'Expense',
    '1009',
    'Harbor Freight Tools',
    'HARBOR FREIGHT TOOLS 5 HOUSTON TX XX1243 12/30'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0437'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 197.18,
    'HARBOR FREIGHT TOOLS 5 HOUSTON TX XX1243 12/30'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0437'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 25.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX6144 12/30'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0437'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 173.19,
    'AUTOZONE 1477 X8764 T TOMBALL TX XX4270 12/30'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0437'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 242.91,
    'ATT*BILL PAYMENT XXX-XXX-2020 TX 12/30'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0437'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 24.99,
    'POPEYES X3790 CYPRESS TX 12/30'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0437'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 9.73,
    'AUTOZONE 1477 X8764 T TOMBALL TX XX8502 12/30'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0438', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-31',
    'Expense',
    '1009',
    'Circle K',
    'CIRCLE K #XXX2255 HOUSTON TX XX5867 12/31'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0438'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 30.0,
    'CIRCLE K #XXX2255 HOUSTON TX XX5867 12/31'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0439', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-31',
    'Journal Entry',
    'DH3',
    NULL,
    'Journal Entry - 2024-12-31'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0439'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-8000'),
    1,
    59008.0, 0,
    ''
);

