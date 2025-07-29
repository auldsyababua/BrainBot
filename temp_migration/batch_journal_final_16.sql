-- Journal Entries Final Batch 16

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0300', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-10',
    'Expense',
    '1140',
    'Love''s Country Stores',
    'LOVE''S #0290 OUTSIDE LUFKIN TX 07/10'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0300'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 76.0,
    'LOVE''S #0290 OUTSIDE LUFKIN TX 07/10'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0300'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 16.22,
    'ADOBE *XXX-XXX-6687 ADOBE.LY/ENUS CA 07/11'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0301', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-11',
    'Expense',
    '1140',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX4837 07/11'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0301'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 30.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX4837 07/11'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0302', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-12',
    'Expense',
    '1140',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX 07/12'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0302'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 83.94,
    'CIRCLE K #XXX1915 CYPRESS TX 07/12'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0302'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 29.71,
    'RAISING CANES 0419 TOMBALL TX 07/12'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0302'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 50.0,
    'SAMS CLUB RENEWAL HOUSTON TX 07/12'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0303', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-13',
    'Expense',
    '1140',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX3480 07/13'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0303'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 15.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX3480 07/13'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0303'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 12.0,
    'MCDONALD''S FX9431 CYPRESS TX 07/13'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0304', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-15',
    'Expense',
    '1140',
    'Jack in the Box',
    'Online Payment XXXXXXX5965 To Petroleum producing services LLC 07/15'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0304'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 3228.0,
    'Online Payment XXXXXXX5965 To Petroleum producing services LLC 07/15'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0304'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 12.97,
    'JACK IN THE BOX TOMBALL TX XX5801 07/15'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0304'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 10.81,
    'HARBOR FREIGHT TOOLS 5 HOUSTON TX 07/15'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0304'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 2165.77,
    'ORIG CO NAME:F3X ENERGY SERVI ORIG ID:XXXXXX6202 DESC DATE:240715 CO ENTRY DESCR:SALE SEC:WEB TRACE#:XXXXXXXX8662869 EED:240715 IND ID: IND NAME:10NETZERO INC T RN: XXXXXX2869TC'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0304'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 500.0,
    'ORIG CO NAME:SCHILLEREFF POWE ORIG ID:XXXXXX6202 DESC DATE:240715 CO ENTRY DESCR:SALE SEC:CCD TRACE#:XXXXXXXX8671457 EED:240715 IND ID: IND NAME:10NETZERO INC T RN: XXXXXX1457TC'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0304'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 2000.0,
    'Zelle payment to AJ Garcia XXXXXXX5659'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0305', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-16',
    'Expense',
    '1140',
    NULL,
    'Zelle payment to AJ Garcia XXXXXXX1534'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0305'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 900.0,
    'Zelle payment to AJ Garcia XXXXXXX1534'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0306', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-17',
    'Expense',
    '1140',
    'Schillereff Power Generation',
    'Online ACH Payment XXXXXXX6122 To JohnSchillereff (_#####5067)'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0306'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 7339.35,
    'Online ACH Payment XXXXXXX6122 To JohnSchillereff (_#####5067)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0307', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-18',
    'Expense',
    '1140',
    'Circle K',
    'CIRCLE K #XXX0719 WHARTON TX XX3917 07/18'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0307'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 30.0,
    'CIRCLE K #XXX0719 WHARTON TX XX3917 07/18'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0308', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-19',
    'Expense',
    '1140',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX7597 07/19'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0308'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 20.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX7597 07/19'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0308'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 9.3,
    'MCDONALD''S FX9431 CYPRESS TX 07/19'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0309', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-20',
    'Expense',
    '1140',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX9482 07/20'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0309'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 15.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX9482 07/20'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0309'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 15.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX2067 07/20'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0310', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-21',
    'Expense',
    '1140',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX9991 07/21'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0310'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 4.94,
    'CIRCLE K #XXX1915 CYPRESS TX XX9991 07/21'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0310'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 10.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX5047 07/21'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0311', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-22',
    'Expense',
    '1140',
    'Schillereff Power Generation',
    'AGI*TMO SERVICE FEE XXX-XXX-6285 PA 07/23'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0311'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 105.19,
    'AGI*TMO SERVICE FEE XXX-XXX-6285 PA 07/23'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0311'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 1711.54,
    'Online ACH Payment XXXXXXX3205 To JohnSchillereff (_#####5067)'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0311'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 476.0,
    'Online ACH Payment XXXXXXX4724 To Bernardo (_######3816)'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0311'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 820.0,
    'DRAKE CONTROLS LLC XXX-XXX0190 TX 07/22'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0312', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-23',
    'Expense',
    '1140',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX7416 07/23'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0312'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 20.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX7416 07/23'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0313', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-24',
    'Expense',
    '1140',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX9521 07/24'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0313'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 20.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX9521 07/24'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0313'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 400.0,
    'AT&T BILL PAYMENT XXX-XXX-0500 TX 07/24'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0313'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 11.89,
    'ALAMO LUMBER COMPANY M MATHIS TX XX8914 07/24'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0313'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 100.0,
    'AT&T BILL PAYMENT XXX-XXX-0500 TX 07/24'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0314', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-25',
    'Expense',
    '1140',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX5479 07/25'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0314'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 20.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX5479 07/25'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0314'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 74.0,
    'CORPUS MM/GAS 0 CORPUS CHRIS TX 07/25'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0315', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-26',
    'Expense',
    '1140',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX3543 07/26'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0315'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 30.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX3543 07/26'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0315'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 5.41,
    'MCDONALD''S FX7220 HOUSTON TX 07/26'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0316', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-28',
    'Expense',
    '1140',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX3335 07/28'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0316'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 20.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX3335 07/28'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0316'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 50.83,
    'LOWE''S #1052 TOMBALL TX XX6413 07/28'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0317', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-29',
    'Journal Entry',
    '11',
    NULL,
    'Journal Entry - 2024-07-29'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0317'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-5100'),
    1,
    0, 18216.89,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0318', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-29',
    'Expense',
    '1140',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX7482 07/29'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0318'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 20.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX7482 07/29'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0318'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 16.53,
    'Store Cypress TX 07/30'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0319', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-30',
    'Expense',
    '11',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX5419 07/30'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0319'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 19.47,
    'CIRCLE K #XXX1915 CYPRESS TX XX5419 07/30'
);

