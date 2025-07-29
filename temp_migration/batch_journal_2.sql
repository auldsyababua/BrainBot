-- Journal Entries Batch 2

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0051', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-06-28',
    'Expense',
    'Orig CO Name:Bright Line Busi Orig ID:9215986202 Desc Date:220628 CO Entry Descr:Sale Sec:CCD Trace#:021000026915285 Eed:220628 Ind ID:
Ind Name:10Nelzero Inc Trn: 1796915285Tc',
    0.0, 285.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000079', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0051'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Bright Line Busi Orig ID:9215986202 Desc Date:220628 CO Entry Descr:Sale Sec:CCD Trace#:021000026915285 Eed:220628 Ind ID:
Ind Name:10Nelzero Inc Trn: 1796915285Tc',
    285.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0052', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-06-30',
    'Expense',
    'Orig CO Name:Att Orig ID:9864031004 Dase Date:062922 CO Entry Descr:Payment Sec:PPD Trace/l:031100207158731 Eed:220630 Ind ID: Ind Name:Joel Futtord Trn: 1817158731Tc',
    0.0, 115.84, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000080', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0052'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Att Orig ID:9864031004 Dase Date:062922 CO Entry Descr:Payment Sec:PPD Trace/l:031100207158731 Eed:220630 Ind ID: Ind Name:Joel Futtord Trn: 1817158731Tc',
    115.84, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0053', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-07-01',
    'Expense',
    'Chase ACH Payments Monthly Fee',
    0.0, 25.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000081', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0053'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Chase ACH Payments Monthly Fee',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0054', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-07-05',
    'Expense',
    '07/05 Online ACH Payment 5342575612 To Martlnlg ( ######7156)',
    0.0, 12630.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000082', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0054'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '07/05 Online ACH Payment 5342575612 To Martlnlg ( ######7156)',
    12630.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0055', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-07-11',
    'Expense',
    '07/11 Online ACH Payment 5343434675 To Wwconsultlng (_###1773)',
    0.0, 2100.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000083', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0055'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '07/11 Online ACH Payment 5343434675 To Wwconsultlng (_###1773)',
    2100.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0056', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-07-29',
    'Expense',
    'Orig co Name:Brlght Line Busl Orig ID:9215986202 Deso Date:220729 co Entry
Dascr:Sala Sac:CCD Traca#:021000021851095 Eed:220729 Ind ID:
Ind Name:10Netzero Inc Trn: 2101851095Tc',
    0.0, 285.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000084', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0056'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig co Name:Brlght Line Busl Orig ID:9215986202 Deso Date:220729 co Entry
Dascr:Sala Sac:CCD Traca#:021000021851095 Eed:220729 Ind ID:
Ind Name:10Netzero Inc Trn: 2101851095Tc',
    285.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0057', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-08-01',
    'Expense',
    'Orig CO Name:Att Orig ID:9864031004 Dase Date.073022 CO Entry Descr:Payment Sec:PPD Trace/I 031100205035566 Eed 220801 Ind ID 
Ind Name:Joel Futtord Trn: 2135035566To',
    0.0, 140.84, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000085', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0057'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Att Orig ID:9864031004 Dase Date.073022 CO Entry Descr:Payment Sec:PPD Trace/I 031100205035566 Eed 220801 Ind ID 
Ind Name:Joel Futtord Trn: 2135035566To',
    115.84, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000086', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0057'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Chase ACH Payments Monthly Fae',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0058', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-08-12',
    'Expense',
    'Online Domestic Wire Fee',
    0.0, 6596.8, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000087', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0058'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Domestic Wire Fee',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000088', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0058'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '08/12 Online Domestic Wire Transfer Via: Central Hous/113001077 /1/C: Trl C Resources Houston TX 77024 US Ref: May- 22 Gas Sales',
    6571.8, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0059', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-08-19',
    'Expense',
    'Online Domestic Wire Fee',
    0.0, 7871.61, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000089', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0059'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Domestic Wire Fee',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000090', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0059'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '08/19 Online Domestic Wire Transfer Via: Central Hous/113001077 /1/C: Trio Resources',
    7846.61, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0060', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-08-22',
    'Expense',
    '08/19 Basic Online Payroll Payment 5349173717 To ####0870 Loan to Joel Fulford',
    0.0, 1294.54, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000091', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0060'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '08/19 Basic Online Payroll Payment 5349173717 To ####0870 Loan to Joel Fulford',
    1294.54, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0061', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-08-29',
    'Expense',
    'Orig CO Name:Bright Line Busi Orig ID:9215986202 Deso Date:220829 CO Entry Descr:Sale Sec:CCD Trace#:021000028244185 Eed:220829 Ind ID: Ind Name:10Netzero Inc Tm: 2416244165To',
    0.0, 15285.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000092', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0061'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Bright Line Busi Orig ID:9215986202 Deso Date:220829 CO Entry Descr:Sale Sec:CCD Trace#:021000028244185 Eed:220829 Ind ID: Ind Name:10Netzero Inc Tm: 2416244165To',
    285.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000093', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0061'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '08/28 Same-Day ACH Payroll Payment 5350148912 To ####0870 Loan to Joel Fulford',
    15000.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0062', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-08-31',
    'Expense',
    'Orig CO Name:Att Orig ID:9864031004 Dase Date:083022 CO Entry Descr:Payment Sec:PPD Traoel/:031100201905899 Eed:220831 Ind ID: Ind Name:Joel Futtord Trn: 2431905899Tc',
    0.0, 115.84, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000094', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0062'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Att Orig ID:9864031004 Dase Date:083022 CO Entry Descr:Payment Sec:PPD Traoel/:031100201905899 Eed:220831 Ind ID: Ind Name:Joel Futtord Trn: 2431905899Tc',
    115.84, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0063', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-09-01',
    'Expense',
    'Chase ACH Payments Monthly Fee',
    0.0, 50.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000095', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0063'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Chase ACH Payments Monthly Fee',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000096', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0063'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Rip/Same Day - High Value',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0064', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-09-12',
    'Expense',
    '09/12 Onlll1e ACH Payment 5352248562 To Llvlnti ( ###8392)',
    0.0, 2397.8, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000097', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0064'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '09/12 Onlll1e ACH Payment 5352248562 To Llvlnti ( ###8392)',
    2397.8, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0065', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-09-15',
    'Deposit',
    'Credit Retum: Online ACH Payment 5352248562 To Livinll ( ###8392)',
    2397.8, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000098', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0065'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Credit Retum: Online ACH Payment 5352248562 To Livinll ( ###8392)',
    2397.8, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0066', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-09-16',
    'Expense',
    'Credit Return Fee: Online Payroll Payment To Livingston international 4678392',
    0.0, 2.5, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000099', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0066'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Credit Return Fee: Online Payroll Payment To Livingston international 4678392',
    2.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0067', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-09-23',
    'Expense',
    '09/23 Online ACH Payment 5353999763 To Martinlg ( ######7156)',
    0.0, 4812.8, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000100', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0067'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '09/23 Online ACH Payment 5353999763 To Martinlg ( ######7156)',
    2415.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000101', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0067'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '09/23 Online ACH Payment 5353998498 To Livintl Ul####i/##1708)',
    2397.8, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0068', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-09-28',
    'Expense',
    'Online Domestic Wire Fee',
    0.0, 5975.64, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000102', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0068'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Domestic Wire Fee',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000103', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0068'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Domestic Wire Transfer Via: Central Hous/113001077 A/C: Trio Resources Houston TX 77024 US Ref: July - 22 lmad: 0928B1Qgc06C011829 Tm: 3480042271Es',
    5950.64, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0069', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-09-29',
    'Expense',
    '09/28 Basic Online Payroll Payment 5354623032 To Loan to Joel Fulford',
    0.0, 10000.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000104', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0069'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '09/28 Basic Online Payroll Payment 5354623032 To Loan to Joel Fulford',
    10000.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0070', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-09-30',
    'Expense',
    'Orig CO Name:Att Orig ID:9864031004 Deso Date:092922 CO Eniry Descr:Payment Sec:PPD Traoe#:031100205486994 Eed:220930 Ind ID:Ind Name:Joel Futtord Tm: 2735486994Tc',
    0.0, 115.84, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000105', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0070'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Att Orig ID:9864031004 Deso Date:092922 CO Eniry Descr:Payment Sec:PPD Traoe#:031100205486994 Eed:220930 Ind ID:Ind Name:Joel Futtord Tm: 2735486994Tc',
    115.84, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0071', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-10-03',
    'Expense',
    'Chase ACH Payments Monthly Fee',
    0.0, 310.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000106', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0071'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Chase ACH Payments Monthly Fee',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000107', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0071'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Bright Line Busi Orig ID:9215986202 Desc Date:221002 CO Entry Descr:Sala Sec:CCD Tracall:021000020065521 Eed:221003 Ind ID: Ind Nama:10Natzero Inc Tm: 2760065521Tc',
    285.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0072', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-10-27',
    'Expense',
    '10/27 Online International Wire Transfer NC: Foreign Cur Bus Acct Bk 1 Columbus Newark De 197132107 US Org: 00000000766857871 10Netzero, Inc. Ben:/0030112 Rwt Growth Inc Ref: Invoice 1249Consultancy Expenses/Ocmt/Cad10000,00/Exch/1.3192/Cntr/610 t 9531/ Tm: 8994800300Re',
    0.0, 7580.35, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000108', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0072'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '10/27 Online International Wire Transfer NC: Foreign Cur Bus Acct Bk 1 Columbus Newark De 197132107 US Org: 00000000766857871 10Netzero, Inc. Ben:/0030112 Rwt Growth Inc Ref: Invoice 1249Consultancy Expenses/Ocmt/Cad10000,00/Exch/1.3192/Cntr/610 t 9531/ Tm: 8994800300Re',
    7580.35, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0073', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-10-31',
    'Expense',
    '10/28 Basic Online Payroll Payment 11001199706 To Loan to Joel Fulford',
    0.0, 5000.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000109', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0073'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '10/28 Basic Online Payroll Payment 11001199706 To Loan to Joel Fulford',
    5000.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0074', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-11-01',
    'Expense',
    'Orig CO Name:Att Orig ID:9864031004 Desc Date·103022 CO Entry Descr:Payment Seo:PPD Trace#''031100204139858 Eed 221101 Ind ID: Ind Name:Joel Fulford Trn: 3054139858To',
    0.0, 140.84, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000110', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0074'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Att Orig ID:9864031004 Desc Date·103022 CO Entry Descr:Payment Seo:PPD Trace#''031100204139858 Eed 221101 Ind ID: Ind Name:Joel Fulford Trn: 3054139858To',
    115.84, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000111', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0074'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Chase ACH Payments Monthly Fea',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0075', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-11-02',
    'Expense',
    'Orig CO Name:Brighl Une Busi Orig ID:9215986202 Desc Date:221102 CO Entry Descr:Sale Sec:CCD Tracell:021000022968833 Eed:221102 Ind ID: Ind Name:10Netzero Inc Trn: 3D62968833Tc',
    0.0, 1286.5700000000002, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000112', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0075'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Brighl Une Busi Orig ID:9215986202 Desc Date:221102 CO Entry Descr:Sale Sec:CCD Tracell:021000022968833 Eed:221102 Ind ID: Ind Name:10Netzero Inc Trn: 3D62968833Tc',
    285.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000113', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0075'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '11/01 Basic Online Payroll Payment 11001514107 To ###//0870 Loan to Joel Fulford',
    1001.57, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0076', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-11-14',
    'Expense',
    'Check No. 9765 - Pay to The Order Of: Giga Energy Inc.',
    0.0, 588.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000114', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0076'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Check No. 9765 - Pay to The Order Of: Giga Energy Inc.',
    588.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0077', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-11-28',
    'Expense',
    '11/28 Online ACH Payment 11003847617 To United Oil Field Services ( 11##11#2100)',
    0.0, 1518.75, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000115', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0077'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '11/28 Online ACH Payment 11003847617 To United Oil Field Services ( 11##11#2100)',
    1518.75, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0078', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-12-01',
    'Expense',
    'Chase ACH Payments Monthly Fee',
    0.0, 140.84, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000116', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0078'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Chase ACH Payments Monthly Fee',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000117', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0078'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Att Ong ID 9864031004 Desc Dale 112922 CO Entry Desor:Payment Sec:PPD Trace# 031100205806973 Eed 221201 Ind ID Ind Name:Joel Fulford Trn: 3355806973Tc',
    115.84, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0079', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-12-02',
    'Expense',
    'Orig CO Name:Bright Line Busi Orig ID:9215986202 Deso Date:221202 CO Entry 12/02 Orig CO Name:Bright Line Busi Orig ID:9215986202 Deso Date:221202 CO Entry Desor:Sale Sec:CCD Trace#:021000021526905 Eed:221202 Ind ID: Ind Name:10Netzero Inc Trn: 3361526905Tc',
    0.0, 285.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000118', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0079'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Bright Line Busi Orig ID:9215986202 Deso Date:221202 CO Entry 12/02 Orig CO Name:Bright Line Busi Orig ID:9215986202 Deso Date:221202 CO Entry Desor:Sale Sec:CCD Trace#:021000021526905 Eed:221202 Ind ID: Ind Name:10Netzero Inc Trn: 3361526905Tc',
    285.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0080', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-12-31',
    'Journal Entry',
    '6% annum on $12,912.50 Loan from S. Bryan Aulds II',
    0.0, 774.75, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000119', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0080'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    '6% annum on $12,912.50 Loan from S. Bryan Aulds II',
    774.75, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0081', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-12-31',
    'Journal Entry',
    '6% annum on $12,912.50 Loan from Colin Aulds',
    0.0, 4563.52, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000120', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0081'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    '6% annum on $12,912.50 Loan from Colin Aulds',
    4563.52, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0082', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-12-31',
    'Journal Entry',
    'Journal Entry - 2022-12-31',
    0.0, 2452.46, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000121', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0082'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    '',
    2452.46, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0083', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-12-31',
    'Journal Entry',
    'Shwan Leary $100K - 5.46% annum',
    0.0, 5457.21, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000122', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0083'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    'Shwan Leary $100K - 5.46% annum',
    5457.21, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0084', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-12-31',
    'Journal Entry',
    'Scott Aulds Sr Loan $100,000 - Interest accrual on 5.54% annum',
    0.0, 5535.45, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000123', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0084'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2200'),
    'Scott Aulds Sr Loan $100,000 - Interest accrual on 5.54% annum',
    5535.45, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0085', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-12-31',
    'Journal Entry',
    'To record 2022 Depreciation expense',
    55867.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000124', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0085'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-8000'),
    'To record 2022 Depreciation expense',
    55867.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0086', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-01-03',
    'Expense',
    'Chase ACH Payments Monthly Fee',
    0.0, 425.84000000000003, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000125', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0086'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Chase ACH Payments Monthly Fee',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000126', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0086'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Brlght Line Busl Orig ID:9215986202 Deso Date:230102 CO Entry Descr:8ale Sec:CCD Trace/l:021000020986856 Eed:230103 Ind ID: Ind Name:10Netzero Inc Trn: 0030986856Tc',
    285.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000127', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0086'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Att Orig 10·9864031004 Desc Date·123022 CO Entry Descr:Payment Sec:PPD Trace#.031100206666250 Eed 230103 Ind ID: Ind Name:Joel Futtord Trn: 0036666250Tc',
    115.84, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0087', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-01-09',
    'Deposit',
    'Orig CO Name:Google Orig ID:F770493581 Deso Date: CO Entry $0.22
Descr.Payment Sec:CCD Trace#:091000015785898 Eed:230109 Ind ID:US003Somv0 Ind Name:Joel Fulford
013023996 Credit Trn: 0095785898Tc',
    0.22, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000128', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0087'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Google Orig ID:F770493581 Deso Date: CO Entry $0.22
Descr.Payment Sec:CCD Trace#:091000015785898 Eed:230109 Ind ID:US003Somv0 Ind Name:Joel Fulford
013023996 Credit Trn: 0095785898Tc',
    0.22, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0088', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-01-09',
    'Expense',
    'Orig CO Name:Google Orig ID:F770493581 Deso Date: CO Entry Descr:Apps_Commesec:CCD Tracell:091000014070852 Eed:230109 Ind ID:US003Sht3K Ind Name:Joel Futtord 013024945 Debit Tm: 0094070852Tc',
    0.0, 115.75, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000129', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0088'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Google Orig ID:F770493581 Deso Date: CO Entry Descr:Apps_Commesec:CCD Tracell:091000014070852 Eed:230109 Ind ID:US003Sht3K Ind Name:Joel Futtord 013024945 Debit Tm: 0094070852Tc',
    115.53, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000130', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0088'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Google Orig ID:F770493581 Deso Date: CO Entry Descr:Payment Sec:CCD Trace#:091000015747015 Eed:230109 Ind ID:US003Sh365 Ind Name:Joel Futtord 013024153 Debit Tm: 0095747015Tc',
    0.22, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0089', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-01-31',
    'Expense',
    'Orig CO Name:Att Orig ID:9864031004 Desc Date:013023 CO Entry Descr:Payment Sec:PPD Traceil:031100204926183 Eed:230131 Ind ID: Ind Name:Joel Futtord Trn: 0314926183Tc',
    0.0, 115.84, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000131', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0089'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Att Orig ID:9864031004 Desc Date:013023 CO Entry Descr:Payment Sec:PPD Traceil:031100204926183 Eed:230131 Ind ID: Ind Name:Joel Futtord Trn: 0314926183Tc',
    115.84, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0090', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-02-01',
    'Expense',
    'Chase ACH Payments Monthly Fee',
    0.0, 25.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000132', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0090'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Chase ACH Payments Monthly Fee',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0091', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-02-02',
    'Expense',
    'Orig CO Name:Bright Line Busi Orig ID:9215986202 Desc Date:230202 CO Entry Descr:Sale Sec:CCD Trace#:021000021201928 Eed:230202 Ind ID: Ind Name:10Netzero Inc Tm: 0331201928Tc',
    0.0, 285.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000133', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0091'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Bright Line Busi Orig ID:9215986202 Desc Date:230202 CO Entry Descr:Sale Sec:CCD Trace#:021000021201928 Eed:230202 Ind ID: Ind Name:10Netzero Inc Tm: 0331201928Tc',
    285.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0092', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-02-06',
    'Expense',
    'Orig CO Name:Gocgle Orig ID:F710493581 Desc Date: CO Entry Descr:Apps_Ccmmesec:CCD Trace#:091000010021448 Eed:230206 Ind ID:US003Suagu Ind Name:Joel Fulford 013065208 Debit Tm: 0370021448Tc',
    0.0, 63.55, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000134', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0092'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Gocgle Orig ID:F710493581 Desc Date: CO Entry Descr:Apps_Ccmmesec:CCD Trace#:091000010021448 Eed:230206 Ind ID:US003Suagu Ind Name:Joel Fulford 013065208 Debit Tm: 0370021448Tc',
    63.55, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0093', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-02-22',
    'Journal Entry',
    'Hushhut #2 and M30 Miners',
    72333.76, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000135', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0093'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1420'),
    'Hushhut #2 and M30 Miners',
    72333.76, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0094', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-02-28',
    'Expense',
    'Orig CO Name:Att Orig ID:9864031004 Deso Dale:022723 CO Entry Descr:Payment Sec:PPD Trace#:031100200667215 Eed:230228 Ind ID: Ind Name:Joel Futtord Trn: 0590667215Tc',
    0.0, 10155.84, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000136', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0094'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Att Orig ID:9864031004 Deso Dale:022723 CO Entry Descr:Payment Sec:PPD Trace#:031100200667215 Eed:230228 Ind ID: Ind Name:Joel Futtord Trn: 0590667215Tc',
    115.84, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000137', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0094'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online US Dollar Intl Wire Fee',
    40.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000138', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0094'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '02/28 Online International Wire Transfer NC: Canadian Imperial Bank of Commerce Toronto On M5L 1-A2 CA Ben:/7301535 Upstream Data Inc Ref:/Lmpd/Down Payment· 90Kw Hh Combo (IN Houston) Business Expenses Tm: 3512633059Es',
    10000.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0095', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-03-01',
    'Expense',
    'Chase ACH Payments Monthly Fee',
    0.0, 25.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000139', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0095'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Chase ACH Payments Monthly Fee',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0096', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-03-02',
    'Expense',
    'Orig CO Name:Brlght Line Busi Orig ID:9215986202 Deso Date:230302 CO Entry Descr:Sale Sec:CCD Trace#:021000025738122 Eed:230302 Ind ID: Ind Name:10Netzero Inc Trn: 06t5738122Tc',
    0.0, 285.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000140', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0096'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Brlght Line Busi Orig ID:9215986202 Deso Date:230302 CO Entry Descr:Sale Sec:CCD Trace#:021000025738122 Eed:230302 Ind ID: Ind Name:10Netzero Inc Trn: 06t5738122Tc',
    285.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0097', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-03-06',
    'Expense',
    'Orig CO Name:Google Orig ID:F77D493581 Deso Date: CO Entry Descr:Apps_Commesec:CCD Trace#:091000014422534 Eed:230306 Ind ID:US003T eiz9 Ind Name:Joel Fultord 013109912 Debit Trn: 0654422534Tc',
    0.0, 101.54, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000141', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0097'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Google Orig ID:F77D493581 Deso Date: CO Entry Descr:Apps_Commesec:CCD Trace#:091000014422534 Eed:230306 Ind ID:US003T eiz9 Ind Name:Joel Fultord 013109912 Debit Trn: 0654422534Tc',
    101.54, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0098', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-03-30',
    'Expense',
    'Counter Check',
    0.0, 12.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000142', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0098'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Counter Check',
    6.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000143', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0098'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Counter Check',
    6.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0099', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-03-31',
    'Expense',
    'Orig CO Name AU Orig ID:9864031004 Desc Date:033023 CO Entry Descr:Payrnent Sec:PPD Traceil:031100207614216 Eed:230331 Ind ID: Ind Name:Joel Fulford Tm: 09D7614216Tc',
    0.0, 115.84, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000144', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0099'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name AU Orig ID:9864031004 Desc Date:033023 CO Entry Descr:Payrnent Sec:PPD Traceil:031100207614216 Eed:230331 Ind ID: Ind Name:Joel Fulford Tm: 09D7614216Tc',
    115.84, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0100', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2023-04-03',
    'Expense',
    'Orig CO Name:Bright Line Busi Orig ID:9215986202 Dase Date:230402 CO Entry Descr:Sale Sec:CCD Trace/l:021000025108083 Eed:230403 Ind ID: Orig CO Name:Bright Line Busi Orig ID:9215986202 Dase Date:230402 CO Entry Descr:Sale Sec:CCD Trace/l:021000025108083 Eed:230403 Ind ID:',
    0.0, 310.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000145', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0100'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Orig CO Name:Bright Line Busi Orig ID:9215986202 Dase Date:230402 CO Entry Descr:Sale Sec:CCD Trace/l:021000025108083 Eed:230403 Ind ID: Orig CO Name:Bright Line Busi Orig ID:9215986202 Dase Date:230402 CO Entry Descr:Sale Sec:CCD Trace/l:021000025108083 Eed:230403 Ind ID:',
    285.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000146', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0100'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Stop Payment Fee',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

