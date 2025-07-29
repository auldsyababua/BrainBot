-- Journal Entries Final Batch 32

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0620', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-19',
    'Invoice',
    '1061',
    'Flober LLC',
    'Invoice - 2025-05-19'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0620'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    1,
    1967.5, 0,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0621', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-19',
    'Expense',
    '1062',
    NULL,
    '7-ELEVEN HOUSTON TX XX8636 05/19'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0621'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 40.0,
    '7-ELEVEN HOUSTON TX XX8636 05/19'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0622', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-19',
    'Invoice',
    '1062',
    'Flober LLC',
    'Invoice - 2025-05-19'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0622'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    1,
    2572.35, 0,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0623', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-20',
    'Expense',
    '1062',
    'Walmart',
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/20'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0623'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 40.0,
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/20'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0623'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 34.04,
    'WM SUPERCENTER #437 SEALY TX XX9542 05/20'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0624', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-21',
    'Expense',
    '1062',
    NULL,
    '7-ELEVEN HOUSTON TX XX7774 05/21'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0624'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 40.0,
    '7-ELEVEN HOUSTON TX XX7774 05/21'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0624'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 21.97,
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/21'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0625', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-22',
    'Expense',
    '1062',
    'Tractor Supply',
    '7-ELEVEN HOUSTON TX XX2511 05/22'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0625'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 30.0,
    '7-ELEVEN HOUSTON TX XX2511 05/22'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0625'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 9.73,
    'MCDONALD''S FX0949 SEALY TX 05/22'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0625'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 54.41,
    'TRACTOR SUPPLY C 2340 SEALY TX XX7864 05/22'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0625'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 25.58,
    'AIRTABLE.COM/BILL AIRTABLE.COM CA 05/22'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0625'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 299.0,
    'TYPINGMIND.COM WWW.TYPINGMIN WY 05/22'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0625'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 21.32,
    'CURSOR, AI POWERED IDE CURSOR.COM NY 05/22'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0626', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-23',
    'Expense',
    '1062',
    NULL,
    'O''REILLY 6123 EAGLE LAKE TX XX7200 05/23'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0626'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 42.61,
    'O''REILLY 6123 EAGLE LAKE TX XX7200 05/23'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0626'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 40.0,
    '7-ELEVEN HOUSTON TX XX7974 05/23'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0626'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 49.2,
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/23'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0626'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 8.93,
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/23'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0626'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 10.48,
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/23'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0626'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 16.65,
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/23'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0627', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-26',
    'Invoice',
    '1063',
    'Flober LLC',
    'Invoice - 2025-05-26'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0627'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    1,
    1823.4, 0,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0628', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-26',
    'Deposit',
    '1064',
    NULL,
    'O''REILLY 6123 EAGLE LAKE TX XX1341 05/26'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0628'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    12.99, 0,
    'O''REILLY 6123 EAGLE LAKE TX XX1341 05/26'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0629', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-26',
    'Expense',
    '1064',
    NULL,
    'O''REILLY 6123 EAGLE LAKE TX XX8524 05/26'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0629'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 116.85,
    'O''REILLY 6123 EAGLE LAKE TX XX8524 05/26'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0629'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 11.25,
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/26'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0629'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 29.73,
    'BUC-EE''S #30 WHARTON TX 05/26'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0629'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 30.0,
    '7-ELEVEN HOUSTON TX XX8341 05/26'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0629'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 6.28,
    'BUC-EE''S #30 WHARTON TX 05/26'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0629'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 19.43,
    'TAQUERIA AZTECA D.F EAGLE LAKE TX 05/26'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0630', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-26',
    'Invoice',
    '1064',
    'Operation Orange LLC',
    'Invoice - 2025-05-26'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0630'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    1,
    57916.27, 0,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0631', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-26',
    'Payment',
    '1064',
    'Operation Orange LLC',
    'Paid via QuickBooks Payments: Payment ID 236134'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0631'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    2435.63, 0,
    'Paid via QuickBooks Payments: Payment ID 236134'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0631'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    2435.63, 0,
    'Paid via QuickBooks Payments: Payment ID 220260'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0632', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-27',
    'Deposit',
    '1064',
    'Operation Orange LLC',
    'System-recorded deposit for QuickBooks Payments'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0632'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    4871.26, 0,
    'System-recorded deposit for QuickBooks Payments'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0633', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-27',
    'Expense',
    '1064',
    'QuickBooks Payments',
    'System-recorded fee for QuickBooks Payments. Fee-name: DiscountRateFee, fee-type: Daily.'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0633'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 136.4,
    'System-recorded fee for QuickBooks Payments. Fee-name: DiscountRateFee, fee-type: Daily.'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0633'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 100.71,
    'SAN DONG NOODLE HOUSE HOUSTON TX 05/27'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0633'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 20.57,
    'HOMEDEPOT.COM XXX-XXX-3376 GA 05/27'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0633'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 119.06,
    'HOMEDEPOT.COM XXX-XXX-3376 GA 05/27'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0633'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 129.38,
    'MINT MOBILE XXX-XXX-7392 CA 05/27'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0634', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-27',
    'Payment',
    '1064',
    'Flober LLC',
    'Payment - 2025-05-27'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0634'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    15172.98, 0,
    ''
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0634'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    2580.0, 0,
    ''
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0634'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    1542.5, 0,
    ''
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0634'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    2848.75, 0,
    ''
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0634'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    2132.5, 0,
    ''
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0634'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    1526.25, 0,
    ''
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0634'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    7,
    2850.0, 0,
    ''
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0634'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    8,
    1598.75, 0,
    ''
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0634'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    9,
    2985.0, 0,
    ''
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0634'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    10,
    1967.5, 0,
    ''
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0634'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    11,
    2572.35, 0,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0635', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-28',
    'Expense',
    '1064',
    NULL,
    '7-ELEVEN HOUSTON TX XX1776 05/28'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0635'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 30.0,
    '7-ELEVEN HOUSTON TX XX1776 05/28'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0635'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 3280.67,
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250528 CO ENTRY DESCR:NET XX0973SEC:CCD TRACE#:XXXXXXXX2000526 EED:250528 IND ID:6 semk4mpaud IND NAME:10NetZero, Inc. 6semjng2p0t TRN: XXXXXX0526 TC'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0635'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 1204.73,
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250528 CO ENTRY DESCR:TAX XX3247SEC:CCD TRACE#:XXXXXXXX2002593 EED:250528 IND ID:6 semk4mpaue IND NAME:10NetZero, Inc. 6semjng2hff TRN: XXXXXX2593 TC'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0635'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 95.84,
    'APIFY* INV#XXXXXXX9014 PRAGUE 05/29'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0636', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-29',
    'Deposit',
    '1064',
    NULL,
    'THE HOME DEPOT #0577 HOUSTON TX 05/29'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0636'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    37.42, 0,
    'THE HOME DEPOT #0577 HOUSTON TX 05/29'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0637', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-29',
    'Expense',
    '1064',
    'Zaxby''s',
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/29'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0637'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 12.5,
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/29'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0637'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 20.0,
    'BUC-EE''S 24 XXX-XXX-6390 TX 05/29'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0637'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 12.73,
    'RAISING CANES 0103 HOUSTON TX 05/29'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0637'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 7.41,
    'PRASEK''S HILLJE SMOKEH SEALY TX XX0013 05/29'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0637'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 3280.67,
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250529 CO ENTRY DESCR:NET XX7924SEC:CCD TRACE#:XXXXXXXX7201963 EED:250529 IND ID:6 semk4mpavf IND NAME:10NetZero, Inc. 6semjng4gkk TRN: XXXXXX1963 TC'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0637'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 1204.73,
    'ORIG CO NAME:GUSTO ORIG ID:XXXXXX4001 DESC DATE:250529 CO ENTRY DESCR:TAX XX5272SEC:CCD TRACE#:XXXXXXXX7208487 EED:250529 IND ID:6 semk4mpavg IND NAME:10NetZero, Inc. 6semjng3qgo TRN: XXXXXX8487 TC'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0637'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    7,
    0, 150.0,
    'THE HOME DEPOT #0577 HOUSTON TX 05/29'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0637'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    8,
    0, 204.48,
    'THE HOME DEPOT #0577 HOUSTON TX XX7957 05/29'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0637'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    9,
    0, 69.89,
    'APPLE LUMBER BRANCH 40 EAGLE LAKE TX XX1019 05/29'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0638', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-05-30',
    'Expense',
    '1064',
    NULL,
    '7-ELEVEN HOUSTON TX XX5182 05/30'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0638'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 30.0,
    '7-ELEVEN HOUSTON TX XX5182 05/30'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0639', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-06-01',
    'Expense',
    '1064',
    NULL,
    'REPLIT, INC. REPLIT.COM CA 06/01'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0639'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 40.0,
    'REPLIT, INC. REPLIT.COM CA 06/01'
);

