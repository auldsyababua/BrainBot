-- Journal Entries Batch 1

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0001', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-08-02',
    'Journal Entry',
    'Miners for first HashHut',
    80320.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000001', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0001'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1410'),
    'Miners for first HashHut',
    80320.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0002', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-08-02',
    'Journal Entry',
    'Miners for HashHut',
    51792.48, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000002', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0002'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1410'),
    'Miners for HashHut',
    51792.48, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0003', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-09-30',
    'Deposit',
    'Book Transfer Credit BiO: Scott Aulds Cathy Aulds Richmond TX 77406 US Tm:',
    100000.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000003', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0003'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Book Transfer Credit BiO: Scott Aulds Cathy Aulds Richmond TX 77406 US Tm:',
    100000.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0004', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-10-04',
    'Expense',
    'Online US Dollar Inti Wire Fee',
    0.0, 33005.35, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000004', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0004'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online US Dollar Inti Wire Fee',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000005', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0004'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Ctcorporation Orig ID:0000445668 Deso Dale:211004 CO Entry Descr:Legalserv Sec:Tel Trace#:021000025625203 Eed:211004 Ind ID:3211955 Ind Name:Joel *Fulford',
    1060.71, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000006', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0004'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Ctcorporation Orig ID:0000445668 Deso Dale:211004 CO Entry Descr:Legalserv Sec:Tel Trace#:021000025625202 Eed:211004 Ind ID:3211954 Ind Name:Joel *Fulford',
    2346.99, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000007', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0004'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '10/04 Online International Wire Transfer Via: Bank of America, N.A./0959 A/C: The Toronto
Dominion Bank Toronto 1, Canada Ben: Upstream Data Inc Lloydminster Ab T9V2X1 CA Ref: Invoice Payment Ssh: 0273321 Tm: 3051981277Es',
    29557.65, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0005', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-10-05',
    'Expense',
    '10/04 Basic Online Payroll Payment 5305277363 To ####0870 Joel Refund',
    0.0, 12912.5, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000008', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0005'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '10/04 Basic Online Payroll Payment 5305277363 To ####0870 Joel Refund',
    12912.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0006', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-10-29',
    'Deposit',
    'Book Transfer Credit B/O: Shawn M Leary OR Jilllan Marie Saint Johns FL 32269-7370 US',
    100000.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000009', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0006'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Book Transfer Credit B/O: Shawn M Leary OR Jilllan Marie Saint Johns FL 32269-7370 US',
    100000.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0007', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-11-08',
    'Expense',
    '11/05 Basic Online Payroll Payment 5309630262 To ####0870 loan to Joel',
    0.0, 5688.58, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000010', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0007'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '11/05 Basic Online Payroll Payment 5309630262 To ####0870 loan to Joel',
    5688.58, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0008', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-11-10',
    'Expense',
    'Expense - 2021-11-10',
    0.0, 6.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000011', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0008'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    6.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0009', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-12-01',
    'Expense',
    'Chase ACH Payments Monthly Fee',
    0.0, 211.65, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000012', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0009'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Chase ACH Payments Monthly Fee',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000013', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0009'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Att Orig ID 9864031004 Dase Date 112921 CO Entry Descr:Payment Sec:PPD Trace#·031100205265153 Ee<J-211201 Ind ID:',
    186.65, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0010', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-12-08',
    'Expense',
    '12/07 Basic Online Payroll Payment 5313589784 To Loan to Joel Fulford',
    0.0, 4500.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000014', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0010'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '12/07 Basic Online Payroll Payment 5313589784 To Loan to Joel Fulford',
    4500.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0011', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-12-09',
    'Expense',
    'Check No. 8413 - Pay to The Order Of: United Oilfield Services, Inc',
    0.0, 6662.55, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000015', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0011'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Check No. 8413 - Pay to The Order Of: United Oilfield Services, Inc',
    5875.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000016', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0011'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Check No. 9758 - Pay to The Order Of: United Oilfield Services, Inc',
    787.55, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0012', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-12-10',
    'Expense',
    '12/10 Online Domestic Wire Transfer Via: Central Hous/113001077 A/C: Tric Resources Houston TX 77024 US Ref: October -21 Form 10Netzero, Inc lmad: 1210B1Qgc06C017447 
Tm: 3417771344Es',
    0.0, 1922.2, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000017', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0012'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '12/10 Online Domestic Wire Transfer Via: Central Hous/113001077 A/C: Tric Resources Houston TX 77024 US Ref: October -21 Form 10Netzero, Inc lmad: 1210B1Qgc06C017447 
Tm: 3417771344Es',
    1897.2, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000018', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0012'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Domestic Wire Fee',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0013', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-12-13',
    'Expense',
    'Check No. 9759 - Pay to The Order Of: W&W Consultant Services Inc.',
    0.0, 17250.25, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000019', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0013'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Check No. 9759 - Pay to The Order Of: W&W Consultant Services Inc.',
    3749.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000020', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0013'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Check No. 9760 - Pay to The Order Of: Mathew L. Benson, P.C.',
    2701.25, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000021', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0013'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Advanced Crypto Orig ID.0000335892 Desc Date 211213 CO Entry Descr:8554693729Sec:Web Trace#:021000025980127 Eed:211213 Ind ID 3686170 
Ind Name:Joel ''Fulford',
    10800.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0014', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-12-28',
    'Expense',
    '12/27 Basic Online Payroll Payment 5316257389 To Loan to Joel Fulford',
    0.0, 7664.26, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000022', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0014'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '12/27 Basic Online Payroll Payment 5316257389 To Loan to Joel Fulford',
    2568.17, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000023', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0014'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '12/27 Basic Online Payroll Payment 5316270420 To ####0870 Loan to Joel Fulford',
    5096.09, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0015', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-12-31',
    'Journal Entry',
    '6% annum on $12,912.50 Loan from S. Bryan Aulds II',
    0.0, 407.54, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000024', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0015'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    '6% annum on $12,912.50 Loan from S. Bryan Aulds II',
    407.54, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0016', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-12-31',
    'Journal Entry',
    '6% annum on $12,912.50 Loan from Colin Aulds',
    0.0, 2400.53, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000025', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0016'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    '6% annum on $12,912.50 Loan from Colin Aulds',
    2400.53, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0017', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-12-31',
    'Journal Entry',
    'Journal Entry - 2021-12-31',
    0.0, 4662.22, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000026', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0017'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    '',
    4662.22, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0018', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-12-31',
    'Journal Entry',
    'Shwan Leary $100K - 5.46% annum',
    0.0, 2870.64, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000027', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0018'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    'Shwan Leary $100K - 5.46% annum',
    2870.64, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0019', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-12-31',
    'Journal Entry',
    'Scott Aulds Sr Loan $100,000 - Interest accrual on 5.54% annum',
    0.0, 2911.8, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000028', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0019'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    'Scott Aulds Sr Loan $100,000 - Interest accrual on 5.54% annum',
    2911.8, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0020', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-12-31',
    'Journal Entry',
    'To record 2021 current year depreciation expense for Hashhut#1',
    34917.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000029', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0020'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-8000'),
    'To record 2021 current year depreciation expense for Hashhut#1',
    34917.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0021', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-12-31',
    'Journal Entry',
    'To record initial purchase of common stock',
    360.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000030', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0021'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2610'),
    'To record initial purchase of common stock',
    360.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0022', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-01-03',
    'Expense',
    '01/03 Online Domestic Wire Transfer Via: Central Hous/113001077 NC: Trio Resources Houston TX 77024 US Ref: October -21 !mad: 0103B1Qgc06C003446 Trn: 3164812003Es',
    0.0, 16632.91, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000031', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0022'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '01/03 Online Domestic Wire Transfer Via: Central Hous/113001077 NC: Trio Resources Houston TX 77024 US Ref: October -21 !mad: 0103B1Qgc06C003446 Trn: 3164812003Es',
    5492.08, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000032', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0022'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Domestic Wire Fee',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000033', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0022'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Att Orig ID:9864031004 Desc Dale:123021 CO Entry Descr:Payment Soo:PPD Trace#:031100202787423 Eed:220103 Ind ID: Ind Name:Joel Fulford Trn: 0032787423Tc',
    115.83, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000034', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0022'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '01/02 Online ACH Payment 5317058761 To Austinlawyers ( ####0096)',
    3500.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000035', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0022'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '01/02 Online ACH Payment 5317058824 To Austinlawyers ( ####0096)',
    7475.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000036', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0022'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Chase ACH Paymenls Monthly Fee',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0023', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-01-05',
    'Expense',
    '01/05 Withdrawal - Joel Fulford - Loan',
    0.0, 9000.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000037', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0023'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '01/05 Withdrawal - Joel Fulford - Loan',
    9000.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0024', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-01-06',
    'Expense',
    'Check No. 9761 - Pay to The Order Of: United Oilfield Services, Inc',
    0.0, 6054.23, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000038', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0024'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Check No. 9761 - Pay to The Order Of: United Oilfield Services, Inc',
    6054.23, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0025', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-01-18',
    'Expense',
    '01/16 Online ACH Payment 5318843176 To Advanced Crypto services',
    0.0, 6297.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000039', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0025'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '01/16 Online ACH Payment 5318843176 To Advanced Crypto services',
    6297.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0026', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-02-01',
    'Expense',
    'Chase ACH Payments Monthly Fee',
    0.0, 140.82999999999998, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000040', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0026'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Chase ACH Payments Monthly Fee',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000041', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0026'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Att Orig ID:9864031004 Desc Date:013022 CO Entry Descr:Payment Sec:PPD Traceil:031100206015826 Eed:220201 Ind ID: Ind Name:Joel Fulford Trn: 0326015826Tc',
    115.83, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0027', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-02-08',
    'Expense',
    '02/07 Basic Online Payroll Payment 5321551953 To ####0870 Loan to Joel Fulford',
    0.0, 1764.98, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000042', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0027'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '02/07 Basic Online Payroll Payment 5321551953 To ####0870 Loan to Joel Fulford',
    982.61, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000043', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0027'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '02/07 Basic Online Payroll Payment 5321551946 To ####0870 Loan to Joel Fulford',
    782.37, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0028', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-02-18',
    'Expense',
    '02/18 Online ACH Paymen15323178663 To Martinlg ( ######7156)',
    0.0, 5000.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000044', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0028'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '02/18 Online ACH Paymen15323178663 To Martinlg ( ######7156)',
    5000.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0029', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-02-22',
    'Expense',
    'Online Domestic Wire Fee',
    0.0, 4993.4, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000045', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0029'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Domestic Wire Fee',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000046', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0029'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '02/22 Online Domestic Wire Transfer Via: Central Hous/113001077 NC: Trio Resources Houston TX 77024 US lmad: 0222B1Qgc06C005863 Tm: 3294552053Es',
    4968.4, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0030', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-02-28',
    'Expense',
    'Orig CO Name:Bright Line Busi Orig ID:9215986202 Deso Date:220226 CO Entry Descr:Sale Sec:CCD Trace#:021000022279070 Eed:220228 Ind ID: 
Ind Name:10Netzero Inc Tm: 0592279070Tc',
    0.0, 285.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000047', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0030'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Bright Line Busi Orig ID:9215986202 Deso Date:220226 CO Entry Descr:Sale Sec:CCD Trace#:021000022279070 Eed:220228 Ind ID: 
Ind Name:10Netzero Inc Tm: 0592279070Tc',
    285.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0031', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-03-01',
    'Expense',
    'Chase ACH Payments Monthly Fee',
    0.0, 140.82999999999998, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000048', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0031'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Chase ACH Payments Monthly Fee',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000049', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0031'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Att Orig ID:9864031004 Dase Data:022722 CO Entry Descr:Payment Sec:PPD Trace#:0311002036054 t 4 Eed:220301 Ind ID: Ind Nam0:Jo0I Futtord Trn: 0603605414Tc',
    115.83, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0032', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-03-02',
    'Expense',
    'Check No. 9763 - Pay to The Order Of: United Oilfield Services, Inc',
    0.0, 12040.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000050', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0032'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Check No. 9763 - Pay to The Order Of: United Oilfield Services, Inc',
    725.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000051', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0032'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Check No. 9764 - Pay to The Order Of: United Oilfield Services, Inc',
    400.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000052', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0032'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Check No. 9762',
    3515.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000053', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0032'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Advanced Crypto Orig ID:0000335892 Deso Data:220302 CO Entry Descr:8554693729Sec:Web Traoa#:021000020713908 Eed:220302 Ind ID:2487473 
Ind Name:Joel ''Futtord',
    7400.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0033', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-03-08',
    'Expense',
    '03/08 Online ACH Payment 5325787543 To Oil ( #####7765)',
    0.0, 2736.25, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000054', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0033'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '03/08 Online ACH Payment 5325787543 To Oil ( #####7765)',
    2736.25, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0034', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-03-18',
    'Expense',
    'Orig CO Nama:Unchainad Capita Orig ID:814173373 Deso Date:Mar 18 CO Entry Desor:Conclerge Sec:CCD Traoe#:071005255855062 Eed:220318 Ind ID:COncierge Ind Nama:Joel Futtord Trn: 0775855062Tc',
    0.0, 2950.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000055', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0034'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Nama:Unchainad Capita Orig ID:814173373 Deso Date:Mar 18 CO Entry Desor:Conclerge Sec:CCD Traoe#:071005255855062 Eed:220318 Ind ID:COncierge Ind Nama:Joel Futtord Trn: 0775855062Tc',
    2950.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0035', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-03-29',
    'Expense',
    'Orig CO Nama:Bright Line Busi Orig ID:9215986202 Deso Data:220329 CO Entry Descr:Sale Sec:CCD Trace#:021000024455651 Eed:220329 Ind ID: 
Ind Name:10Netzaro Inc Trn: 0884455651Tc',
    0.0, 285.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000056', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0035'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Nama:Bright Line Busi Orig ID:9215986202 Deso Data:220329 CO Entry Descr:Sale Sec:CCD Trace#:021000024455651 Eed:220329 Ind ID: 
Ind Name:10Netzaro Inc Trn: 0884455651Tc',
    285.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0036', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-03-31',
    'Expense',
    'Orig CO Name:Att Orig ID:9864031004 Dase Date:033022 CO Entry Dascr:Paymen1 Sec:PPD Trace#:031100209284810 Ead:220331 Ind ID: Ind Nama:Joel Fulford Trn: 0909284810Tc',
    0.0, 115.83, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000057', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0036'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Att Orig ID:9864031004 Dase Date:033022 CO Entry Dascr:Paymen1 Sec:PPD Trace#:031100209284810 Ead:220331 Ind ID: Ind Nama:Joel Fulford Trn: 0909284810Tc',
    115.83, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0037', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-04-01',
    'Expense',
    'Expense - 2022-04-01',
    0.0, 25.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000058', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0037'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0038', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-04-16',
    'Deposit',
    'Deposti: 10 Net Zero (Colin Aulds - Loan) *7668578771',
    100000.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000059', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0038'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Deposti: 10 Net Zero (Colin Aulds - Loan) *7668578771',
    100000.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0039', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-04-20',
    'Expense',
    '04/20 Online Domestic Wire Transfer Via: Central Hous/113001077 A/C: Tric Resources Houston TX 77024 US Ref: January & February - 22 lmad: 0420B1Qgc05C001879 Tm: 303527211OEs',
    0.0, 9290.32, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000060', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0039'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '04/20 Online Domestic Wire Transfer Via: Central Hous/113001077 A/C: Tric Resources Houston TX 77024 US Ref: January & February - 22 lmad: 0420B1Qgc05C001879 Tm: 303527211OEs',
    9265.32, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000061', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0039'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0040', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-04-25',
    'Expense',
    '04/25 Online ACH Payment 5332437579 To United OFS { #####2100)',
    0.0, 1709.69, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000062', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0040'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '04/25 Online ACH Payment 5332437579 To United OFS { #####2100)',
    1709.69, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0041', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-04-28',
    'Expense',
    'Orig CO Name:Bright Line Busi Orig ID:9215986202 Deso Date:220428 CO Entry Descr:Sale Sec:CCD Trace#:021000026011550 Eed:220428 Ind ID: 
Ind Name:10Netzero Inc Tm: 1186011550Tc',
    0.0, 285.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000063', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0041'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Bright Line Busi Orig ID:9215986202 Deso Date:220428 CO Entry Descr:Sale Sec:CCD Trace#:021000026011550 Eed:220428 Ind ID: 
Ind Name:10Netzero Inc Tm: 1186011550Tc',
    285.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0042', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-05-02',
    'Expense',
    'Chase ACH Payments Monthly Fee',
    0.0, 140.84, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000064', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0042'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Chase ACH Payments Monthly Fee',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000065', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0042'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Att Orig ID:9864031004 Deso Date:043022 CO Entry Descr:Payment Sec:PPD Traoeil:031100200476508 Eed:220502 Ind ID: Ind Name:Joel FuHord Tm: 1220476508Tc',
    115.84, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0043', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-05-10',
    'Expense',
    '05/10 Online ACH Payment 5334795757 To Unchained ( #############7592)',
    0.0, 250.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000066', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0043'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '05/10 Online ACH Payment 5334795757 To Unchained ( #############7592)',
    250.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0044', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-05-16',
    'Expense',
    '05/16 Online ACH Payment 5335649287 To Warehouserack ( i/####111990)',
    0.0, 1542.56, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000067', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0044'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '05/16 Online ACH Payment 5335649287 To Warehouserack ( i/####111990)',
    1542.56, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0045', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-05-25',
    'Expense',
    'Online US Dollar Intl Wire Fee',
    0.0, 10040.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000068', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0045'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online US Dollar Intl Wire Fee',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000069', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0045'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '05/25 Online International Wire Transfer A/C: Canadian Imperial Bank of Commerce Toronlo On M5L 1-A2 CA Ben:/5008579 Maarschalk Valuations Inc Aef:/Lmpd/Services Rendered Consultancyexpenses Tm: 3457682145Es',
    10000.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0046', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-05-31',
    'Expense',
    'Orig CO Name:Att Orig ID:9864031004 Deso Date:053022 CO Entry Descr:Payment Sec:PPD Tracel/:031100202647727 Eed:220531 Ind ID: Ind Name:Joel Fultord Trn: 1512647727Tc',
    0.0, 400.84000000000003, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000070', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0046'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Att Orig ID:9864031004 Deso Date:053022 CO Entry Descr:Payment Sec:PPD Tracel/:031100202647727 Eed:220531 Ind ID: Ind Name:Joel Fultord Trn: 1512647727Tc',
    115.84, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000071', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0046'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '05/31 Orig CO Name:Bright Line Busi Orig ID:9215986202 Deso Dale:220529 CO Entry Descr:Sale Sec:CCD Traoe#:021000025292904 Eed:220531 Ind ID: Ind Name:10Netzero Inc Tm: 1515292904Tc',
    285.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0047', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-06-01',
    'Expense',
    'Chase ACH Payments Monthly Fee',
    0.0, 25.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000072', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0047'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Chase ACH Payments Monthly Fee',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0048', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-06-23',
    'Expense',
    '06/22 Basia Online Payroll Payment 5340786668 To ifffffl/0870 Loan to Joel Fulford',
    0.0, 3548.45, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000073', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0048'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '06/22 Basia Online Payroll Payment 5340786668 To ifffffl/0870 Loan to Joel Fulford',
    2960.14, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000074', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0048'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '06/22 Basic Online Payroll Payment 5340773000 To #111/#0870 Loan to Joel Fulford',
    588.31, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0049', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-06-24',
    'Expense',
    '06/23 Baslo Online Payroll Payment 5340880809 To #lt##0870 Loan to Joel Fulford',
    0.0, 2153.63, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000075', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0049'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '06/23 Baslo Online Payroll Payment 5340880809 To #lt##0870 Loan to Joel Fulford',
    2153.63, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0050', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-06-27',
    'Expense',
    'Online Domestic Wire Fee',
    0.0, 14712.49, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000076', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0050'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Domestic Wire Fee',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000077', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0050'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '06/27 Online Domestic Wire Transfer Via: Central Hous/113001077 A/C: Tri C Resources Houston TX 77024 US Ref: March-April, 2022 Gas Sales',
    8704.24, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000078', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0050'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '06/27 Online lntemational Wire Transfer A/0: Foreign Cur Bus Acct Bk 1 Columbus Newark De 197132107 US Org: 00000000766857871 10Netzoro, Inc. Ben:/0030112 Rwt Growth Inc Ref; Invoice 1229',
    5983.25, false
) ON CONFLICT (line_id_display) DO NOTHING;

