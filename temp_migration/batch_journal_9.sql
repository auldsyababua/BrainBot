-- Journal Entries Batch 9

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0401', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-09',
    'Expense',
    'NETLIFY NETLIFY.COM CA 11/09',
    0.0, 20.25, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000822', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0401'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NETLIFY NETLIFY.COM CA 11/09',
    20.25, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0402', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-10',
    'Expense',
    'ADOBE *XXX-XXX-6687 ADOBE.LY/ENUS CA 11/11',
    0.0, 21.64, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000823', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0402'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ADOBE *XXX-XXX-6687 ADOBE.LY/ENUS CA 11/11',
    21.64, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0403', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-13',
    'Expense',
    'INTUIT *QBooks Onlin CL.INTUIT.COM CA 11/13',
    0.0, 69.29, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000824', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0403'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'INTUIT *QBooks Onlin CL.INTUIT.COM CA 11/13',
    69.29, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0404', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-15',
    'Expense',
    'TACTACAM WWW.REVEALCEL MN 11/15',
    0.0, 18.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000825', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0404'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TACTACAM WWW.REVEALCEL MN 11/15',
    9.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000826', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0404'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TACTACAM WWW.REVEALCEL MN 11/15',
    9.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0405', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-15',
    'Invoice',
    'Invoice - 2024-11-15',
    3498.33, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000827', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0405'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    3498.33, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0406', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-15',
    'Payment',
    'Payment - 2024-11-15',
    1210.52, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000828', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0406'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    1210.52, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0407', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-16',
    'Payment',
    'Payment - 2024-11-16',
    5114.93, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000829', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0407'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    3498.33, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000830', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0407'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    1616.6, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0408', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-19',
    'Expense',
    'CIRCLE K #XXX1403 ROSENBERG TX XX8454 11/19',
    0.0, 3241.14, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000831', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0408'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1403 ROSENBERG TX XX8454 11/19',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000832', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0408'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'HINZE COUNTRY KITCHEN WHARTON TX 11/19',
    83.14, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000833', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0408'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX6615 To Kebo Oil and Gas, INC 11/19',
    3128.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000834', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0408'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'H-E-B GAS #233 WHARTON TX XX1751 11/19',
    10.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0409', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-20',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX7305 11/20',
    0.0, 10.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000835', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0409'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX7305 11/20',
    10.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0410', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-21',
    'Expense',
    'BUC-EE''S #48 ENNIS TX 11/21',
    0.0, 123.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000836', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0410'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S #48 ENNIS TX 11/21',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000837', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0410'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S #26 MADISONVILLE TX 11/21',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000838', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0410'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CHEVRON XXX5974 HOUSTON TX 11/21',
    50.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000839', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0410'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'X1272 - DALLAS ON STREE DALLAS TX 11/21',
    3.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000840', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0410'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SP BUSH CENTER XXX-XXXX4300 TX 11/21',
    10.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0411', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-22',
    'Expense',
    'BUC-EE''S #40 KATY TX 11/22',
    0.0, 85.19, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000841', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0411'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'BUC-EE''S #40 KATY TX 11/22',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000842', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0411'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'COSTCO GAS #1167 KATY TX XX9453 11/22',
    65.19, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0412', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-29',
    'Expense',
    'ATT*BILL PAYMENT XXX-XXX-2020 TX 11/29',
    0.0, 280.93, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000843', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0412'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ATT*BILL PAYMENT XXX-XXX-2020 TX 11/29',
    280.93, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0413', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-02',
    'Expense',
    'NAPA MATHIS MATHIS TX 12/02',
    0.0, 312.95, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000844', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0413'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NAPA MATHIS MATHIS TX 12/02',
    104.41, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000845', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0413'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TACTACAM WWW.REVEALCEL MN 12/02',
    104.27, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000846', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0413'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TACTACAM WWW.REVEALCEL MN 12/02',
    104.27, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0414', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-04',
    'Expense',
    'SERVICE CHARGES FOR THE MONTH OF NOVEMBER',
    0.0, 1337.99, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000847', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0414'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SERVICE CHARGES FOR THE MONTH OF NOVEMBER',
    168.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000848', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0414'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CORPUS MM/GAS XX0273 CORPUS CHRIS TX XX9491 12/04',
    39.49, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000849', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0414'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX0351 To MartinLegal (_#####2006)',
    805.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000850', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0414'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CORPORATE FILINGS LLC XXX-XXX8466 WY 12/04',
    325.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0415', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-07',
    'Expense',
    'ARLO TECHNOLOGIES INC XXX-XXX-3750 CA 12/09',
    0.0, 8.52, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000851', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0415'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ARLO TECHNOLOGIES INC XXX-XXX-3750 CA 12/09',
    8.52, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0416', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-08',
    'Expense',
    'MCDONALD''S FX6227 CYPRESS TX 12/08',
    0.0, 42.66, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000852', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0416'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCDONALD''S FX6227 CYPRESS TX 12/08',
    7.66, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000853', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0416'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'STAR STOP 127 HOUSTON TX XX6567 12/08',
    35.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0417', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-09',
    'Deposit',
    'FEDWIRE CREDIT VIA: THIRD COAST BANK/XXXXX4149 B/O: MCKAIN POWER SYSTEMS CONSULTING LLCKATY TX XXXXX-0000 REF: CHASE NYC/CTR/BNF=10NETZERO, INC. HOUSTON TX 7709 X-6626 US/AC-XXXX0000 5231 RFB=O/B THIRD COAST IMAD: 1209MMQFMPGXXX0090 TRN: XXXXXX1344 FF',
    260234.83, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000854', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0417'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'FEDWIRE CREDIT VIA: THIRD COAST BANK/XXXXX4149 B/O: MCKAIN POWER SYSTEMS CONSULTING LLCKATY TX XXXXX-0000 REF: CHASE NYC/CTR/BNF=10NETZERO, INC. HOUSTON TX 7709 X-6626 US/AC-XXXX0000 5231 RFB=O/B THIRD COAST IMAD: 1209MMQFMPGXXX0090 TRN: XXXXXX1344 FF',
    260234.83, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0418', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-09',
    'Expense',
    'CHIPOTLE 1808 DALLAS TX 12/09',
    0.0, 94.87, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000855', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0418'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CHIPOTLE 1808 DALLAS TX 12/09',
    13.37, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000856', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0418'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NETLIFY NETLIFY.COM CA 12/09',
    40.5, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000857', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0418'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'QT 874 FORT WORTH TX 12/09',
    41.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0419', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-10',
    'Expense',
    'CHEVRON XXX4712 BELLVILLE TX 12/10',
    0.0, 25111.3, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000858', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0419'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CHEVRON XXX4712 BELLVILLE TX 12/10',
    74.66, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000859', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0419'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ADOBE *XXX-XXX-6687 ADOBE.LY/ENUS CA 12/11',
    21.64, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000860', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0419'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX2955 To Chiron (_#####8441)',
    25000.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000861', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0419'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'H-E-B GAS #577 HOUSTON TX XX3696 12/10',
    15.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0420', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-11',
    'Expense',
    'TST*COLLINAS ITALIAN CA Houston TX 12/11',
    0.0, 78.96, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000862', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0420'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TST*COLLINAS ITALIAN CA Houston TX 12/11',
    78.96, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0421', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-13',
    'Expense',
    'INTUIT *QBooks Onlin CL.INTUIT.COM CA 11/13',
    0.0, 812.4700000000001, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000863', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0421'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'INTUIT *QBooks Onlin CL.INTUIT.COM CA 11/13',
    69.29, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000864', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0421'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # X6979 REFUGIO TX XX0711 12/13',
    44.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000865', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0421'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'O''REILLY 1652 REFUGIO TX XX9702 12/13',
    93.29, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000866', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0421'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'SUNOCO XXXXXX2300 REFUGIO TX XX8000 12/13',
    50.39, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000867', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0421'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'O''REILLY 1652 REFUGIO TX XX0308 12/13',
    378.73, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000868', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0421'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'H-E-B #234 REFUGIO TX XX9523 12/13',
    2.52, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000869', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0421'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NAPA MATHIS MATHIS TX 12/13',
    100.65, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000870', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0421'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TST*SMOLIKS SMOKEHOUSE Mathis TX 12/13',
    26.51, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000871', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0421'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'STAR STOP 127 HOUSTON TX 12/13',
    37.09, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000872', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0421'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LA RIBERA TAQUERIA & RE REFUGIO TX 12/13',
    10.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0422', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-15',
    'Expense',
    'TACTACAM WWW.REVEALCEL MN 12/15',
    0.0, 18.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000873', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0422'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TACTACAM WWW.REVEALCEL MN 12/15',
    9.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000874', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0422'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TACTACAM WWW.REVEALCEL MN 12/15',
    9.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0423', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-16',
    'Invoice',
    'Invoice - 2024-12-16',
    3682.23, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000875', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0423'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    3682.23, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0424', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-16',
    'Expense',
    'Online Payment XXXXXXX5500 To Kebo Oil and Gas, INC 12/16',
    0.0, 1923.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000876', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0424'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX5500 To Kebo Oil and Gas, INC 12/16',
    1923.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0425', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-16',
    'Invoice',
    'Invoice - 2024-12-16',
    27602.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000877', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0425'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    27602.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0426', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-17',
    'Expense',
    'FSP*TEXAS GRIME DUMPS XXX-XXX-2979 TX 12/17',
    0.0, 412.97, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000878', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0426'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'FSP*TEXAS GRIME DUMPS XXX-XXX-2979 TX 12/17',
    412.97, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0427', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-17',
    'Journal Entry',
    '2month - RSU vested',
    0.0, 0.29, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000879', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0427'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-3160'),
    '2month - RSU vested',
    0.29, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0428', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-18',
    'Expense',
    'CIRCLE K # X6983 MATHIS TX XX7145 12/18',
    0.0, 32226.350000000002, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000880', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0428'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K # X6983 MATHIS TX XX7145 12/18',
    2.47, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000881', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0428'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'EXXON 7-ELEVEN X6525 VICTORIA TX 12/18',
    74.01, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000882', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0428'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TST*SMOLIKS SMOKEHOUSE Mathis TX 12/18',
    70.27, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000883', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0428'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX4752 To JohnSchillereff (_#####5067)',
    32066.79, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000884', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0428'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'H-E-B #234 REFUGIO TX XX5278 12/18',
    12.81, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0429', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-19',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX3913 12/19',
    0.0, 9725.5, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000885', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0429'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX3913 12/19',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000886', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0429'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'JACK IN THE BOX 3980 TOMBALL TX 12/19',
    8.43, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000887', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0429'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'INTIME CLAY HOUSTON TX XX1353 12/19',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000888', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0429'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WM SUPERCENTER #4512 KATY TX XX7603 12/19',
    59.94, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000889', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0429'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Basic Online Payroll Payment XXXXXXX6485 to #########4504',
    5033.04, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000890', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0429'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Basic Online Payroll Payment XXXXXXX6484 to ######3267',
    4574.09, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0430', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-20',
    'Expense',
    'MIDWEST HOSE - HOUSTO XXX-XXX-9092 TX 12/20',
    0.0, 193.82999999999998, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000891', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0430'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MIDWEST HOSE - HOUSTO XXX-XXX-9092 TX 12/20',
    188.42, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000892', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0430'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MIDWEST HOSE - HOUSTO XXX-XXX-9092 TX 12/20',
    5.41, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0431', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-23',
    'Expense',
    'EASY MART 2 CYPRESS TX 12/23',
    0.0, 66.68, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000893', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0431'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'EASY MART 2 CYPRESS TX 12/23',
    66.68, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0432', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-23',
    'Invoice',
    'Invoice - 2024-12-23',
    25000.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000894', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0432'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    25000.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0433', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-23',
    'Payment',
    'Payment - 2024-12-23',
    3682.23, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000895', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0433'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    3682.23, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0434', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-24',
    'Expense',
    'FSP*TEXAS GRIME DUMPS XXX-XXX-2979 TX 12/24',
    0.0, 56.3, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000896', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0434'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'FSP*TEXAS GRIME DUMPS XXX-XXX-2979 TX 12/24',
    56.3, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0435', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-24',
    'Payment',
    'Payment - 2024-12-24',
    52602.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000897', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0435'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    27602.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000898', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0435'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    '',
    25000.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0436', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-27',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX3674 12/26',
    0.0, 31.34, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000899', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0436'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX3674 12/26',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000900', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0436'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX1040 12/27',
    11.34, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0437', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-30',
    'Expense',
    'HARBOR FREIGHT TOOLS 5 HOUSTON TX XX1243 12/30',
    0.0, 673.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000901', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0437'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'HARBOR FREIGHT TOOLS 5 HOUSTON TX XX1243 12/30',
    197.18, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000902', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0437'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX6144 12/30',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000903', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0437'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'AUTOZONE 1477 X8764 T TOMBALL TX XX4270 12/30',
    173.19, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000904', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0437'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ATT*BILL PAYMENT XXX-XXX-2020 TX 12/30',
    242.91, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000905', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0437'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'POPEYES X3790 CYPRESS TX 12/30',
    24.99, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000906', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0437'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'AUTOZONE 1477 X8764 T TOMBALL TX XX8502 12/30',
    9.73, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0438', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-31',
    'Expense',
    'CIRCLE K #XXX2255 HOUSTON TX XX5867 12/31',
    0.0, 30.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000907', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0438'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX2255 HOUSTON TX XX5867 12/31',
    30.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0439', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-31',
    'Journal Entry',
    'Journal Entry - 2024-12-31',
    59008.0, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000908', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0439'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-8000'),
    '',
    59008.0, true
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0440', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-01',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX9221 01/01',
    0.0, 20.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000909', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0440'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX9221 01/01',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0441', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-02',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX4480 01/02',
    0.0, 22.310000000000002, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000910', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0441'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX4480 01/02',
    9.66, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000911', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0441'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'JACK IN THE BOX 3980 TOMBALL TX 01/02',
    12.65, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0442', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-03',
    'Expense',
    'Online ACH Payment XXXXXXX6184 To GTCrane (_#####3597)',
    0.0, 1915.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000912', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0442'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX6184 To GTCrane (_#####3597)',
    1890.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000913', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0442'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX6927 01/03',
    25.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0443', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-04',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX7996 01/04',
    0.0, 20.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000914', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0443'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX7996 01/04',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0444', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-05',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX9323 01/05',
    0.0, 13.44, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000915', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0444'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX9323 01/05',
    8.03, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000916', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0444'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCDONALDS F5181 TOMBALL TX 01/05',
    5.41, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0445', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-06',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX6917 01/06',
    0.0, 156.27, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000917', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0445'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX6917 01/06',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000918', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0445'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LOWE''S #1052 TOMBALL TX XX0749 01/06',
    115.72, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000919', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0445'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'H-E-B #577 HOUSTON TX XX7791 01/06',
    20.55, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0446', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-07',
    'Expense',
    'CIRCLE K #XXX1915 CYPRESS TX XX5630 01/07',
    0.0, 18.52, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000920', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0446'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX5630 01/07',
    10.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000921', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0446'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ARLO TECHNOLOGIES INC XXX-XXX-3750 CA 01/09',
    8.52, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0447', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-08',
    'Expense',
    'MURPHY EXPRESS 8669 TOMBALL TX XX2270 01/08',
    0.0, 12779.939999999999, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000922', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0447'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MURPHY EXPRESS 8669 TOMBALL TX XX2270 01/08',
    27.38, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000923', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0447'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CHEVRON XXX3521 TOMBALL TX 01/08',
    25.81, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000924', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0447'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX6388 To JohnSchillereff (_#####5067)',
    1200.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000925', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0447'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online Payment XXXXXXX7396 To Hard Core Supply LLC 01/08',
    95.26, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000926', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0447'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'PLANET THREE ELEVATI P3ELEVATION.C TX 01/08',
    4961.04, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000927', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0447'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LOWE''S #1052 TOMBALL TX XX7202 01/08',
    58.41, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000928', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0447'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ARBYS 8033 TOMBALL TX 01/08',
    13.63, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000929', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0447'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Online ACH Payment XXXXXXX6448 To JohnSchillereff (_#####5067)',
    600.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000930', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0447'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'Same-Day ACH Payment XXXXXXX6119 to JohnSchillereff (_#####5067)',
    5798.41, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0448', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-09',
    'Expense',
    'WHATABURGER 605 Q26 HOUSTON TX 01/09',
    0.0, 345.96000000000004, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000931', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0448'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WHATABURGER 605 Q26 HOUSTON TX 01/09',
    14.06, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000932', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0448'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'CIRCLE K #XXX1915 CYPRESS TX XX5324 01/09',
    20.0, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000933', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0448'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LA RIBERA TAQUERIA & RE REFUGIO TX 01/09',
    12.38, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000934', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0448'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TST*SMOLIKS SMOKEHOUSE Mathis TX 01/09',
    32.62, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000935', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0448'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'LOVE''S #0617 OUTSIDE HUNGERFORD TX XX9763 01/09',
    61.45, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000936', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0448'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NAPA MATHIS MATHIS TX 01/09',
    125.53, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000937', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0448'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'TEXAN # 8 VICTORIA VICTORIA TX XX9618 01/09',
    59.67, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000938', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0448'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'NETLIFY NETLIFY.COM CA 01/09',
    20.25, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0449', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-10',
    'Expense',
    'ORIG CO NAME:ROLLO INSURANCE ORIG ID:XXXXXX3381 DESC DATE: CO ENTRY DESCR:J2398 OOFFSEC:CCD TRACE#:XXXXXXXX7639738 EED:250110 IND ID:CZX0000BQ842C IND NAME:10NE TZERO INC TRN*1 *CZX0000BQ842C\RMR*IK*ROLLO IN SURANCE GROUP, INC\ TRN: XXXXXX9738 TC',
    0.0, 3692.5199999999995, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000939', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0449'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ORIG CO NAME:ROLLO INSURANCE ORIG ID:XXXXXX3381 DESC DATE: CO ENTRY DESCR:J2398 OOFFSEC:CCD TRACE#:XXXXXXXX7639738 EED:250110 IND ID:CZX0000BQ842C IND NAME:10NE TZERO INC TRN*1 *CZX0000BQ842C\RMR*IK*ROLLO IN SURANCE GROUP, INC\ TRN: XXXXXX9738 TC',
    3047.88, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000940', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0449'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'WM SUPERCENTER #4111 RICHMOND TX XX7779 01/10',
    48.31, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000941', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0449'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'ADOBE *XXX-XXX-6687 ADOBE.LY/ENUS CA 01/11',
    21.64, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000942', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0449'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'MCCOYS #96 EL CAMPO TX 01/10',
    493.45, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000943', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0449'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    'GARWOOD LUMBER COMPANY GARWOOD TX 01/10',
    81.24, false
) ON CONFLICT (line_id_display) DO NOTHING;

INSERT INTO public.journal_entries (
    entry_id_display, company_id, entry_date, entry_type, 
    description, total_debit, total_credit, is_posted
) VALUES (
    'JE-0450', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2025-01-10',
    'Invoice',
    'Invoice - 2025-01-10',
    11389.62, 0.0, true
) ON CONFLICT (entry_id_display) DO NOTHING;

INSERT INTO public.journal_lines (
    line_id_display, entry_id, account_id, 
    description, amount, is_debit
) VALUES (
    'JL-000944', 
    (SELECT id FROM journal_entries WHERE entry_id_display = 'JE-0450'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    '',
    11389.62, true
) ON CONFLICT (line_id_display) DO NOTHING;

