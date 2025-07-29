-- Journal Entries Final Batch 8

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0140', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-04',
    'Expense',
    '3',
    NULL,
    'S M HERSCHAP ORANGE GROVE TX                 12/01'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0140'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 91.96,
    'S M HERSCHAP ORANGE GROVE TX                 12/01'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0141', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-05',
    'Expense',
    '3',
    'Circle K',
    'ORIG CO NAME:ROLLO INSURANCE        ORIG ID:8263863381 DESC DATE:       CO ENTRY DESCR:J1996 OOFFSEC:CCD    TRACE#:111000028580367 EED:231205   IND ID:CZ10000584DAC                IND NAME:10NET ZERO INC.            TRN*1*CZ10000584DACRMR*IK*2D4865EB  CF27 42BD 8DEF B3C95B TRN: 3398580367TC'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0141'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 1555.28,
    'ORIG CO NAME:ROLLO INSURANCE        ORIG ID:8263863381 DESC DATE:       CO ENTRY DESCR:J1996 OOFFSEC:CCD    TRACE#:111000028580367 EED:231205   IND ID:CZ10000584DAC                IND NAME:10NET ZERO INC.            TRN*1*CZ10000584DACRMR*IK*2D4865EB  CF27 42BD 8DEF B3C95B TRN: 3398580367TC'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0141'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 34.01,
    'CIRCLE K # 06983 10537 MATHIS TX             12/05'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0141'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 42.0,
    'BREAKTIME HOUSTON TX                         12/05'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0142', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-07',
    'Expense',
    '3',
    NULL,
    'Alamo Lumber Company M Mathis TX     255758  12/07'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0142'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 11.34,
    'Alamo Lumber Company M Mathis TX     255758  12/07'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0142'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 33.0,
    'BREAKTIME HOUSTON TX                         12/07'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0143', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-09',
    'Journal Entry',
    'DH11',
    NULL,
    'Acari Resources Generator Purchase'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0143'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2000'),
    1,
    0, 232500.0,
    'Acari Resources Generator Purchase'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0144', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-11',
    'Expense',
    'DH11',
    'Circle K',
    'STAR STOP 127 10231 CL HOUSTON TX    129164  12/11'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0144'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 42.57,
    'STAR STOP 127 10231 CL HOUSTON TX    129164  12/11'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0144'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 32.96,
    'CIRCLE K # 06979 REFUGIO TX                  12/07'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0144'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 44.31,
    'PANTRY STORE G UP BEEVILLE TX        388400  12/11'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0144'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 30.81,
    'AGI*TMO SERVICE FEE 866-866-6285 PA          12/09'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0145', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-12',
    'Expense',
    'DH11',
    NULL,
    'S M HERSCHAP ORANGE GROVE TX                 12/11'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0145'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 120.84,
    'S M HERSCHAP ORANGE GROVE TX                 12/11'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0146', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-13',
    'Expense',
    'DH11',
    NULL,
    'FESCO LTD 3616617000X15 TX                   12/12'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0146'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 66.95,
    'FESCO LTD 3616617000X15 TX                   12/12'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0147', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-21',
    'Expense',
    'DH11',
    'Shell',
    'SHELL OIL 10003969002 FULSHEAR TX            12/20'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0147'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 39.38,
    'SHELL OIL 10003969002 FULSHEAR TX            12/20'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0148', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-28',
    'Deposit',
    'DH11',
    'Zapata II, LLC',
    'Online Transfer from CHK ...5317 transaction#: 19418685359'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0148'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    1165000.0, 0,
    'Online Transfer from CHK ...5317 transaction#: 19418685359'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0149', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-29',
    'Journal Entry',
    '6',
    NULL,
    'Journal Entry - 2023-12-29'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0149'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1410'),
    1,
    12912.5, 0,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0150', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-29',
    'Deposit',
    'DH11',
    'Operation Orange LLC',
    'FEDWIRE CREDIT VIA: GUARANTY BANK & TRUST, N.A./111915327 B/O: OPERATION ORANGE LLC FORT WORTH TEXAS 76109 REF: CHASE NYC/CTR/BNF=10NETZERO, INC. HOUSTON TX 77080-1526 US/AC-00000000 5231 RFB=O/B GUARANTY BK& IMAD: 1229GMQFMP01037690 TRN: 1304351363FF'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0150'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    250000.0, 0,
    'FEDWIRE CREDIT VIA: GUARANTY BANK & TRUST, N.A./111915327 B/O: OPERATION ORANGE LLC FORT WORTH TEXAS 76109 REF: CHASE NYC/CTR/BNF=10NETZERO, INC. HOUSTON TX 77080-1526 US/AC-00000000 5231 RFB=O/B GUARANTY BK& IMAD: 1229GMQFMP01037690 TRN: 1304351363FF'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0151', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-29',
    'Expense',
    'DH11',
    'HeatCore Inc',
    'DOMESTIC WIRE FEE'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0151'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 35.0,
    'DOMESTIC WIRE FEE'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0151'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 15.0,
    'DOMESTIC INCOMING WIRE FEE'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0151'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 361233.27,
    'DOMESTIC WIRE TRANSFER A/C: HEATCORE INC FRISCO TX 75035-9485 US REF: INVOICE 2312252 TRN: 3889343363ES 12/29

Transfer of Heatcore Containers to Zapata II'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0152', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-31',
    'Journal Entry',
    'DH15',
    NULL,
    '6% annum on $12,912.50 Loan from S. Bryan Aulds II'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0152'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    1,
    0, 774.75,
    '6% annum on $12,912.50 Loan from S. Bryan Aulds II'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0153', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-31',
    'Journal Entry',
    'DH19',
    NULL,
    '6% annum on $12,912.50 Loan from Colin Aulds'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0153'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    1,
    0, 4563.52,
    '6% annum on $12,912.50 Loan from Colin Aulds'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0154', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-31',
    'Journal Entry',
    'DH24',
    NULL,
    'Journal Entry - 2023-12-31'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0154'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    1,
    0, 4662.22,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0155', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-31',
    'Journal Entry',
    'DH28',
    NULL,
    'Shwan Leary $100K - 5.46% annum'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0155'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    1,
    0, 5457.21,
    'Shwan Leary $100K - 5.46% annum'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0156', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-31',
    'Journal Entry',
    'DH34',
    NULL,
    'Scott Aulds Sr Loan $100,000 - Interest accrual on 5.54% annum'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0156'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    1,
    0, 5535.45,
    'Scott Aulds Sr Loan $100,000 - Interest accrual on 5.54% annum'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0157', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-31',
    'Journal Entry',
    'DH5',
    NULL,
    'To record 2023 current year depreciation expense for Hashhut#1 and Hashhut#2'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0157'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-8000'),
    1,
    52570.0, 0,
    'To record 2023 current year depreciation expense for Hashhut#1 and Hashhut#2'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0158', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-12-31',
    'Journal Entry',
    'DH7 - Common Stock',
    NULL,
    'To record additional purchase of common stocks'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0158'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-3110'),
    1,
    0, 53.0,
    'To record additional purchase of common stocks'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0159', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-01-01',
    'Journal Entry',
    '10',
    NULL,
    'Scarborough money to house Andrew''s miners'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0159'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-6400'),
    1,
    5000.0, 0,
    'Scarborough money to house Andrew''s miners'
);

