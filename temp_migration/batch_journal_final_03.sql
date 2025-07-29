-- Journal Entries Final Batch 3

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0040', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-04-25',
    'Expense',
    'DH32',
    NULL,
    '04/25 Online ACH Payment 5332437579 To United OFS { #####2100)'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0040'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 1709.69,
    '04/25 Online ACH Payment 5332437579 To United OFS { #####2100)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0041', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-04-28',
    'Expense',
    'DH32',
    'Brightline',
    'Orig CO Name:Bright Line Busi Orig ID:9215986202 Deso Date:220428 CO Entry Descr:Sale Sec:CCD Trace#:021000026011550 Eed:220428 Ind ID: 
Ind Name:10Netzero Inc Tm: 1186011550Tc'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0041'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 285.0,
    'Orig CO Name:Bright Line Busi Orig ID:9215986202 Deso Date:220428 CO Entry Descr:Sale Sec:CCD Trace#:021000026011550 Eed:220428 Ind ID: 
Ind Name:10Netzero Inc Tm: 1186011550Tc'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0042', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-05-02',
    'Expense',
    'DH32',
    'AT&T',
    'Chase ACH Payments Monthly Fee'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0042'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 25.0,
    'Chase ACH Payments Monthly Fee'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0042'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 115.84,
    'Orig CO Name:Att Orig ID:9864031004 Deso Date:043022 CO Entry Descr:Payment Sec:PPD Traoeil:031100200476508 Eed:220502 Ind ID: Ind Name:Joel FuHord Tm: 1220476508Tc'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0043', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-05-10',
    'Expense',
    'DH32',
    'Unchained Capital',
    '05/10 Online ACH Payment 5334795757 To Unchained ( #############7592)'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0043'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 250.0,
    '05/10 Online ACH Payment 5334795757 To Unchained ( #############7592)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0044', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-05-16',
    'Expense',
    'DH32',
    NULL,
    '05/16 Online ACH Payment 5335649287 To Warehouserack ( i/####111990)'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0044'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 1542.56,
    '05/16 Online ACH Payment 5335649287 To Warehouserack ( i/####111990)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0045', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-05-25',
    'Expense',
    'DH32',
    'Maarschalk Valuations Inc',
    'Online US Dollar Intl Wire Fee'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0045'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 40.0,
    'Online US Dollar Intl Wire Fee'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0045'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 10000.0,
    '05/25 Online International Wire Transfer A/C: Canadian Imperial Bank of Commerce Toronlo On M5L 1-A2 CA Ben:/5008579 Maarschalk Valuations Inc Aef:/Lmpd/Services Rendered Consultancyexpenses Tm: 3457682145Es'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0046', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-05-31',
    'Expense',
    'DH32',
    'AT&T',
    'Orig CO Name:Att Orig ID:9864031004 Deso Date:053022 CO Entry Descr:Payment Sec:PPD Tracel/:031100202647727 Eed:220531 Ind ID: Ind Name:Joel Fultord Trn: 1512647727Tc'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0046'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 115.84,
    'Orig CO Name:Att Orig ID:9864031004 Deso Date:053022 CO Entry Descr:Payment Sec:PPD Tracel/:031100202647727 Eed:220531 Ind ID: Ind Name:Joel Fultord Trn: 1512647727Tc'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0046'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 285.0,
    '05/31 Orig CO Name:Bright Line Busi Orig ID:9215986202 Deso Dale:220529 CO Entry Descr:Sale Sec:CCD Traoe#:021000025292904 Eed:220531 Ind ID: Ind Name:10Netzero Inc Tm: 1515292904Tc'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0047', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-06-01',
    'Expense',
    'DH32',
    NULL,
    'Chase ACH Payments Monthly Fee'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0047'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 25.0,
    'Chase ACH Payments Monthly Fee'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0048', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-06-23',
    'Expense',
    'DH32',
    'Joel Fulford',
    '06/22 Basia Online Payroll Payment 5340786668 To ifffffl/0870 Loan to Joel Fulford'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0048'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 2960.14,
    '06/22 Basia Online Payroll Payment 5340786668 To ifffffl/0870 Loan to Joel Fulford'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0048'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 588.31,
    '06/22 Basic Online Payroll Payment 5340773000 To #111/#0870 Loan to Joel Fulford'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0049', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-06-24',
    'Expense',
    'DH32',
    'Joel Fulford',
    '06/23 Baslo Online Payroll Payment 5340880809 To #lt##0870 Loan to Joel Fulford'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0049'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 2153.63,
    '06/23 Baslo Online Payroll Payment 5340880809 To #lt##0870 Loan to Joel Fulford'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0050', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-06-27',
    'Expense',
    'DH32',
    'TriC Resources',
    'Online Domestic Wire Fee'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0050'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 25.0,
    'Online Domestic Wire Fee'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0050'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 8704.24,
    '06/27 Online Domestic Wire Transfer Via: Central Hous/113001077 A/C: Tri C Resources Houston TX 77024 US Ref: March-April, 2022 Gas Sales'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0050'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 5983.25,
    '06/27 Online lntemational Wire Transfer A/0: Foreign Cur Bus Acct Bk 1 Columbus Newark De 197132107 US Org: 00000000766857871 10Netzoro, Inc. Ben:/0030112 Rwt Growth Inc Ref; Invoice 1229'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0051', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-06-28',
    'Expense',
    'DH32',
    'Brightline',
    'Orig CO Name:Bright Line Busi Orig ID:9215986202 Desc Date:220628 CO Entry Descr:Sale Sec:CCD Trace#:021000026915285 Eed:220628 Ind ID:
Ind Name:10Nelzero Inc Trn: 1796915285Tc'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0051'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 285.0,
    'Orig CO Name:Bright Line Busi Orig ID:9215986202 Desc Date:220628 CO Entry Descr:Sale Sec:CCD Trace#:021000026915285 Eed:220628 Ind ID:
Ind Name:10Nelzero Inc Trn: 1796915285Tc'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0052', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-06-30',
    'Expense',
    'DH32',
    'AT&T',
    'Orig CO Name:Att Orig ID:9864031004 Dase Date:062922 CO Entry Descr:Payment Sec:PPD Trace/l:031100207158731 Eed:220630 Ind ID: Ind Name:Joel Futtord Trn: 1817158731Tc'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0052'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 115.84,
    'Orig CO Name:Att Orig ID:9864031004 Dase Date:062922 CO Entry Descr:Payment Sec:PPD Trace/l:031100207158731 Eed:220630 Ind ID: Ind Name:Joel Futtord Trn: 1817158731Tc'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0053', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-07-01',
    'Expense',
    'DH32',
    NULL,
    'Chase ACH Payments Monthly Fee'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0053'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 25.0,
    'Chase ACH Payments Monthly Fee'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0054', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-07-05',
    'Expense',
    'DH32',
    'Martin Legal PLLC',
    '07/05 Online ACH Payment 5342575612 To Martlnlg ( ######7156)'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0054'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 12630.0,
    '07/05 Online ACH Payment 5342575612 To Martlnlg ( ######7156)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0055', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-07-11',
    'Expense',
    'DH32',
    NULL,
    '07/11 Online ACH Payment 5343434675 To Wwconsultlng (_###1773)'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0055'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 2100.0,
    '07/11 Online ACH Payment 5343434675 To Wwconsultlng (_###1773)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0056', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-07-29',
    'Expense',
    'DH32',
    'Brightline',
    'Orig co Name:Brlght Line Busl Orig ID:9215986202 Deso Date:220729 co Entry
Dascr:Sala Sac:CCD Traca#:021000021851095 Eed:220729 Ind ID:
Ind Name:10Netzero Inc Trn: 2101851095Tc'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0056'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 285.0,
    'Orig co Name:Brlght Line Busl Orig ID:9215986202 Deso Date:220729 co Entry
Dascr:Sala Sac:CCD Traca#:021000021851095 Eed:220729 Ind ID:
Ind Name:10Netzero Inc Trn: 2101851095Tc'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0057', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-08-01',
    'Expense',
    'DH32',
    'AT&T',
    'Orig CO Name:Att Orig ID:9864031004 Dase Date.073022 CO Entry Descr:Payment Sec:PPD Trace/I 031100205035566 Eed 220801 Ind ID 
Ind Name:Joel Futtord Trn: 2135035566To'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0057'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 115.84,
    'Orig CO Name:Att Orig ID:9864031004 Dase Date.073022 CO Entry Descr:Payment Sec:PPD Trace/I 031100205035566 Eed 220801 Ind ID 
Ind Name:Joel Futtord Trn: 2135035566To'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0057'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 25.0,
    'Chase ACH Payments Monthly Fae'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0058', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-08-12',
    'Expense',
    'DH32',
    'TriC Resources',
    'Online Domestic Wire Fee'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0058'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 25.0,
    'Online Domestic Wire Fee'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0058'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 6571.8,
    '08/12 Online Domestic Wire Transfer Via: Central Hous/113001077 /1/C: Trl C Resources Houston TX 77024 US Ref: May- 22 Gas Sales'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0059', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-08-19',
    'Expense',
    'DH32',
    'TriC Resources',
    'Online Domestic Wire Fee'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0059'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 25.0,
    'Online Domestic Wire Fee'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0059'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 7846.61,
    '08/19 Online Domestic Wire Transfer Via: Central Hous/113001077 /1/C: Trio Resources'
);

