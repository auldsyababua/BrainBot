-- Journal Entries Final Batch 4

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0060', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-08-22',
    'Expense',
    'DH32',
    'Joel Fulford',
    '08/19 Basic Online Payroll Payment 5349173717 To ####0870 Loan to Joel Fulford'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0060'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 1294.54,
    '08/19 Basic Online Payroll Payment 5349173717 To ####0870 Loan to Joel Fulford'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0061', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-08-29',
    'Expense',
    'DH32',
    'Brightline',
    'Orig CO Name:Bright Line Busi Orig ID:9215986202 Deso Date:220829 CO Entry Descr:Sale Sec:CCD Trace#:021000028244185 Eed:220829 Ind ID: Ind Name:10Netzero Inc Tm: 2416244165To'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0061'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 285.0,
    'Orig CO Name:Bright Line Busi Orig ID:9215986202 Deso Date:220829 CO Entry Descr:Sale Sec:CCD Trace#:021000028244185 Eed:220829 Ind ID: Ind Name:10Netzero Inc Tm: 2416244165To'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0061'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 15000.0,
    '08/28 Same-Day ACH Payroll Payment 5350148912 To ####0870 Loan to Joel Fulford'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0062', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-08-31',
    'Expense',
    'DH32',
    'AT&T',
    'Orig CO Name:Att Orig ID:9864031004 Dase Date:083022 CO Entry Descr:Payment Sec:PPD Traoel/:031100201905899 Eed:220831 Ind ID: Ind Name:Joel Futtord Trn: 2431905899Tc'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0062'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 115.84,
    'Orig CO Name:Att Orig ID:9864031004 Dase Date:083022 CO Entry Descr:Payment Sec:PPD Traoel/:031100201905899 Eed:220831 Ind ID: Ind Name:Joel Futtord Trn: 2431905899Tc'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0063', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-09-01',
    'Expense',
    'DH32',
    NULL,
    'Chase ACH Payments Monthly Fee'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0063'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 25.0,
    'Chase ACH Payments Monthly Fee'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0063'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 25.0,
    'Rip/Same Day - High Value'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0064', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-09-12',
    'Expense',
    'DH32',
    NULL,
    '09/12 Onlll1e ACH Payment 5352248562 To Llvlnti ( ###8392)'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0064'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 2397.8,
    '09/12 Onlll1e ACH Payment 5352248562 To Llvlnti ( ###8392)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0065', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-09-15',
    'Deposit',
    'DH32',
    NULL,
    'Credit Retum: Online ACH Payment 5352248562 To Livinll ( ###8392)'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0065'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    2397.8, 0,
    'Credit Retum: Online ACH Payment 5352248562 To Livinll ( ###8392)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0066', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-09-16',
    'Expense',
    'DH32',
    NULL,
    'Credit Return Fee: Online Payroll Payment To Livingston international 4678392'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0066'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 2.5,
    'Credit Return Fee: Online Payroll Payment To Livingston international 4678392'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0067', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-09-23',
    'Expense',
    'DH32',
    'Martin Legal PLLC',
    '09/23 Online ACH Payment 5353999763 To Martinlg ( ######7156)'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0067'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 2415.0,
    '09/23 Online ACH Payment 5353999763 To Martinlg ( ######7156)'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0067'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 2397.8,
    '09/23 Online ACH Payment 5353998498 To Livintl Ul####i/##1708)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0068', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-09-28',
    'Expense',
    'DH32',
    'TriC Resources',
    'Online Domestic Wire Fee'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0068'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 25.0,
    'Online Domestic Wire Fee'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0068'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 5950.64,
    'Online Domestic Wire Transfer Via: Central Hous/113001077 A/C: Trio Resources Houston TX 77024 US Ref: July - 22 lmad: 0928B1Qgc06C011829 Tm: 3480042271Es'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0069', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-09-29',
    'Expense',
    'DH32',
    'Joel Fulford',
    '09/28 Basic Online Payroll Payment 5354623032 To Loan to Joel Fulford'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0069'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 10000.0,
    '09/28 Basic Online Payroll Payment 5354623032 To Loan to Joel Fulford'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0070', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-09-30',
    'Expense',
    'DH32',
    'AT&T',
    'Orig CO Name:Att Orig ID:9864031004 Deso Date:092922 CO Eniry Descr:Payment Sec:PPD Traoe#:031100205486994 Eed:220930 Ind ID:Ind Name:Joel Futtord Tm: 2735486994Tc'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0070'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 115.84,
    'Orig CO Name:Att Orig ID:9864031004 Deso Date:092922 CO Eniry Descr:Payment Sec:PPD Traoe#:031100205486994 Eed:220930 Ind ID:Ind Name:Joel Futtord Tm: 2735486994Tc'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0071', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-10-03',
    'Expense',
    'DH32',
    'Brightline',
    'Chase ACH Payments Monthly Fee'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0071'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 25.0,
    'Chase ACH Payments Monthly Fee'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0071'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 285.0,
    'Orig CO Name:Bright Line Busi Orig ID:9215986202 Desc Date:221002 CO Entry Descr:Sala Sec:CCD Tracall:021000020065521 Eed:221003 Ind ID: Ind Nama:10Natzero Inc Tm: 2760065521Tc'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0072', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-10-27',
    'Expense',
    'DH32',
    NULL,
    '10/27 Online International Wire Transfer NC: Foreign Cur Bus Acct Bk 1 Columbus Newark De 197132107 US Org: 00000000766857871 10Netzero, Inc. Ben:/0030112 Rwt Growth Inc Ref: Invoice 1249Consultancy Expenses/Ocmt/Cad10000,00/Exch/1.3192/Cntr/610 t 9531/ Tm: 8994800300Re'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0072'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 7580.35,
    '10/27 Online International Wire Transfer NC: Foreign Cur Bus Acct Bk 1 Columbus Newark De 197132107 US Org: 00000000766857871 10Netzero, Inc. Ben:/0030112 Rwt Growth Inc Ref: Invoice 1249Consultancy Expenses/Ocmt/Cad10000,00/Exch/1.3192/Cntr/610 t 9531/ Tm: 8994800300Re'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0073', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-10-31',
    'Expense',
    'DH32',
    'Joel Fulford',
    '10/28 Basic Online Payroll Payment 11001199706 To Loan to Joel Fulford'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0073'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 5000.0,
    '10/28 Basic Online Payroll Payment 11001199706 To Loan to Joel Fulford'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0074', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-11-01',
    'Expense',
    'DH32',
    'AT&T',
    'Orig CO Name:Att Orig ID:9864031004 Desc Date·103022 CO Entry Descr:Payment Seo:PPD Trace#''031100204139858 Eed 221101 Ind ID: Ind Name:Joel Fulford Trn: 3054139858To'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0074'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 115.84,
    'Orig CO Name:Att Orig ID:9864031004 Desc Date·103022 CO Entry Descr:Payment Seo:PPD Trace#''031100204139858 Eed 221101 Ind ID: Ind Name:Joel Fulford Trn: 3054139858To'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0074'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 25.0,
    'Chase ACH Payments Monthly Fea'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0075', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-11-02',
    'Expense',
    'DH32',
    'Brightline',
    'Orig CO Name:Brighl Une Busi Orig ID:9215986202 Desc Date:221102 CO Entry Descr:Sale Sec:CCD Tracell:021000022968833 Eed:221102 Ind ID: Ind Name:10Netzero Inc Trn: 3D62968833Tc'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0075'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 285.0,
    'Orig CO Name:Brighl Une Busi Orig ID:9215986202 Desc Date:221102 CO Entry Descr:Sale Sec:CCD Tracell:021000022968833 Eed:221102 Ind ID: Ind Name:10Netzero Inc Trn: 3D62968833Tc'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0075'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 1001.57,
    '11/01 Basic Online Payroll Payment 11001514107 To ###//0870 Loan to Joel Fulford'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0076', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-11-14',
    'Expense',
    'DH32',
    'Giga Energy Inc.',
    'Check No. 9765 - Pay to The Order Of: Giga Energy Inc.'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0076'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 588.0,
    'Check No. 9765 - Pay to The Order Of: Giga Energy Inc.'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0077', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-11-28',
    'Expense',
    'DH32',
    NULL,
    '11/28 Online ACH Payment 11003847617 To United Oil Field Services ( 11##11#2100)'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0077'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 1518.75,
    '11/28 Online ACH Payment 11003847617 To United Oil Field Services ( 11##11#2100)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0078', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-12-01',
    'Expense',
    'DH32',
    'AT&T',
    'Chase ACH Payments Monthly Fee'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0078'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 25.0,
    'Chase ACH Payments Monthly Fee'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0078'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 115.84,
    'Orig CO Name:Att Ong ID 9864031004 Desc Dale 112922 CO Entry Desor:Payment Sec:PPD Trace# 031100205806973 Eed 221201 Ind ID Ind Name:Joel Fulford Trn: 3355806973Tc'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0079', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-12-02',
    'Expense',
    'DH32',
    'Brightline',
    'Orig CO Name:Bright Line Busi Orig ID:9215986202 Deso Date:221202 CO Entry 12/02 Orig CO Name:Bright Line Busi Orig ID:9215986202 Deso Date:221202 CO Entry Desor:Sale Sec:CCD Trace#:021000021526905 Eed:221202 Ind ID: Ind Name:10Netzero Inc Trn: 3361526905Tc'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0079'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 285.0,
    'Orig CO Name:Bright Line Busi Orig ID:9215986202 Deso Date:221202 CO Entry 12/02 Orig CO Name:Bright Line Busi Orig ID:9215986202 Deso Date:221202 CO Entry Desor:Sale Sec:CCD Trace#:021000021526905 Eed:221202 Ind ID: Ind Name:10Netzero Inc Trn: 3361526905Tc'
);

