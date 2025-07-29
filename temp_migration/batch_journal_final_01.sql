-- Journal Entries Final Batch 1

INSERT INTO public.journal_entries-- Insert Journal Entries

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0001', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-08-02',
    'Journal Entry',
    '7',
    NULL,
    'Miners for first HashHut'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0001'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1410'),
    1,
    80320.0, 0,
    'Miners for first HashHut'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0002', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-08-02',
    'Journal Entry',
    '8',
    NULL,
    'Miners for HashHut'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0002'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1410'),
    1,
    51792.48, 0,
    'Miners for HashHut'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0003', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-09-30',
    'Deposit',
    '8',
    'Scott Aulds',
    'Book Transfer Credit BiO: Scott Aulds Cathy Aulds Richmond TX 77406 US Tm:'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0003'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    100000.0, 0,
    'Book Transfer Credit BiO: Scott Aulds Cathy Aulds Richmond TX 77406 US Tm:'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0004', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-10-04',
    'Expense',
    '8',
    'Upstream Data',
    'Online US Dollar Inti Wire Fee'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0004'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 40.0,
    'Online US Dollar Inti Wire Fee'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0004'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 1060.71,
    'Orig CO Name:Ctcorporation Orig ID:0000445668 Deso Dale:211004 CO Entry Descr:Legalserv Sec:Tel Trace#:021000025625203 Eed:211004 Ind ID:3211955 Ind Name:Joel *Fulford'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0004'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 2346.99,
    'Orig CO Name:Ctcorporation Orig ID:0000445668 Deso Dale:211004 CO Entry Descr:Legalserv Sec:Tel Trace#:021000025625202 Eed:211004 Ind ID:3211954 Ind Name:Joel *Fulford'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0004'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 29557.65,
    '10/04 Online International Wire Transfer Via: Bank of America, N.A./0959 A/C: The Toronto
Dominion Bank Toronto 1, Canada Ben: Upstream Data Inc Lloydminster Ab T9V2X1 CA Ref: Invoice Payment Ssh: 0273321 Tm: 3051981277Es'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0005', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-10-05',
    'Expense',
    '8',
    'Joel Fulford',
    '10/04 Basic Online Payroll Payment 5305277363 To ####0870 Joel Refund'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0005'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 12912.5,
    '10/04 Basic Online Payroll Payment 5305277363 To ####0870 Joel Refund'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0006', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-10-29',
    'Deposit',
    '8',
    'Shawn Leary',
    'Book Transfer Credit B/O: Shawn M Leary OR Jilllan Marie Saint Johns FL 32269-7370 US'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0006'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    100000.0, 0,
    'Book Transfer Credit B/O: Shawn M Leary OR Jilllan Marie Saint Johns FL 32269-7370 US'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0007', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-11-08',
    'Expense',
    '8',
    'Joel Fulford',
    '11/05 Basic Online Payroll Payment 5309630262 To ####0870 loan to Joel'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0007'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 5688.58,
    '11/05 Basic Online Payroll Payment 5309630262 To ####0870 loan to Joel'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0008', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-11-10',
    'Expense',
    '8',
    NULL,
    'Expense - 2021-11-10'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0008'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 6.0,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0009', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-12-01',
    'Expense',
    '8',
    'AT&T',
    'Chase ACH Payments Monthly Fee'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0009'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 25.0,
    'Chase ACH Payments Monthly Fee'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0009'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 186.65,
    'Orig CO Name:Att Orig ID 9864031004 Dase Date 112921 CO Entry Descr:Payment Sec:PPD Trace#·031100205265153 Ee<J-211201 Ind ID:'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0010', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-12-08',
    'Expense',
    '8',
    'Joel Fulford',
    '12/07 Basic Online Payroll Payment 5313589784 To Loan to Joel Fulford'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0010'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 4500.0,
    '12/07 Basic Online Payroll Payment 5313589784 To Loan to Joel Fulford'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0011', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-12-09',
    'Expense',
    '8',
    'United Oilfield Services',
    'Check No. 8413 - Pay to The Order Of: United Oilfield Services, Inc'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0011'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 5875.0,
    'Check No. 8413 - Pay to The Order Of: United Oilfield Services, Inc'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0011'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 787.55,
    'Check No. 9758 - Pay to The Order Of: United Oilfield Services, Inc'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0012', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-12-10',
    'Expense',
    '8',
    NULL,
    '12/10 Online Domestic Wire Transfer Via: Central Hous/113001077 A/C: Tric Resources Houston TX 77024 US Ref: October -21 Form 10Netzero, Inc lmad: 1210B1Qgc06C017447 
Tm: 3417771344Es'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0012'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 1897.2,
    '12/10 Online Domestic Wire Transfer Via: Central Hous/113001077 A/C: Tric Resources Houston TX 77024 US Ref: October -21 Form 10Netzero, Inc lmad: 1210B1Qgc06C017447 
Tm: 3417771344Es'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0012'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 25.0,
    'Online Domestic Wire Fee'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0013', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-12-13',
    'Expense',
    '8',
    'To Advanced Crypto services',
    'Check No. 9759 - Pay to The Order Of: W&W Consultant Services Inc.'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0013'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 3749.0,
    'Check No. 9759 - Pay to The Order Of: W&W Consultant Services Inc.'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0013'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 2701.25,
    'Check No. 9760 - Pay to The Order Of: Mathew L. Benson, P.C.'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0013'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 10800.0,
    'Orig CO Name:Advanced Crypto Orig ID.0000335892 Desc Date 211213 CO Entry Descr:8554693729Sec:Web Trace#:021000025980127 Eed:211213 Ind ID 3686170 
Ind Name:Joel ''Fulford'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0014', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-12-28',
    'Expense',
    '8',
    'Joel Fulford',
    '12/27 Basic Online Payroll Payment 5316257389 To Loan to Joel Fulford'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0014'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 2568.17,
    '12/27 Basic Online Payroll Payment 5316257389 To Loan to Joel Fulford'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0014'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 5096.09,
    '12/27 Basic Online Payroll Payment 5316270420 To ####0870 Loan to Joel Fulford'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0015', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-12-31',
    'Journal Entry',
    'DH13',
    NULL,
    '6% annum on $12,912.50 Loan from S. Bryan Aulds II'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0015'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    1,
    0, 407.54,
    '6% annum on $12,912.50 Loan from S. Bryan Aulds II'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0016', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-12-31',
    'Journal Entry',
    'DH17',
    NULL,
    '6% annum on $12,912.50 Loan from Colin Aulds'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0016'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    1,
    0, 2400.53,
    '6% annum on $12,912.50 Loan from Colin Aulds'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0017', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-12-31',
    'Journal Entry',
    'DH23',
    NULL,
    'Journal Entry - 2021-12-31'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0017'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    1,
    0, 4662.22,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0018', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-12-31',
    'Journal Entry',
    'DH27',
    NULL,
    'Shwan Leary $100K - 5.46% annum'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0018'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    1,
    0, 2870.64,
    'Shwan Leary $100K - 5.46% annum'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0019', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-12-31',
    'Journal Entry',
    'DH32',
    NULL,
    'Scott Aulds Sr Loan $100,000 - Interest accrual on 5.54% annum'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0019'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    1,
    0, 2911.8,
    'Scott Aulds Sr Loan $100,000 - Interest accrual on 5.54% annum'
);

