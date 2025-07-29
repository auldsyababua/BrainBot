-- Journal Entries Final Batch 5

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0080', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-12-31',
    'Journal Entry',
    'DH14',
    NULL,
    '6% annum on $12,912.50 Loan from S. Bryan Aulds II'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0080'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    1,
    0, 774.75,
    '6% annum on $12,912.50 Loan from S. Bryan Aulds II'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0081', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-12-31',
    'Journal Entry',
    'DH18',
    NULL,
    '6% annum on $12,912.50 Loan from Colin Aulds'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0081'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    1,
    0, 4563.52,
    '6% annum on $12,912.50 Loan from Colin Aulds'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0082', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-12-31',
    'Journal Entry',
    'DH22',
    NULL,
    'Journal Entry - 2022-12-31'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0082'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    1,
    0, 2452.46,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0083', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-12-31',
    'Journal Entry',
    'DH29',
    NULL,
    'Shwan Leary $100K - 5.46% annum'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0083'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    1,
    0, 5457.21,
    'Shwan Leary $100K - 5.46% annum'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0084', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-12-31',
    'Journal Entry',
    'DH33',
    NULL,
    'Scott Aulds Sr Loan $100,000 - Interest accrual on 5.54% annum'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0084'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    1,
    0, 5535.45,
    'Scott Aulds Sr Loan $100,000 - Interest accrual on 5.54% annum'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0085', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-12-31',
    'Journal Entry',
    'DH37',
    NULL,
    'To record 2022 Depreciation expense'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0085'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-8000'),
    1,
    55867.0, 0,
    'To record 2022 Depreciation expense'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0086', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-01-03',
    'Expense',
    'DH37',
    'Brightline',
    'Chase ACH Payments Monthly Fee'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0086'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 25.0,
    'Chase ACH Payments Monthly Fee'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0086'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 285.0,
    'Orig CO Name:Brlght Line Busl Orig ID:9215986202 Deso Date:230102 CO Entry Descr:8ale Sec:CCD Trace/l:021000020986856 Eed:230103 Ind ID: Ind Name:10Netzero Inc Trn: 0030986856Tc'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0086'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 115.84,
    'Orig CO Name:Att Orig 10·9864031004 Desc Date·123022 CO Entry Descr:Payment Sec:PPD Trace#.031100206666250 Eed 230103 Ind ID: Ind Name:Joel Futtord Trn: 0036666250Tc'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0087', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-01-09',
    'Deposit',
    'DH37',
    NULL,
    'Orig CO Name:Google Orig ID:F770493581 Deso Date: CO Entry $0.22
Descr.Payment Sec:CCD Trace#:091000015785898 Eed:230109 Ind ID:US003Somv0 Ind Name:Joel Fulford
013023996 Credit Trn: 0095785898Tc'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0087'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0.22, 0,
    'Orig CO Name:Google Orig ID:F770493581 Deso Date: CO Entry $0.22
Descr.Payment Sec:CCD Trace#:091000015785898 Eed:230109 Ind ID:US003Somv0 Ind Name:Joel Fulford
013023996 Credit Trn: 0095785898Tc'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0088', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-01-09',
    'Expense',
    'DH37',
    NULL,
    'Orig CO Name:Google Orig ID:F770493581 Deso Date: CO Entry Descr:Apps_Commesec:CCD Tracell:091000014070852 Eed:230109 Ind ID:US003Sht3K Ind Name:Joel Futtord 013024945 Debit Tm: 0094070852Tc'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0088'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 115.53,
    'Orig CO Name:Google Orig ID:F770493581 Deso Date: CO Entry Descr:Apps_Commesec:CCD Tracell:091000014070852 Eed:230109 Ind ID:US003Sht3K Ind Name:Joel Futtord 013024945 Debit Tm: 0094070852Tc'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0088'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 0.22,
    'Orig CO Name:Google Orig ID:F770493581 Deso Date: CO Entry Descr:Payment Sec:CCD Trace#:091000015747015 Eed:230109 Ind ID:US003Sh365 Ind Name:Joel Futtord 013024153 Debit Tm: 0095747015Tc'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0089', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-01-31',
    'Expense',
    'DH37',
    'AT&T',
    'Orig CO Name:Att Orig ID:9864031004 Desc Date:013023 CO Entry Descr:Payment Sec:PPD Traceil:031100204926183 Eed:230131 Ind ID: Ind Name:Joel Futtord Trn: 0314926183Tc'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0089'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 115.84,
    'Orig CO Name:Att Orig ID:9864031004 Desc Date:013023 CO Entry Descr:Payment Sec:PPD Traceil:031100204926183 Eed:230131 Ind ID: Ind Name:Joel Futtord Trn: 0314926183Tc'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0090', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-02-01',
    'Expense',
    'DH37',
    NULL,
    'Chase ACH Payments Monthly Fee'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0090'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 25.0,
    'Chase ACH Payments Monthly Fee'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0091', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-02-02',
    'Expense',
    'DH37',
    'Brightline',
    'Orig CO Name:Bright Line Busi Orig ID:9215986202 Desc Date:230202 CO Entry Descr:Sale Sec:CCD Trace#:021000021201928 Eed:230202 Ind ID: Ind Name:10Netzero Inc Tm: 0331201928Tc'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0091'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 285.0,
    'Orig CO Name:Bright Line Busi Orig ID:9215986202 Desc Date:230202 CO Entry Descr:Sale Sec:CCD Trace#:021000021201928 Eed:230202 Ind ID: Ind Name:10Netzero Inc Tm: 0331201928Tc'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0092', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-02-06',
    'Expense',
    'DH37',
    NULL,
    'Orig CO Name:Gocgle Orig ID:F710493581 Desc Date: CO Entry Descr:Apps_Ccmmesec:CCD Trace#:091000010021448 Eed:230206 Ind ID:US003Suagu Ind Name:Joel Fulford 013065208 Debit Tm: 0370021448Tc'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0092'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 63.55,
    'Orig CO Name:Gocgle Orig ID:F710493581 Desc Date: CO Entry Descr:Apps_Ccmmesec:CCD Trace#:091000010021448 Eed:230206 Ind ID:US003Suagu Ind Name:Joel Fulford 013065208 Debit Tm: 0370021448Tc'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0093', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-02-22',
    'Journal Entry',
    '9',
    NULL,
    'Hushhut #2 and M30 Miners'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0093'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1420'),
    1,
    72333.76, 0,
    'Hushhut #2 and M30 Miners'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0094', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-02-28',
    'Expense',
    '9',
    'AT&T',
    'Orig CO Name:Att Orig ID:9864031004 Deso Dale:022723 CO Entry Descr:Payment Sec:PPD Trace#:031100200667215 Eed:230228 Ind ID: Ind Name:Joel Futtord Trn: 0590667215Tc'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0094'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 115.84,
    'Orig CO Name:Att Orig ID:9864031004 Deso Dale:022723 CO Entry Descr:Payment Sec:PPD Trace#:031100200667215 Eed:230228 Ind ID: Ind Name:Joel Futtord Trn: 0590667215Tc'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0094'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 40.0,
    'Online US Dollar Intl Wire Fee'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0094'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 10000.0,
    '02/28 Online International Wire Transfer NC: Canadian Imperial Bank of Commerce Toronto On M5L 1-A2 CA Ben:/7301535 Upstream Data Inc Ref:/Lmpd/Down Payment· 90Kw Hh Combo (IN Houston) Business Expenses Tm: 3512633059Es'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0095', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-03-01',
    'Expense',
    '9',
    NULL,
    'Chase ACH Payments Monthly Fee'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0095'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 25.0,
    'Chase ACH Payments Monthly Fee'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0096', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-03-02',
    'Expense',
    '9',
    NULL,
    'Orig CO Name:Brlght Line Busi Orig ID:9215986202 Deso Date:230302 CO Entry Descr:Sale Sec:CCD Trace#:021000025738122 Eed:230302 Ind ID: Ind Name:10Netzero Inc Trn: 06t5738122Tc'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0096'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 285.0,
    'Orig CO Name:Brlght Line Busi Orig ID:9215986202 Deso Date:230302 CO Entry Descr:Sale Sec:CCD Trace#:021000025738122 Eed:230302 Ind ID: Ind Name:10Netzero Inc Trn: 06t5738122Tc'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0097', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-03-06',
    'Expense',
    '9',
    NULL,
    'Orig CO Name:Google Orig ID:F77D493581 Deso Date: CO Entry Descr:Apps_Commesec:CCD Trace#:091000014422534 Eed:230306 Ind ID:US003T eiz9 Ind Name:Joel Fultord 013109912 Debit Trn: 0654422534Tc'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0097'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 101.54,
    'Orig CO Name:Google Orig ID:F77D493581 Deso Date: CO Entry Descr:Apps_Commesec:CCD Trace#:091000014422534 Eed:230306 Ind ID:US003T eiz9 Ind Name:Joel Fultord 013109912 Debit Trn: 0654422534Tc'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0098', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-03-30',
    'Expense',
    '9',
    NULL,
    'Counter Check'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0098'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 6.0,
    'Counter Check'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0098'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 6.0,
    'Counter Check'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0099', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-03-31',
    'Expense',
    '9',
    NULL,
    'Orig CO Name AU Orig ID:9864031004 Desc Date:033023 CO Entry Descr:Payrnent Sec:PPD Traceil:031100207614216 Eed:230331 Ind ID: Ind Name:Joel Fulford Tm: 09D7614216Tc'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0099'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 115.84,
    'Orig CO Name AU Orig ID:9864031004 Desc Date:033023 CO Entry Descr:Payrnent Sec:PPD Traceil:031100207614216 Eed:230331 Ind ID: Ind Name:Joel Fulford Tm: 09D7614216Tc'
);

