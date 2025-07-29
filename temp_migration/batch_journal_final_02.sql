-- Journal Entries Final Batch 2

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0020', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-12-31',
    'Journal Entry',
    'DH4',
    NULL,
    'To record 2021 current year depreciation expense for Hashhut#1'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0020'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-8000'),
    1,
    34917.0, 0,
    'To record 2021 current year depreciation expense for Hashhut#1'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0021', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2021-12-31',
    'Journal Entry',
    'DH6 - Common Stock',
    NULL,
    'To record initial purchase of common stock'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0021'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-2610'),
    1,
    360.0, 0,
    'To record initial purchase of common stock'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0022', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-01-03',
    'Expense',
    'DH32',
    'AT&T',
    '01/03 Online Domestic Wire Transfer Via: Central Hous/113001077 NC: Trio Resources Houston TX 77024 US Ref: October -21 !mad: 0103B1Qgc06C003446 Trn: 3164812003Es'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0022'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 5492.08,
    '01/03 Online Domestic Wire Transfer Via: Central Hous/113001077 NC: Trio Resources Houston TX 77024 US Ref: October -21 !mad: 0103B1Qgc06C003446 Trn: 3164812003Es'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0022'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 25.0,
    'Online Domestic Wire Fee'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0022'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 115.83,
    'Orig CO Name:Att Orig ID:9864031004 Desc Dale:123021 CO Entry Descr:Payment Soo:PPD Trace#:031100202787423 Eed:220103 Ind ID: Ind Name:Joel Fulford Trn: 0032787423Tc'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0022'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 3500.0,
    '01/02 Online ACH Payment 5317058761 To Austinlawyers ( ####0096)'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0022'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 7475.0,
    '01/02 Online ACH Payment 5317058824 To Austinlawyers ( ####0096)'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0022'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 25.0,
    'Chase ACH Paymenls Monthly Fee'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0023', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-01-05',
    'Expense',
    'DH32',
    'Joel Fulford',
    '01/05 Withdrawal - Joel Fulford - Loan'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0023'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 9000.0,
    '01/05 Withdrawal - Joel Fulford - Loan'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0024', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-01-06',
    'Expense',
    'DH32',
    'United Oilfield Services',
    'Check No. 9761 - Pay to The Order Of: United Oilfield Services, Inc'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0024'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 6054.23,
    'Check No. 9761 - Pay to The Order Of: United Oilfield Services, Inc'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0025', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-01-18',
    'Expense',
    'DH32',
    'To Advanced Crypto services',
    '01/16 Online ACH Payment 5318843176 To Advanced Crypto services'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0025'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 6297.0,
    '01/16 Online ACH Payment 5318843176 To Advanced Crypto services'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0026', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-02-01',
    'Expense',
    'DH32',
    'AT&T',
    'Chase ACH Payments Monthly Fee'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0026'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 25.0,
    'Chase ACH Payments Monthly Fee'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0026'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 115.83,
    'Orig CO Name:Att Orig ID:9864031004 Desc Date:013022 CO Entry Descr:Payment Sec:PPD Traceil:031100206015826 Eed:220201 Ind ID: Ind Name:Joel Fulford Trn: 0326015826Tc'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0027', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-02-08',
    'Expense',
    'DH32',
    'Joel Fulford',
    '02/07 Basic Online Payroll Payment 5321551953 To ####0870 Loan to Joel Fulford'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0027'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 982.61,
    '02/07 Basic Online Payroll Payment 5321551953 To ####0870 Loan to Joel Fulford'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0027'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 782.37,
    '02/07 Basic Online Payroll Payment 5321551946 To ####0870 Loan to Joel Fulford'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0028', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-02-18',
    'Expense',
    'DH32',
    'Martin Legal PLLC',
    '02/18 Online ACH Paymen15323178663 To Martinlg ( ######7156)'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0028'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 5000.0,
    '02/18 Online ACH Paymen15323178663 To Martinlg ( ######7156)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0029', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-02-22',
    'Expense',
    'DH32',
    NULL,
    'Online Domestic Wire Fee'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0029'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 25.0,
    'Online Domestic Wire Fee'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0029'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 4968.4,
    '02/22 Online Domestic Wire Transfer Via: Central Hous/113001077 NC: Trio Resources Houston TX 77024 US lmad: 0222B1Qgc06C005863 Tm: 3294552053Es'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0030', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-02-28',
    'Expense',
    'DH32',
    'Brightline',
    'Orig CO Name:Bright Line Busi Orig ID:9215986202 Deso Date:220226 CO Entry Descr:Sale Sec:CCD Trace#:021000022279070 Eed:220228 Ind ID: 
Ind Name:10Netzero Inc Tm: 0592279070Tc'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0030'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 285.0,
    'Orig CO Name:Bright Line Busi Orig ID:9215986202 Deso Date:220226 CO Entry Descr:Sale Sec:CCD Trace#:021000022279070 Eed:220228 Ind ID: 
Ind Name:10Netzero Inc Tm: 0592279070Tc'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0031', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-03-01',
    'Expense',
    'DH32',
    'AT&T',
    'Chase ACH Payments Monthly Fee'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0031'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 25.0,
    'Chase ACH Payments Monthly Fee'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0031'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 115.83,
    'Orig CO Name:Att Orig ID:9864031004 Dase Data:022722 CO Entry Descr:Payment Sec:PPD Trace#:0311002036054 t 4 Eed:220301 Ind ID: Ind Nam0:Jo0I Futtord Trn: 0603605414Tc'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0032', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-03-02',
    'Expense',
    'DH32',
    'United Oilfield Services',
    'Check No. 9763 - Pay to The Order Of: United Oilfield Services, Inc'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0032'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 725.0,
    'Check No. 9763 - Pay to The Order Of: United Oilfield Services, Inc'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0032'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 400.0,
    'Check No. 9764 - Pay to The Order Of: United Oilfield Services, Inc'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0032'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 3515.0,
    'Check No. 9762'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0032'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 7400.0,
    'Orig CO Name:Advanced Crypto Orig ID:0000335892 Deso Data:220302 CO Entry Descr:8554693729Sec:Web Traoa#:021000020713908 Eed:220302 Ind ID:2487473 
Ind Name:Joel ''Futtord'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0033', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-03-08',
    'Expense',
    'DH32',
    NULL,
    '03/08 Online ACH Payment 5325787543 To Oil ( #####7765)'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0033'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 2736.25,
    '03/08 Online ACH Payment 5325787543 To Oil ( #####7765)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0034', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-03-18',
    'Expense',
    'DH32',
    NULL,
    'Orig CO Nama:Unchainad Capita Orig ID:814173373 Deso Date:Mar 18 CO Entry Desor:Conclerge Sec:CCD Traoe#:071005255855062 Eed:220318 Ind ID:COncierge Ind Nama:Joel Futtord Trn: 0775855062Tc'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0034'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 2950.0,
    'Orig CO Nama:Unchainad Capita Orig ID:814173373 Deso Date:Mar 18 CO Entry Desor:Conclerge Sec:CCD Traoe#:071005255855062 Eed:220318 Ind ID:COncierge Ind Nama:Joel Futtord Trn: 0775855062Tc'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0035', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-03-29',
    'Expense',
    'DH32',
    'Brightline',
    'Orig CO Nama:Bright Line Busi Orig ID:9215986202 Deso Data:220329 CO Entry Descr:Sale Sec:CCD Trace#:021000024455651 Eed:220329 Ind ID: 
Ind Name:10Netzaro Inc Trn: 0884455651Tc'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0035'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 285.0,
    'Orig CO Nama:Bright Line Busi Orig ID:9215986202 Deso Data:220329 CO Entry Descr:Sale Sec:CCD Trace#:021000024455651 Eed:220329 Ind ID: 
Ind Name:10Netzaro Inc Trn: 0884455651Tc'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0036', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-03-31',
    'Expense',
    'DH32',
    'AT&T',
    'Orig CO Name:Att Orig ID:9864031004 Dase Date:033022 CO Entry Dascr:Paymen1 Sec:PPD Trace#:031100209284810 Ead:220331 Ind ID: Ind Nama:Joel Fulford Trn: 0909284810Tc'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0036'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 115.83,
    'Orig CO Name:Att Orig ID:9864031004 Dase Date:033022 CO Entry Dascr:Paymen1 Sec:PPD Trace#:031100209284810 Ead:220331 Ind ID: Ind Nama:Joel Fulford Trn: 0909284810Tc'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0037', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-04-01',
    'Expense',
    'DH32',
    'Chase Bank',
    'Expense - 2022-04-01'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0037'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 25.0,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0038', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-04-16',
    'Deposit',
    'DH32',
    'Colin Aulds',
    'Deposti: 10 Net Zero (Colin Aulds - Loan) *7668578771'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0038'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    100000.0, 0,
    'Deposti: 10 Net Zero (Colin Aulds - Loan) *7668578771'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0039', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2022-04-20',
    'Expense',
    'DH32',
    'TriC Resources',
    '04/20 Online Domestic Wire Transfer Via: Central Hous/113001077 A/C: Tric Resources Houston TX 77024 US Ref: January & February - 22 lmad: 0420B1Qgc05C001879 Tm: 303527211OEs'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0039'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 9265.32,
    '04/20 Online Domestic Wire Transfer Via: Central Hous/113001077 A/C: Tric Resources Houston TX 77024 US Ref: January & February - 22 lmad: 0420B1Qgc05C001879 Tm: 303527211OEs'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0039'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 25.0,
    ''
);

