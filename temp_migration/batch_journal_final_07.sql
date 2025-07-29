-- Journal Entries Final Batch 7

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0120', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-08-24',
    'Expense',
    '3',
    'AT&T',
    'ATT*BILL PAYMENT 800-288-2020 TX             08/23'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0120'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 343.08,
    'ATT*BILL PAYMENT 800-288-2020 TX             08/23'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0120'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 240.46,
    'ATT*BILL PAYMENT 800-288-2020 TX             08/23'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0121', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-09-01',
    'Expense',
    '3',
    'ACARI RESOURCES LLC',
    'ONLINE DOMESTIC WIRE FEE'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0121'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 25.0,
    'ONLINE DOMESTIC WIRE FEE'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0121'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 27500.0,
    'ONLINE DOMESTIC WIRE TRANSFER VIA: PNCBANK PITT/043000096 A/C: ACARI RESOURCES LTD DALLAS TX 75225 US IMAD: 0901B1QGC08C032111 TRN: 3990393244ES 09/01

MWM Generator purchase - sold to Operation Orange'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0122', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-09-05',
    'Expense',
    '3',
    'ACARI RESOURCES LLC',
    'ONLINE DOMESTIC WIRE FEE'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0122'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 25.0,
    'ONLINE DOMESTIC WIRE FEE'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0122'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 50000.0,
    'ONLINE DOMESTIC WIRE TRANSFER VIA: PNCBANK PITT/043000096 A/C: ACARI RESOURCES LTD DALLAS TX 75225 US IMAD: 0905B1QGC01C013925 TRN: 3925283248ES 09/05

MWM Generator purchase - sold to Operation Orange'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0123', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-09-06',
    'Expense',
    '3',
    'Circle K',
    'CIRCLE K # 06983 10537 MATHIS TX             09/06'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0123'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 35.0,
    'CIRCLE K # 06983 10537 MATHIS TX             09/06'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0123'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 57.46,
    'STAR STOP 127 10231 CL HOUSTON TX    743069  09/06'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0124', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-09-07',
    'Deposit',
    '3',
    'Joel Fulford',
    'FEDWIRE CREDIT VIA: WELLS FARGO BANK, N.A./121000248 B/O: MACY FULFORD TX 77080 REF: CHASE NYC/CTR/BNF=10NETZERO, INC. HOUSTON TX 77080-1526 US/AC-00000000 5231 RFB=OW00003603562374 BBI=/CHGS/USD0,00/ IMAD: 0907I1B7032R020448 TRN: 1004230250FF'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0124'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    3535.79, 0,
    'FEDWIRE CREDIT VIA: WELLS FARGO BANK, N.A./121000248 B/O: MACY FULFORD TX 77080 REF: CHASE NYC/CTR/BNF=10NETZERO, INC. HOUSTON TX 77080-1526 US/AC-00000000 5231 RFB=OW00003603562374 BBI=/CHGS/USD0,00/ IMAD: 0907I1B7032R020448 TRN: 1004230250FF'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0125', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-09-07',
    'Expense',
    '3',
    NULL,
    'DOMESTIC INCOMING WIRE FEE'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0125'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 15.0,
    'DOMESTIC INCOMING WIRE FEE'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0126', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-09-11',
    'Expense',
    '3',
    'Home Depot',
    'THE HOME DEPOT #6525 HOUSTON TX      197308  09/11'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0126'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 44.12,
    'THE HOME DEPOT #6525 HOUSTON TX      197308  09/11'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0126'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 113.97,
    'WAL-MART #5460 PORTLAND TX                   09/11'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0127', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-09-14',
    'Expense',
    '3',
    'Harbor Freight Tools',
    'HARBOR FREIGHT TOOLS 5 HOUSTON TX            09/14'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0127'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 49.81,
    'HARBOR FREIGHT TOOLS 5 HOUSTON TX            09/14'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0127'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 277.12,
    'WAL-MART #2257 HOUSTON TX                    09/14'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0128', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-09-15',
    'Expense',
    '3',
    'Circle K',
    'CIRCLE K # 06979 217 N REFUGIO TX            09/15'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0128'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 50.02,
    'CIRCLE K # 06979 217 N REFUGIO TX            09/15'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0128'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 50.0,
    'STAR STOP 127 10231 CL HOUSTON TX    419391  09/15'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0128'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 12.32,
    'Wal-Mart Super Center PORTLAND TX            09/15'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0129', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-09-18',
    'Expense',
    '3',
    'Home Depot',
    'THE HOME DEPOT #6525 HOUSTON TX      604317  09/18'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0129'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 39.79,
    'THE HOME DEPOT #6525 HOUSTON TX      604317  09/18'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0130', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-09-22',
    'Expense',
    '3',
    'Circle K',
    'CIRCLE K # 06985 PORTLAND TX                 09/20'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0130'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 50.0,
    'CIRCLE K # 06985 PORTLAND TX                 09/20'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0130'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 50.0,
    'SPEEDY STOP 18 BEAUMONT TX                   09/22'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0131', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-10-12',
    'Deposit',
    '3',
    NULL,
    'DEPOSIT  ID NUMBER 731777'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0131'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    20.0, 0,
    'DEPOSIT  ID NUMBER 731777'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0132', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-10-17',
    'Expense',
    '3',
    '2W Services',
    'Online ACH Payment 11111604950 To 2WServices (_###4108)'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0132'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 3235.0,
    'Online ACH Payment 11111604950 To 2WServices (_###4108)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0133', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-11-01',
    'Deposit',
    '3',
    'Asics Miners US',
    'BOOK TRANSFER CREDIT B/O: ASIC MINERS US LLC ANDREW B GILTON LATHROP CA 95330 US TRN: 3740283305ES'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0133'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    19000.0, 0,
    'BOOK TRANSFER CREDIT B/O: ASIC MINERS US LLC ANDREW B GILTON LATHROP CA 95330 US TRN: 3740283305ES'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0133'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    1000.0, 0,
    'BOOK TRANSFER CREDIT B/O: ASIC MINERS US LLC ANDREW B GILTON LATHROP CA 95330 US TRN: 3710463305ES'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0134', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-11-01',
    'Expense',
    '3',
    '2W Services',
    'STANDARD ACH PMNTS INITIAL FEE'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0134'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 2.5,
    'STANDARD ACH PMNTS INITIAL FEE'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0134'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 7713.75,
    'Online ACH Payment 11113070562 To 2WServices (_###4108)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0135', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-11-13',
    'Expense',
    '3',
    'AT&T',
    'ATT*BILL PAYMENT 800-288-2020 TX             11/10'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0135'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 485.01,
    'ATT*BILL PAYMENT 800-288-2020 TX             11/10'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0136', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-11-27',
    'Expense',
    '3',
    'Petroleum Producing Services',
    'MURPHY7018ATWAL WHARTON TX                   11/27'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0136'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 52.0,
    'MURPHY7018ATWAL WHARTON TX                   11/27'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0136'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 1530.0,
    'Online ACH Payment 11115322057 To PPS (_######9165)'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0136'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 36.0,
    'BREAKTIME HOUSTON TX                         11/27'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0137', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-11-29',
    'Expense',
    '3',
    'Circle K',
    'CIRCLE K # 06983 10537 MATHIS TX             11/29'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0137'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 49.0,
    'CIRCLE K # 06983 10537 MATHIS TX             11/29'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0137'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 59.51,
    'Alamo Lumber Company M Mathis TX     531499  11/29'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0137'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 32.46,
    'Alamo Lumber Company M Mathis TX     900676  11/29'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0138', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-11-30',
    'Expense',
    '3',
    NULL,
    'NAPA MATHIS MATHIS TX                        11/29'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0138'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 7.57,
    'NAPA MATHIS MATHIS TX                        11/29'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0138'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 529.49,
    'TALBOTT PROPANE 361-5753872 TX               11/29'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0138'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 13.55,
    'FARM INDUSTRIAL VICTORIA TX                  11/29'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0139', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-01',
    'Expense',
    '3',
    'Circle K',
    'CIRCLE K # 06983 10537 MATHIS TX             12/01'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0139'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 40.01,
    'CIRCLE K # 06983 10537 MATHIS TX             12/01'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0139'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 5.0,
    'STANDARD ACH PMNTS INITIAL FEE QTY = 2'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0139'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 32.0,
    'BREAKTIME HOUSTON TX                         12/01'
);

