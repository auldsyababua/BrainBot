-- Journal Entries Batch 7

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0301', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-11',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX4837 07/11',
    0.0, 30.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000600', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0301'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX4837 07/11',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0302', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-12',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX 07/12',
    0.0, 163.65, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000601', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0302'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX 07/12',
    83.94, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000602', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0302'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'RAISING CANES 0419 TOMBALL TX 07/12',
    29.71, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000603', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0302'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SAMS CLUB RENEWAL HOUSTON TX 07/12',
    50.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0303', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-13',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX3480 07/13',
    0.0, 27.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000604', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0303'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX3480 07/13',
    15.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000605', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0303'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCDONALD''S FX9431 CYPRESS TX 07/13',
    12.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0304', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-15',
    'Expense',
    'Online Payment XXXXXXX5965 To Petroleum producing services LLC 07/15',
    0.0, 7917.549999999999, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000606', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0304'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX5965 To Petroleum producing services LLC 07/15',
    3228.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000607', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0304'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'JACK IN THE BOX TOMBALL TX XX5801 07/15',
    12.97, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000608', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0304'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'HARBOR FREIGHT TOOLS 5 HOUSTON TX 07/15',
    10.81, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000609', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0304'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:F3X ENERGY SERVI ORIG ID:XXXXXX6202 DESC DATE:240715 CO ENTRY DESCR:SALE SEC:WEB TRACE#:XXXXXXXX8662869 EED:240715 IND ID: IND NAME:10NETZERO INC T RN: XXXXXX2869TC',
    2165.77, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000610', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0304'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:SCHILLEREFF POWE ORIG ID:XXXXXX6202 DESC DATE:240715 CO ENTRY DESCR:SALE SEC:CCD TRACE#:XXXXXXXX8671457 EED:240715 IND ID: IND NAME:10NETZERO INC T RN: XXXXXX1457TC',
    500.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000611', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0304'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Zelle payment to AJ Garcia XXXXXXX5659',
    2000.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0305', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-16',
    'Expense',
    'Zelle payment to AJ Garcia XXXXXXX1534',
    0.0, 900.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000612', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0305'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Zelle payment to AJ Garcia XXXXXXX1534',
    900.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0306', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-17',
    'Expense',
    'Online ACH Payment XXXXXXX6122 To JohnSchillereff (_#####5067)',
    0.0, 7339.35, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000613', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0306'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX6122 To JohnSchillereff (_#####5067)',
    7339.35, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0307', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-18',
    'Expense',
    'CIRCLE K #XXX0719 WHARTON TX XX3917 07/18',
    0.0, 30.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000614', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0307'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX0719 WHARTON TX XX3917 07/18',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0308', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-19',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX7597 07/19',
    0.0, 29.3, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000615', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0308'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX7597 07/19',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000616', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0308'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCDONALD''S FX9431 CYPRESS TX 07/19',
    9.3, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0309', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-20',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX9482 07/20',
    0.0, 30.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000617', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0309'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX9482 07/20',
    15.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000618', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0309'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX2067 07/20',
    15.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0310', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-21',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX9991 07/21',
    0.0, 14.940000000000001, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000619', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0310'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX9991 07/21',
    4.94, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000620', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0310'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX5047 07/21',
    10.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0311', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-22',
    'Expense',
    'AGI*TMO SERVICE FEE XXX-XXX-6285 PA 07/23',
    0.0, 3112.73, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000621', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0311'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'AGI*TMO SERVICE FEE XXX-XXX-6285 PA 07/23',
    105.19, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000622', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0311'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX3205 To JohnSchillereff (_#####5067)',
    1711.54, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000623', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0311'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX4724 To Bernardo (_######3816)',
    476.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000624', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0311'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'DRAKE CONTROLS LLC XXX-XXX0190 TX 07/22',
    820.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0312', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-23',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX7416 07/23',
    0.0, 20.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000625', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0312'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX7416 07/23',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0313', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-24',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX9521 07/24',
    0.0, 531.89, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000626', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0313'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX9521 07/24',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000627', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0313'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'AT&T BILL PAYMENT XXX-XXX-0500 TX 07/24',
    400.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000628', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0313'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ALAMO LUMBER COMPANY M MATHIS TX XX8914 07/24',
    11.89, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000629', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0313'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'AT&T BILL PAYMENT XXX-XXX-0500 TX 07/24',
    100.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0314', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-25',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX5479 07/25',
    0.0, 94.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000630', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0314'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX5479 07/25',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000631', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0314'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CORPUS MM/GAS 0 CORPUS CHRIS TX 07/25',
    74.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0315', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-26',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX3543 07/26',
    0.0, 35.41, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000632', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0315'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX3543 07/26',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000633', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0315'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCDONALD''S FX7220 HOUSTON TX 07/26',
    5.41, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0316', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-28',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX3335 07/28',
    0.0, 70.83, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000634', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0316'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX3335 07/28',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000635', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0316'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LOWE''S #1052 TOMBALL TX XX6413 07/28',
    50.83, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0317', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-29',
    'Journal Entry',
    'Journal Entry - 2024-07-29',
    0.0, 18216.89, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000636', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0317'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-5100'),
    '',
    18216.89, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0318', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-29',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX7482 07/29',
    0.0, 36.53, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000637', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0318'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX7482 07/29',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000638', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0318'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Store Cypress TX 07/30',
    16.53, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0319', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-30',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX5419 07/30',
    0.0, 19.47, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000639', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0319'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX5419 07/30',
    19.47, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0320', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-31',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX9874 07/31',
    0.0, 70.67, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000640', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0320'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX9874 07/31',
    15.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000641', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0320'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WAL-MART #0703 TOMBALL TX XX0171 07/31',
    55.67, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0321', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-01',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX0323 08/01',
    0.0, 145.17000000000002, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000642', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0321'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX0323 08/01',
    14.17, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000643', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0321'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1906 COLLEGE STATI TX XX1902 08/01',
    40.59, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000644', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0321'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCDONALD''S FX2848 NAVASOTA TX 08/01',
    10.06, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000645', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0321'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CHIPOTLE 2794 TOMBALL TX 07/31',
    13.91, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000646', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0321'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'GRAINGER XXX-XXX4643 IL 07/31',
    66.44, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0322', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-02',
    'Expense',
    'APACHE OIL COMPANY PASADENA TX 08/02',
    0.0, 1140.87, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000647', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0322'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'APACHE OIL COMPANY PASADENA TX 08/02',
    1140.87, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0323', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-05',
    'Deposit',
    'FEDWIRE CREDIT VIA: FIRST FINANCIAL BANK/XXXXX1122 B/O: WASTEWATT VENTUR FORT WORTH, TX XXXXX4071 REF: CHASE NYC/CTR/BNF=10NETZERO, INC. HOUSTON TX XXXXX-6626 U S/AC-XXXX0000 5231 RFB=O/B FFIN ABILENE IMAD: 0805MMQFMPXXXX0012 TRN: XXXXXX1218 FF',
    20000.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000648', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0323'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'FEDWIRE CREDIT VIA: FIRST FINANCIAL BANK/XXXXX1122 B/O: WASTEWATT VENTUR FORT WORTH, TX XXXXX4071 REF: CHASE NYC/CTR/BNF=10NETZERO, INC. HOUSTON TX XXXXX-6626 U S/AC-XXXX0000 5231 RFB=O/B FFIN ABILENE IMAD: 0805MMQFMPXXXX0012 TRN: XXXXXX1218 FF',
    20000.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0324', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-05',
    'Expense',
    'SHELL SERVICE STATION EAST BERNARD TXXX2760 08/05',
    0.0, 659.35, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000649', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0324'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SHELL SERVICE STATION EAST BERNARD TXXX2760 08/05',
    91.51, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000650', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0324'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SHELL OIL XXXXXXX1528 EAST BERNARD TX 08/05',
    80.28, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000651', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0324'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX9032 08/05',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000652', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0324'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S #30 WHARTON TX 08/05',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000653', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0324'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SERVICE CHARGES FOR THE MONTH OF JULY',
    75.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000654', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0324'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TST*SMOLIKS SMOKEHOUSE Mathis TX 08/05',
    62.81, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000655', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0324'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'O''REILLY 1652 REFUGIO TX XX9484 08/05',
    259.75, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000656', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0324'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Gas',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0325', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-05',
    'Journal Entry',
    'Journal Entry - 2024-08-05',
    0.0, 18216.89, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000657', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0325'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1300'),
    '',
    18216.89, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0326', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-06',
    'Deposit',
    'Online Transfer from CHK ...5317 transaction#: XXXXXXX1342',
    18820.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000658', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0326'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Transfer from CHK ...5317 transaction#: XXXXXXX1342',
    18820.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0327', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-06',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX3866 08/06',
    0.0, 26059.309999999998, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000659', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0327'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX3866 08/06',
    15.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000660', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0327'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1487 CYPRESS TX XX3296 08/06',
    20.65, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000661', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0327'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:IPFSXXX-XXX-2621 ORIG ID:0 ADXXX4370 DESC DATE: CO ENTRY DESCR:IPFSPMTTXPSEC:CCD TRACE#:XXXXXXXX2177554 EED:240806 IND ID:62397 IND NAME:10 NET ZERO INC. GDxLk2vV TRN: XXXXXX7554 TC',
    559.66, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000662', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0327'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX9619 To JohnSchillereff (_#####5067)',
    6644.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000663', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0327'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX0877 To BarbeeCrane (_##4802)',
    1920.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000664', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0327'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX6567 To JoeSingleSourceLufkin (_#####6386)',
    16900.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0328', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-07',
    'Deposit',
    'BEST BUY MHT XXXX4134 CYPRESS TX 08/07',
    216.49, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000665', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0328'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BEST BUY MHT XXXX4134 CYPRESS TX 08/07',
    216.49, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0329', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-07',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX4757 08/07',
    0.0, 231.49, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000666', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0329'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX4757 08/07',
    15.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000667', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0329'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BEST BUY XXXX5172 RICHMOND TX XX2095 08/07',
    216.49, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0330', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-08',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX8093 08/08',
    0.0, 35.019999999999996, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000668', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0330'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX8093 08/08',
    6.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000669', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0330'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX4948 08/08',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000670', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0330'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ARLO TECHNOLOGIES INC XXX-XXX-3750 CA 08/09',
    8.52, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0331', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-09',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX1289 08/09',
    0.0, 855.6999999999999, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000671', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0331'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX1289 08/09',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000672', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0331'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SOUTHWELLS HAMBURGER G HOUSTON TX 08/09',
    40.05, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000673', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0331'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TST* KIRBY ICE HOUSE - HOUSTON TX 08/10',
    14.75, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000674', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0331'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NETLIFY HTTPSWWW.NETL CA 08/09',
    20.25, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000675', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0331'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX4299 To Bernardo (_######3816)',
    760.65, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0332', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-10',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX5860 08/10',
    0.0, 55.69, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000676', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0332'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX5860 08/10',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000677', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0332'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX9378 08/10',
    10.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000678', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0332'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCDONALD''S FX9431 CYPRESS TX 08/10',
    4.05, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000679', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0332'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ADOBE *XXX-XXX-6687 ADOBE.LY/ENUS CA 08/11',
    21.64, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0333', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-11',
    'Expense',
    '9235 CLAY ROAD BUSINES HOUSTON TX XX3906 08/11',
    0.0, 20.01, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000680', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0333'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '9235 CLAY ROAD BUSINES HOUSTON TX XX3906 08/11',
    20.01, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0334', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-12',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX8419 08/12',
    0.0, 99.16999999999999, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000681', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0334'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX8419 08/12',
    11.69, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000682', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0334'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX5727 08/12',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000683', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0334'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCDONALD''S FX9431 CYPRESS TX 08/12',
    6.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000684', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0334'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'GRAINGER XXX-XXX4643 IL 08/12',
    60.98, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0335', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-13',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX5821 08/13',
    0.0, 2546.5299999999997, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000685', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0335'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX5821 08/13',
    9.09, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000686', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0335'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'PANDA EXPRESS #1900 HOUSTON TX 08/13',
    14.94, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000687', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0335'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ATT*BILL PAYMENT XXX-XXX-2020 TX 08/13',
    500.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000688', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0335'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX6184 To GTCrane (_#####3597)',
    2022.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0336', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-14',
    'Deposit',
    'BOOK TRANSFER CREDIT B/O: ENGINEERED FLUIDS, INC. ST PETERSBURG FL XXXXX-2704 US REF: INV. 152 TRN: XXXXXX4227 ES',
    24000.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000689', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0336'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BOOK TRANSFER CREDIT B/O: ENGINEERED FLUIDS, INC. ST PETERSBURG FL XXXXX-2704 US REF: INV. 152 TRN: XXXXXX4227 ES',
    24000.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0337', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-14',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX9406 08/14',
    0.0, 26.5, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000690', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0337'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX9406 08/14',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000691', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0337'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCDONALD''S FX9431 CYPRESS TX 08/14',
    6.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0338', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-15',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX8393 08/15',
    0.0, 140.39, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000692', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0338'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX8393 08/15',
    5.19, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000693', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0338'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'FESCO LTD XXXXXX7000X15 TX 08/15',
    67.6, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000694', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0338'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'FESCO LTD XXXXXX7000X15 TX 08/15',
    67.6, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0339', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-16',
    'Deposit',
    'Online Transfer from CHK ...5317 transaction#: XXXXXXX4554',
    50000.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000695', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0339'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Transfer from CHK ...5317 transaction#: XXXXXXX4554',
    50000.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0340', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-16',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX5258 08/16',
    0.0, 50030.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000696', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0340'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX5258 08/16',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000697', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0340'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX4372 To F3XJamesandDusty (_#####7276)',
    50000.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0341', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-20',
    'Expense',
    'Online Payment XXXXXXX0394 To Kebo Oil and Gas, INC 08/20',
    0.0, 15665.3, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000698', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0341'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX0394 To Kebo Oil and Gas, INC 08/20',
    3421.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000699', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0341'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX2856 To JohnSchillereff (_#####5067)',
    9555.3, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000700', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0341'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX2779 To Bernardo (_######3816)',
    2689.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0342', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-23',
    'Journal Entry',
    'To reclassify the shipping expense from the balance sheet to the P&L under "Shipping & postage."',
    0.0, 1300.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0343', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-23',
    'Expense',
    'Online Payment XXXXXXX8633 To Kebo Oil and Gas, INC 08/23',
    0.0, 11598.51, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000702', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0343'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX8633 To Kebo Oil and Gas, INC 08/23',
    2250.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000703', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0343'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX8213 To Kebo Oil and Gas, INC 08/23',
    2325.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000704', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0343'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX5973 To Bernardo (_######3816)',
    5723.51, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000705', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0343'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:Express Transpor ORIG ID:204876018 DESC DATE:Aug 23 CO ENTRY DESCR:10 net zerSEC:CCD TRACE#:XXXXXXXX1320822 EED:240823 IND ID:connie IND NAME:10 ne t zero TRN: XXXXXX0822 TC',
    1300.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0344', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-26',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX1601 08/26',
    0.0, 33.44, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000706', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0344'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX1601 08/26',
    3.44, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000707', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0344'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX7030 08/26',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0345', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-27',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX0503 08/27',
    0.0, 520.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000708', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0345'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX0503 08/27',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000709', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0345'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WITHDRAWAL 08/27',
    500.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0346', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-28',
    'Deposit',
    'FEDWIRE CREDIT VIA: WELLS FARGO BANK, N.A./XXXXX0248 B/O: MALAMA ENERGY INC CA X0803 REF: CHASE NYC/CTR/BNF=10NETZERO, INC. HOUSTON TX XXXXX-6626 US/AC-XXXX0000 5231 RFB=OWXXXXXXXXXX7284 BBI=/CHGS/USD0,00/ IMAD: 0828I1B7033RXX2415 TRN: XXXXXX1241 FF',
    8800.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000710', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0346'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'FEDWIRE CREDIT VIA: WELLS FARGO BANK, N.A./XXXXX0248 B/O: MALAMA ENERGY INC CA X0803 REF: CHASE NYC/CTR/BNF=10NETZERO, INC. HOUSTON TX XXXXX-6626 US/AC-XXXX0000 5231 RFB=OWXXXXXXXXXX7284 BBI=/CHGS/USD0,00/ IMAD: 0828I1B7033RXX2415 TRN: XXXXXX1241 FF',
    8800.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0347', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-28',
    'Expense',
    'RAISING CANES 0419 TOMBALL TX 08/28',
    0.0, 256.19, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000711', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0347'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'RAISING CANES 0419 TOMBALL TX 08/28',
    29.63, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000712', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0347'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LOWE''S #1052 TOMBALL TX XX5955 08/28',
    6.56, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000713', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0347'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SQ *FARMER TRAILER RENT RICHMOND TX 08/28',
    220.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0348', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-29',
    'Expense',
    'LOVE''S #0617 OUTSIDE HUNGERFORD TX 08/29',
    0.0, 4012.13, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000714', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0348'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LOVE''S #0617 OUTSIDE HUNGERFORD TX 08/29',
    77.05, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000715', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0348'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Basic Online Payroll Payment XXXXXXX1202 to #########4504',
    3500.08, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000716', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0348'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '9235 CLAY ROAD BUSINES HOUSTON TX XX3890 08/29',
    10.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000717', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0348'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX0322 To GTCrane (_#####3597)',
    425.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0349', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-30',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX1625 08/30',
    0.0, 4595.88, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000718', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0349'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX1625 08/30',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000719', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0349'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1487 CYPRESS TX XX8073 08/30',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000720', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0349'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX3776 To Encore (_######6224)',
    1676.16, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000721', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0349'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX3585 To Encore (_######6224)',
    1902.59, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000722', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0349'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX1375 To Encore (_######6224)',
    937.13, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000723', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0349'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WAL-MART SUPER CENTER TOMBALL TX XX9084 08/30',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0350', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-31',
    'Expense',
    'CHEVRON XXX4813 TOMBALL TX 08/30',
    0.0, 202.19, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000724', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0350'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CHEVRON XXX4813 TOMBALL TX 08/30',
    92.19, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000725', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0350'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SQ *FARMER TRAILER RENT RICHMOND TX 08/30',
    110.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

