-- Journal Entries Final Batch 20

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0380', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-10-17',
    'Expense',
    '1003',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX2852 10/17'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0380'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 15.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX2852 10/17'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0380'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 1440.0,
    'Online Payment XXXXXXX1772 To BOC LOGISTICS LLC 10/17'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0380'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 1020.0,
    'Online Payment XXXXXXX5121 To BOC LOGISTICS LLC 10/17'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0380'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 23.79,
    'TARGET T-1904 TOMBALL TX XX5238 10/17'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0380'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 80.0,
    'THECOMMONDESK WWW.THECOMMON TX 10/17'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0381', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-10-18',
    'Expense',
    '1003',
    NULL,
    'Zelle payment to Joel Fulford JPM99apltaae'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0381'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 353.09,
    'Zelle payment to Joel Fulford JPM99apltaae'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0381'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 671.07,
    'WWW.REVEALCELLCAM.CO WWW.REVEALCEL MN 10/18'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0382', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-10-21',
    'Expense',
    '1003',
    'Walmart',
    'WAL-MART #4512 KATY TX XX1300 10/21'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0382'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 45.12,
    'WAL-MART #4512 KATY TX XX1300 10/21'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0383', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-10-23',
    'Expense',
    '1003',
    NULL,
    'TST*SMOLIKS SMOKEHOUSE Mathis TX 10/23'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0383'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 57.6,
    'TST*SMOLIKS SMOKEHOUSE Mathis TX 10/23'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0383'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 42.34,
    'H-E-B GAS #234 REFUGIO TX XX0232 10/23'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0383'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 117.33,
    'TACTACAM WWW.REVEALCEL MN 10/24'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0383'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 6.66,
    'TACTACAM WWW.REVEALCEL MN 10/23'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0383'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 117.34,
    'TACTACAM WWW.REVEALCEL MN 10/23'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0383'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 10.35,
    'ALAMO LUMBER COMPANY M MATHIS TX XX8061 10/23'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0384', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-10-28',
    'Expense',
    '1003',
    NULL,
    'Online Payment XXXXXXX5518 To Kebo Oil and Gas, INC 10/28'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0384'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 4793.0,
    'Online Payment XXXXXXX5518 To Kebo Oil and Gas, INC 10/28'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0385', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-10-31',
    'Journal Entry',
    'DH30',
    NULL,
    'Shwan Leary $100K - 5.46% annum'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0385'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    1,
    0, 4560.14,
    'Shwan Leary $100K - 5.46% annum'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0386', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-10-31',
    'Journal Entry',
    'DH35',
    NULL,
    'Scott Aulds Sr Loan $100,000 - Interest accrual on 5.45% annum'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0386'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    1,
    0, 4625.52,
    'Scott Aulds Sr Loan $100,000 - Interest accrual on 5.45% annum'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0387', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-01',
    'Journal Entry',
    'DH 6',
    NULL,
    'Convertible Note Converted to equity'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0387'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2520'),
    1,
    100000.0, 0,
    'Convertible Note Converted to equity'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0388', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-01',
    'Journal Entry',
    'DH12',
    NULL,
    'Convertible Note Converted to equity'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0388'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2530'),
    1,
    12912.5, 0,
    'Convertible Note Converted to equity'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0389', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-01',
    'Journal Entry',
    'DH16',
    NULL,
    '6% annum on $12,912.50 Loan from S. Bryan Aulds II'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0389'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    1,
    0, 651.64,
    '6% annum on $12,912.50 Loan from S. Bryan Aulds II'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0390', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-01',
    'Journal Entry',
    'DH20',
    NULL,
    '6% annum on $12,912.50 Loan from Colin Aulds'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0390'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    1,
    0, 3825.85,
    '6% annum on $12,912.50 Loan from Colin Aulds'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0391', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-01',
    'Journal Entry',
    'DH25',
    NULL,
    'Journal Entry - 2024-11-01'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0391'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    1,
    0, 3908.6,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0392', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-01',
    'Journal Entry',
    'DH26',
    NULL,
    'converted loan is converted to equity'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0392'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    1,
    15685.51, 0,
    'converted loan is converted to equity'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0393', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-01',
    'Journal Entry',
    'DH31',
    NULL,
    'Convertible Loan conversion'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0393'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2550'),
    1,
    100000.0, 0,
    'Convertible Loan conversion'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0394', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-01',
    'Journal Entry',
    'DH36',
    NULL,
    'Convertible Loan converted to equity'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0394'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2540'),
    1,
    100000.0, 0,
    'Convertible Loan converted to equity'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0395', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-04',
    'Expense',
    'DH36',
    'AT&T',
    'AT&T BILL PAYMENT XXX-XXX-0500 TX 11/05'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0395'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 500.0,
    'AT&T BILL PAYMENT XXX-XXX-0500 TX 11/05'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0396', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-05',
    'Expense',
    'DH36',
    NULL,
    'SERVICE CHARGES FOR THE MONTH OF OCTOBER'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0396'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 42.5,
    'SERVICE CHARGES FOR THE MONTH OF OCTOBER'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0397', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-06',
    'Invoice',
    '1004',
    'WasteWatt Ventures LLC',
    'Invoice - 2024-11-06'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0397'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    1,
    1616.6, 0,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0398', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-06',
    'Expense',
    '1005',
    NULL,
    'HUNT ROAD PIT STOP EXP BROOKSHIRE TX XX9571 11/06'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0398'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 68.34,
    'HUNT ROAD PIT STOP EXP BROOKSHIRE TX XX9571 11/06'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0399', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-06',
    'Invoice',
    '1005',
    'WasteWatt Ventures LLC',
    'Invoice - 2024-11-06'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0399'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    1,
    1210.52, 0,
    ''
);

