-- Journal Entries Batch 10

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0451', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-11',
    'Expense',
    'Online Payment XXXXXXX8994 To Kebo Oil and Gas, INC 01/13',
    0.0, 1752.65, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000945', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0451'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX8994 To Kebo Oil and Gas, INC 01/13',
    1717.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000946', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0451'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WM SUPERCENTER #4111 RICHMOND TX XX8833 01/10',
    35.65, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0452', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-12',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX7799 01/12',
    0.0, 10.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000947', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0452'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX7799 01/12',
    10.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0453', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-13',
    'Expense',
    'O''REILLY 6123 EAGLE LAKE TX XX7200 01/13',
    0.0, 11161.47, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000948', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0453'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'O''REILLY 6123 EAGLE LAKE TX XX7200 01/13',
    321.36, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000949', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0453'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'INTUIT *QBooks Onlin CL.INTUIT.COM CA 11/13',
    69.29, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000950', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0453'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX2310 To 2WServices (_###4108)',
    9607.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000951', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0453'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX3231 To 2WServices (_###4108)',
    1062.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000952', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0453'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TAQUERIA AZTECA D.F EAGLE LAKE TX 01/13',
    80.82, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000953', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0453'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'J & K KORNER STORE EAGLE LAKE TX 01/13',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0454', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-13',
    'Payment',
    'Payment - 2025-01-13',
    11389.62, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000954', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0454'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    11389.62, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0455', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-14',
    'Expense',
    'LA RIBERA TAQUERIA & RE REFUGIO TX 01/14',
    0.0, 1475.1900000000003, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000955', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0455'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LA RIBERA TAQUERIA & RE REFUGIO TX 01/14',
    9.73, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000956', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0455'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NAPA MATHIS MATHIS TX 01/14',
    240.19, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000957', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0455'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'O''REILLY 1238 MATHIS TX XX8207 01/14',
    238.11, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000958', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0455'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NAPA MATHIS MATHIS TX 01/14',
    251.14, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000959', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0455'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'O''REILLY 1652 REFUGIO TX XX4205 01/14',
    384.24, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000960', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0455'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NAPA MATHIS MATHIS TX 01/14',
    76.32, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000961', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0455'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCDONALD''S FX9431 CYPRESS TX 01/14',
    3.31, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000962', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0455'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TST*SMOLIKS SMOKEHOUSE Mathis TX 01/14',
    64.36, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000963', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0455'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX6599 01/14',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000964', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0455'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'RAISING CANES 0603 HOUSTON TX 01/14',
    11.9, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000965', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0455'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MURPHY USA 7826 ALICE TX XX3175 01/14',
    78.49, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000966', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0455'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'KLATT HARDWARE ORANGE GROVE TX 01/14',
    8.7, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000967', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0455'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'EXXON SPEEDY EXPRESS # MATHIS TX 01/14',
    78.7, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0456', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-15',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX1774 01/15',
    0.0, 28.1, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000968', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0456'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX1774 01/15',
    10.1, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000969', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0456'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TACTACAM WWW.REVEALCEL MN 01/15',
    9.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000970', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0456'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TACTACAM WWW.REVEALCEL MN 01/15',
    9.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0457', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-16',
    'Expense',
    'LOVE''S #0617 OUTSIDE HUNGERFORD TX XX4383 01/16',
    0.0, 338.91, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000971', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0457'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LOVE''S #0617 OUTSIDE HUNGERFORD TX XX4383 01/16',
    39.74, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000972', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0457'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NAPA MATHIS MATHIS TX 01/16',
    100.12, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000973', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0457'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TST*SMOLIKS SMOKEHOUSE Mathis TX 01/16',
    37.87, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000974', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0457'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'FESCO LTD XXXXXX7000X15 TX 01/16',
    67.6, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000975', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0457'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Valero VICTORIA TX XX2106 01/16',
    64.35, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000976', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0457'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ALAMO LUMBER COMPANY M MATHIS TX XX3568 01/16',
    29.23, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0458', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-17',
    'Invoice',
    'Invoice - 2025-01-17',
    4871.69, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000977', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0458'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    4871.69, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0459', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-17',
    'Invoice',
    'Invoice - 2025-01-17',
    6505.6, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000978', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0459'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    6505.6, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0460', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-17',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX7658 01/17',
    0.0, 1874.9099999999999, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000979', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0460'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX7658 01/17',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000980', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0460'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCDONALD''S FX9431 CYPRESS TX 01/17',
    5.41, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000981', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0460'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX8599 To LYNN PINKER HURST & SCHWEGMANN, L.L.P 01/17',
    706.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000982', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0460'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Basic Online Payroll Payment XXXXXXX4634 to #########4504',
    1143.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0461', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-17',
    'Invoice',
    'Invoice - 2025-01-17',
    5838.4, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000983', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0461'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    5838.4, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0462', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-18',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX8112 01/18',
    0.0, 128.25, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000984', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0462'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX8112 01/18',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000985', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0462'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SQ *BLUE MOON ESTATE SA Katy TX 01/18',
    108.25, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0463', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-18',
    'Payment',
    'Payment - 2025-01-18',
    4871.69, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000986', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0463'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    4871.69, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0464', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-19',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX 01/18',
    0.0, 172.49, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000987', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0464'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX 01/18',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000988', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0464'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LOWE''S #1052 TOMBALL TX XX3367 01/19',
    131.21, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000989', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0464'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LOWE''S #1052 TOMBALL TX XX1203 01/19',
    6.37, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000990', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0464'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'FULSHEAR ACE HARDWARE FULSHEAR TX 01/19',
    14.91, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0465', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-20',
    'Expense',
    'MCDONALD''S FX2340 WILLIS TX 01/20',
    0.0, 3337.04, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000991', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0465'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCDONALD''S FX2340 WILLIS TX 01/20',
    5.41, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000992', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0465'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1901 MAGNOLIA TX XX1991 01/20',
    19.53, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000993', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0465'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S #40 OUTSIDE KATY TX XX6320 01/20',
    63.79, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000994', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0465'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S #40 KATY TX 01/20',
    98.06, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000995', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0465'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TEXAS STATE RENTALS XXX-XXX0300 TX 01/20',
    3116.82, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000996', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0465'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'DUMAS''S TACO COMPANY TOMBALL TX 01/20',
    33.43, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0466', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-21',
    'Deposit',
    'Online Transfer from CHK ...5317 transaction#: XXXXXXX6528',
    100000.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000997', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0466'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Transfer from CHK ...5317 transaction#: XXXXXXX6528',
    100000.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0467', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-21',
    'Expense',
    'Online ACH Payment XXXXXXX6184 To GTCrane (_#####3597)',
    0.0, 53152.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000998', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0467'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX6184 To GTCrane (_#####3597)',
    1262.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000999', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0467'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX6184 To GTCrane (_#####3597)',
    1890.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001000', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0467'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ONLINE DOMESTIC WIRE TRANSFER VIA: WELLS FARGO NA/XXXXX0248 A/C: MUSTANG MACHINERY COMPANY HOUSTON TX X7210 US REF: DEPOSIT FOR 2X CAT GENERATORS/TIME/13:36 IMA D: 0121MMQFMP2MXX8028 TRN: XXXXXX5021 ES 01/21',
    50000.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0468', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-22',
    'Expense',
    '9235 CLAY ROAD BUSINES HOUSTON TX XX4927 10/07',
    0.0, 150310.22999999998, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001001', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0468'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '9235 CLAY ROAD BUSINES HOUSTON TX XX4927 10/07',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001002', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0468'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ONLINE DOMESTIC WIRE TRANSFER VIA: WELLS FARGO NA/XXXXX0248 A/C: MUSTANG MACHINERY COMPANY LLC HOUSTON TX X7210 US REF: REMAINING DEPOSIT FOR 2X CAT XQ1475/TIME /14:30 IMAD: 0122MMQFMP2KXX5696 TRN: XXXXXX5022 ES 01/22',
    150000.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001003', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0468'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1420 KATY TX XX7893 01/22',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001004', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0468'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TAQUERIA AZTECA D.F EAGLE LAKE TX 01/22',
    50.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001005', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0468'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MINUTEKEY BOULDER CO 01/23',
    14.07, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001006', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0468'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MINUTEKEY BOULDER CO 01/23',
    10.83, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001007', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0468'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'APPLE LUMBER BRANCH 40 EAGLE LAKE TX XX3876 01/22',
    175.33, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0469', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-22',
    'Invoice',
    'Invoice - 2025-01-22',
    20218.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001008', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0469'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    20218.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0470', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-22',
    'Payment',
    'Payment - 2025-01-22',
    6505.6, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001009', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0470'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    6505.6, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0471', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-23',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX0407 01/23',
    0.0, 92.42, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001010', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0471'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX0407 01/23',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001011', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0471'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TEJAS CHOCOLATE & BARB XXX-XXX0670 TX 01/23',
    61.61, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001012', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0471'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BEST BUY #235 CORPUS CHRIST TX XX6533 01/23',
    10.81, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0472', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-24',
    'Expense',
    'CIRCLE K #XXX1901 MAGNOLIA TX XX4637 01/24',
    0.0, 381.82000000000005, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001013', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0472'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1901 MAGNOLIA TX XX4637 01/24',
    50.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001014', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0472'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCDONALD''S FX1738 TRINITY TX 01/24',
    5.41, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001015', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0472'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'STRIPES XXXXXX2700 CORPUS CHRIST TX 01/24',
    78.81, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001016', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0472'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LOWE''S #1052 TOMBALL TX XX3590 01/24',
    227.24, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001017', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0472'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TARGET T-1904 TOMBALL TX XX0342 01/24',
    20.36, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0473', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-25',
    'Expense',
    'CIRCLE K #XXX2369 HOUSTON TX XX9969 01/25',
    0.0, 57.24, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001018', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0473'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX2369 HOUSTON TX XX9969 01/25',
    50.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001019', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0473'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCDONALD''S FX2340 WILLIS TX 01/25',
    7.24, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0474', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-26',
    'Invoice',
    'Invoice - 2025-01-26',
    37627.87, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001020', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0474'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    37627.87, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0475', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-26',
    'Invoice',
    'Invoice - 2025-01-26',
    2831.25, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001021', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0475'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    2831.25, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0476', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-27',
    'Deposit',
    'TRACTOR SUPPLY #1106 CROCKETT TX 01/27',
    43.3, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001022', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0476'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TRACTOR SUPPLY #1106 CROCKETT TX 01/27',
    43.3, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0477', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-27',
    'Expense',
    'TRACTOR SUPPLY # 1408 CROCKETT TX XX1174 01/27',
    0.0, 386.71999999999997, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001023', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0477'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TRACTOR SUPPLY # 1408 CROCKETT TX XX1174 01/27',
    10.69, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001024', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0477'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MURPHY EXPRESS 8669 TOMBALL TX XX8561 01/27',
    57.28, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001025', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0477'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX1520 01/27',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001026', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0477'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TRACTOR SUPPLY # 1408 CROCKETT TX XX4779 01/27',
    219.72, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001027', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0477'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CASTANEDA''S MEAT MARKE XXX-XXX3627 TX 01/27',
    42.2, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001028', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0477'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'STOWE LMB CO CROCKETT TX 01/27',
    16.83, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0478', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-28',
    'Expense',
    'LA RIBERA TAQUERIA & RE REFUGIO TX 01/28',
    0.0, 688.87, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001029', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0478'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LA RIBERA TAQUERIA & RE REFUGIO TX 01/28',
    10.28, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001030', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0478'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1403 ROSENBERG TX XX8864 01/28',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001031', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0478'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WHATABURGER 319 Q26 REFUGIO TX 01/28',
    13.47, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001032', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0478'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # X6979 REFUGIO TX XX2951 01/28',
    9.74, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001033', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0478'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # X6983 MATHIS TX XX5689 01/28',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001034', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0478'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Valero1286 SINTON TX XX0289 01/28',
    11.31, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001035', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0478'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'THE TEXAN #7 - GOLIAD GOLIAD TX XX2968 01/28',
    35.88, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001036', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0478'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Valero VICTORIA TX XX5898 01/28',
    73.47, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001037', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0478'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'FSP*TEXAS GRIME DUMPS XXX-XXX-2979 TX 01/28',
    464.72, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0479', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-29',
    'Expense',
    'CIRCLE K #XXX0595 RIVERSIDE TX XX5909 01/29',
    0.0, 40.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001038', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0479'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX0595 RIVERSIDE TX XX5909 01/29',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0480', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-29',
    'Invoice',
    'Invoice - 2025-01-29',
    10990.99, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001039', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0480'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    10990.99, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0481', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-30',
    'Expense',
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250130 CO ENTRY DESCR:TAX XX1696SEC:CCD TRACE#:XXXXXXXX2645206 EED:250130 IND ID:6 semk3h0sr4 IND NAME:10NetZero, Inc. 6semjnbv8o0 TRN: XXXXXX5206 TC',
    0.0, 27295.33, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001040', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0481'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250130 CO ENTRY DESCR:TAX XX1696SEC:CCD TRACE#:XXXXXXXX2645206 EED:250130 IND ID:6 semk3h0sr4 IND NAME:10NetZero, Inc. 6semjnbv8o0 TRN: XXXXXX5206 TC',
    8057.56, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001041', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0481'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250130 CO ENTRY DESCR:NET XX1698SEC:CCD TRACE#:XXXXXXXX2647273 EED:250130 IND ID:6 semk3h0sr3 IND NAME:10NetZero, Inc. 6semjnbv8o2 TRN: XXXXXX7273 TC',
    13904.94, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001042', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0481'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ATT*BILL PAYMENT XXX-XXX-2020 TX 01/30',
    242.91, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001043', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0481'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250130 CO ENTRY DESCR:NET XX1704SEC:CCD TRACE#:XXXXXXXX2645817 EED:250130 IND ID:6 semk3h0roo IND NAME:10NetZero, Inc. 6semjnbv8o8 TRN: XXXXXX5817 TC',
    3280.65, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001044', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0481'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250130 CO ENTRY DESCR:TAX XX1522SEC:CCD TRACE#:XXXXXXXX2644554 EED:250130 IND ID:6 semk3h0rop IND NAME:10NetZero, Inc. 6semjnbv8ii TRN: XXXXXX4554 TC',
    1342.27, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001045', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0481'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CPA TEXAS TAX WWW.TEXAS.GOV TX 01/30',
    52.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001046', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0481'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CPA TEXAS TAX WWW.TEXAS.GOV TX 01/30',
    51.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001047', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0481'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CPA TEXAS TAX WWW.TEXAS.GOV TX 01/30',
    52.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001048', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0481'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CPA TEXAS TAX WWW.TEXAS.GOV TX 01/30',
    52.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001049', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0481'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CPA TEXAS TAX WWW.TEXAS.GOV TX 01/30',
    52.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001050', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0481'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CPA TEXAS TAX WWW.TEXAS.GOV TX 01/30',
    52.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001051', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0481'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CPA TEXAS TAX WWW.TEXAS.GOV TX 01/30',
    52.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001052', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0481'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CPA TEXAS TAX WWW.TEXAS.GOV TX 01/30',
    52.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001053', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0481'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CPA TEXAS TAX WWW.TEXAS.GOV TX 01/30',
    52.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0482', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-31',
    'Expense',
    'H-E-B GAS/CARWASH #109 HOUSTON TX XX4753 01/31',
    0.0, 311.74, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001054', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0482'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'H-E-B GAS/CARWASH #109 HOUSTON TX XX4753 01/31',
    42.12, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001055', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0482'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'PERRYS STEAK HOUSE & G HOUSTON TX 01/31',
    192.38, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001056', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0482'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'EXXON FULSHEAR RE LLC FULSHEAR TX 01/31',
    28.99, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001057', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0482'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'APPLE LUMBER BRANCH 40 EAGLE LAKE TX XX7221 01/31',
    48.25, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0483', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-01',
    'Expense',
    'RAISING CANES 0162 CONROE TX 02/01',
    0.0, 85.34, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001058', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0483'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'RAISING CANES 0162 CONROE TX 02/01',
    17.31, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001059', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0483'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'KROGER FUEL CTR X0355 CYPRESS TX XX3532 02/01',
    68.03, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0484', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-02',
    'Expense',
    'UNCHAINED CAPITAL WWW.UNCHAINED TX 02/02',
    0.0, 500.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001060', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0484'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'UNCHAINED CAPITAL WWW.UNCHAINED TX 02/02',
    500.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0485', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-03',
    'Expense',
    'CIRCLE K # X6979 REFUGIO TX XX1175 02/03',
    0.0, 538.93, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001061', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0485'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # X6979 REFUGIO TX XX1175 02/03',
    4.69, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001062', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0485'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'O''REILLY 1652 REFUGIO TX XX3513 02/03',
    205.63, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001063', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0485'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # X6983 MATHIS TX XX6971 02/03',
    43.49, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001064', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0485'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LA RIBERA TAQUERIA & RE REFUGIO TX 02/03',
    7.28, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001065', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0485'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NAPA MATHIS MATHIS TX 02/03',
    36.63, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001066', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0485'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCDONALD''S FX0850 MATHIS TX 02/03',
    10.82, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001067', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0485'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TST*SMOLIKS SMOKEHOUSE Mathis TX 02/03',
    37.75, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001068', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0485'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SHELL OIL XXXXXXX2008 EL CAMPO TX 02/03',
    25.01, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001069', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0485'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NAPA MATHIS MATHIS TX 02/03',
    50.28, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001070', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0485'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'EXXON SPEEDY EXPRESS # MATHIS TX 02/03',
    2.89, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001071', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0485'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Valero VICTORIA TX XX5329 02/03',
    76.06, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001072', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0485'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ALAMO LUMBER COMPANY M MATHIS TX XX8596 02/03',
    38.4, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0486', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-03',
    'Payment',
    'Payment - 2025-02-03',
    10990.99, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001073', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0486'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    10990.99, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0487', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-04',
    'Expense',
    'MCDONALD''S FX0850 MATHIS TX 02/04',
    0.0, 240.55, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001074', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0487'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCDONALD''S FX0850 MATHIS TX 02/04',
    8.87, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001075', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0487'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # X6983 MATHIS TX XX4220 02/04',
    5.4, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001076', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0487'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # X6983 MATHIS TX XX2885 02/04',
    53.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001077', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0487'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX2369 HOUSTON TX XX4893 02/04',
    41.28, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001078', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0487'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'FOREMAN.MN FOREMAN.MN MD 02/05',
    132.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0488', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-05',
    'Expense',
    'SERVICE CHARGES FOR THE MONTH OF JANUARY',
    0.0, 200.17000000000002, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001079', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0488'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SERVICE CHARGES FOR THE MONTH OF JANUARY',
    12.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001080', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0488'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LOVE''S #0617 OUTSIDE HUNGERFORD TX XX7664 02/05',
    65.51, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001081', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0488'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WHATABURGER 428 Q26 EDNA TX 02/05',
    16.39, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001082', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0488'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LA RIBERA TAQUERIA & RE REFUGIO TX 02/05',
    9.83, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001083', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0488'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4007 DESC DATE:250205 CO ENTRY DESCR:FEE XX5253SEC:CCD TRACE#:XXXXXXXX2468539 EED:250205 IND ID:6 semk3jcn9p IND NAME:10NetZero, Inc. 6semjnc7tl5 TRN: XXXXXX8539 TC',
    95.94, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0489', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-06',
    'Expense',
    'O''REILLY 6123 EAGLE LAKE TX XX5049 02/06',
    0.0, 109.97, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001084', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0489'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'O''REILLY 6123 EAGLE LAKE TX XX5049 02/06',
    9.19, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001085', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0489'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'DEL FRISCOS HOUSTON HOUSTON TX 02/07',
    10.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001086', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0489'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'EXXON FULSHEAR RE LLC FULSHEAR TX 02/06',
    76.28, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001087', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0489'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'VINCEKS SMOKEHOUSE IN EAST BERNARD TX 02/06',
    14.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0490', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-07',
    'Expense',
    'CORPUS MM/GAS XX0273 CORPUS CHRIS TX XX4618 02/07',
    0.0, 25144.570000000003, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001088', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0490'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CORPUS MM/GAS XX0273 CORPUS CHRIS TX XX4618 02/07',
    61.73, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001089', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0490'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX0565 HOUSTON TX XX5077 02/07',
    33.38, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001090', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0490'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ONLINE DOMESTIC WIRE TRANSFER VIA: PROSPERITY BK ELCA/XXXXX2655 A/C: CHIRON FINANCIAL LLC HOUSTON TX X7010 US REF: ATTENTION TODD A. HASS - INVOICE XXXX25-01/TI ME/17:07 IMAD: 0207MMQFMP2LXX4630 TRN: XXXXXX5038 ES 02/07',
    25000.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001091', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0490'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ARLO TECHNOLOGIES INC XXX-XXX-3750 CA 02/09',
    10.65, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001092', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0490'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LYFT *1 RIDE 02-05 HELP.LYFT.COM CA 02/07',
    38.81, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0491', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-08',
    'Expense',
    'LYFT *1 RIDE 02-06 HELP.LYFT.COM CA 02/08',
    0.0, 25.36, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001093', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0491'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LYFT *1 RIDE 02-06 HELP.LYFT.COM CA 02/08',
    25.36, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0492', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-09',
    'Expense',
    'Valero VICTORIA TX XX3296 02/09',
    0.0, 108.02, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001094', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0492'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Valero VICTORIA TX XX3296 02/09',
    67.52, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001095', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0492'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NETLIFY NETLIFY.COM CA 02/09',
    40.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0493', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-10',
    'Expense',
    'CIRCLE K #XXX2369 HOUSTON TX XX6235 02/10',
    0.0, 14577.65, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001096', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0493'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX2369 HOUSTON TX XX6235 02/10',
    41.1, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001097', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0493'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'PANDA EXPRESS # 3059 WILLIS TX 02/10',
    13.53, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001098', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0493'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ADOBE *XXX-XXX-6687 ADOBE.LY/ENUS CA 02/11',
    21.64, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001099', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0493'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'DARK HORSE CPAS WWW.DARKHORSE CA 02/10',
    1050.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001100', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0493'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LEGALZOOM* TRADEMARK XXX-XXX0151 CA 02/10',
    350.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001101', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0493'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CORPORATE FILINGS LLC XXX-XXX8466 WY 02/10',
    135.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001102', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0493'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX2049 To 2WServices (_###4108)',
    12966.38, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0494', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-10',
    'Invoice',
    'Invoice - 2025-02-10',
    27835.88, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001103', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0494'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    27835.88, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0495', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-10',
    'Payment',
    'Payment - 2025-02-10',
    20218.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001104', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0495'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    20218.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0496', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-11',
    'Expense',
    'CIRCLE K #XXX2369 HOUSTON TX XX2986 02/11',
    0.0, 5323.57, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001105', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0496'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX2369 HOUSTON TX XX2986 02/11',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001106', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0496'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CORPUS MM/GAS XX0273 CORPUS CHRIS TX XX0421 02/11',
    53.57, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001107', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0496'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'DARK HORSE CPAS WWW.DARKHORSE CA 02/11',
    5250.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0497', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-12',
    'Expense',
    'BUC-EE''S #30 WHARTON TX 02/12',
    0.0, 166.81, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001108', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0497'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S #30 WHARTON TX 02/12',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001109', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0497'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SUNOCO XXXXXX1300 MATHIS TX XX4856 02/12',
    4.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001110', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0497'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # X6979 REFUGIO TX XX7712 02/12',
    19.99, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001111', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0497'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # X6979 REFUGIO TX XX1347 02/12',
    42.07, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001112', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0497'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SPEEDY EXPRESS #38 MATHIS TX XX3818 02/12',
    6.81, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001113', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0497'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TEXAN # 8 VICTORIA VICTORIA TX XX7250 02/12',
    63.44, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0498', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-12',
    'Payment',
    'Payment - 2025-02-12',
    27835.88, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001114', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0498'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    27835.88, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0499', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-13',
    'Expense',
    'O''REILLY 1652 REFUGIO TX XX6433 02/13',
    0.0, 4466.85, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001115', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0499'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'O''REILLY 1652 REFUGIO TX XX6433 02/13',
    154.75, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001116', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0499'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # X6979 REFUGIO TX XX6135 02/13',
    50.14, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001117', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0499'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'INTUIT *QBooks Onlin CL.INTUIT.COM CA 11/13',
    69.29, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001118', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0499'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NAPA MATHIS MATHIS TX 02/13',
    43.28, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001119', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0499'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S #30 WHARTON TX 02/13',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001120', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0499'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCDONALD''S FX2899 REFUGIO TX 02/13',
    5.41, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001121', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0499'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S #30 WHARTON TX 02/13',
    2.98, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001122', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0499'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX9718 To Easley''s Crane Service 02/13',
    1611.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001123', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0499'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX9887 To 6J Farm & Ranch Construction , LLC 02/13',
    2500.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0500', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-02-14',
    'Deposit',
    'ORIG CO NAME:INTUIT ORIG ID:XXXXXX6206 DESC DATE:250214 CO ENTRY DESCR:ACCTVERIFYSEC:PPD TRACE#:XXXXXXXX3003159 EED:250214 IND ID: IND NAME:10NETZERO, INC. TRN: XXXXXX3159TC',
    0.17, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-001124', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0500'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:INTUIT ORIG ID:XXXXXX6206 DESC DATE:250214 CO ENTRY DESCR:ACCTVERIFYSEC:PPD TRACE#:XXXXXXXX3003159 EED:250214 IND ID: IND NAME:10NETZERO, INC. TRN: XXXXXX3159TC',
    0.17, true
) ON CONFLICT (line_id_display) DO NOTHING;

