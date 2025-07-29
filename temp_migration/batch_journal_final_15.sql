-- Journal Entries Final Batch 15

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0280', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-18',
    'Expense',
    '1140',
    'Adobe',
    'Claim reversal: ADOBE *XXX-XXX-6687 ADOBE.LY/ENUS CA 05/11 ClaimId: XXXXXXXXXXX0001'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0280'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 21.64,
    'Claim reversal: ADOBE *XXX-XXX-6687 ADOBE.LY/ENUS CA 05/11 ClaimId: XXXXXXXXXXX0001'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0281', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-19',
    'Expense',
    '1140',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX8989 06/19'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0281'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 15.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX8989 06/19'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0281'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 13.91,
    'CHIPOTLE 2794 TOMBALL TX 06/19'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0282', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-20',
    'Expense',
    '1140',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX8421 06/20'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0282'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 10.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX8421 06/20'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0282'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 246.96,
    'UNITED XXXXXXX7315 UNITED.COM TX 06/20'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0282'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 129.9,
    'SPYPOINT PREM-ANNUAL VICTORIAVILLE QC 06/20'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0282'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 129.9,
    'SPYPOINT PREM-ANNUAL VICTORIAVILLE QC 06/20'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0283', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-21',
    'Expense',
    '1140',
    'Pilot',
    'PILOT #472 BEASLEY TX XX0530 06/21'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0283'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 20.0,
    'PILOT #472 BEASLEY TX XX0530 06/21'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0284', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-22',
    'Expense',
    '1140',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX0442 06/22'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0284'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 10.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX0442 06/22'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0285', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-23',
    'Expense',
    '1140',
    NULL,
    'UNITED XXXXXXX3607 UNITED.COM TX 06/23'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0285'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 542.0,
    'UNITED XXXXXXX3607 UNITED.COM TX 06/23'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0285'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 89.99,
    'UNITED XXXXXXX9479 UNITED.COM TX 06/23'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0286', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-24',
    'Expense',
    '1140',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX8875 06/24'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0286'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 10.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX8875 06/24'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0287', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-25',
    'Expense',
    '1140',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX0566 06/25'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0287'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 15.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX0566 06/25'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0287'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 10.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX9067 06/25'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0288', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-26',
    'Expense',
    '1140',
    'Circle K',
    'CIRCLE K #XXX2255 HOUSTON TX XX1915 06/26'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0288'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 20.0,
    'CIRCLE K #XXX2255 HOUSTON TX XX1915 06/26'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0288'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 46.63,
    'HONEY FARMS #81 HOUSTON TX 06/26'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0288'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 248.16,
    'THE HOME DEPOT #6525 HOUSTON TX XX8568 06/26'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0289', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-27',
    'Expense',
    '1140',
    'Panda Express',
    'PANDA EXPRESS 1215 TOMBALL TX 06/27'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0289'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 13.1,
    'PANDA EXPRESS 1215 TOMBALL TX 06/27'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0289'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 478.95,
    'UNITED XXXXXXX5426 UNITED.COM TX 06/27'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0290', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-28',
    'Expense',
    '1140',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX2893 06/28'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0290'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 15.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX2893 06/28'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0291', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-06-30',
    'Expense',
    '1140',
    'Shell',
    'SHELL SERVICE STATION HOCKLEY TX XX9539 06/30'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0291'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 94.07,
    'SHELL SERVICE STATION HOCKLEY TX XX9539 06/30'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0291'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 429.0,
    'DELAWARE CORP & TAX W XXX-XXX-3073 DE 06/28'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0292', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-01',
    'Expense',
    '1140',
    'Adobe',
    'ADOBE *XXX-XXX-6687 ADOBE.LY/ENUS CA 07/02'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0292'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 4.71,
    'ADOBE *XXX-XXX-6687 ADOBE.LY/ENUS CA 07/02'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0292'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 246.17,
    'Online ACH Payment XXXXXXX5219 To Bernardo (_######3816)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0293', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-02',
    'Deposit',
    '1140',
    'WasteWatt Ventures LLC',
    'FEDWIRE CREDIT VIA: FIRST FINANCIAL BANK, N.A./XXXXX1122 B/O: WASTEWATT VENTUR FORT WORTH, TX XXXXX4071 REF: CHASE NYC/CTR/BNF=10NETZERO, INC. HOUSTON TX X7092- 6626 US/AC-XXXX0000 5231 RFB=#108 OBI=INVOICE 108 -180K W HASHUT GENERATOR AND 900KW HASHHU T IMAD: 0702MMQFMPXXXX0293 TRN: XXXXXX1184 FF'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0293'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    249290.0, 0,
    'FEDWIRE CREDIT VIA: FIRST FINANCIAL BANK, N.A./XXXXX1122 B/O: WASTEWATT VENTUR FORT WORTH, TX XXXXX4071 REF: CHASE NYC/CTR/BNF=10NETZERO, INC. HOUSTON TX X7092- 6626 US/AC-XXXX0000 5231 RFB=#108 OBI=INVOICE 108 -180K W HASHUT GENERATOR AND 900KW HASHHU T IMAD: 0702MMQFMPXXXX0293 TRN: XXXXXX1184 FF'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0294', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-02',
    'Expense',
    '1140',
    'Upstream Data',
    'ONLINE INTERNATIONAL WIRE TRANSFER VIA: BANK OF AMERICA, N.A./0959 A/C: TORONTO-DOMINION BANK, THE TORONTO CANADA M5K 1A2 CA BEN: UPSTREAM DATA INC LLOYDMINSTER AB T9V2X1 CA REF: BUSINESS EXPENSES SSN: XXXX8639 TRN: XXXXXX4184 ES 07/02'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0294'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 228986.69,
    'ONLINE INTERNATIONAL WIRE TRANSFER VIA: BANK OF AMERICA, N.A./0959 A/C: TORONTO-DOMINION BANK, THE TORONTO CANADA M5K 1A2 CA BEN: UPSTREAM DATA INC LLOYDMINSTER AB T9V2X1 CA REF: BUSINESS EXPENSES SSN: XXXX8639 TRN: XXXXXX4184 ES 07/02'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0295', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-03',
    'Expense',
    '1140',
    'Lowe''s',
    'CORPUS MM/GAS 0 CORPUS CHRIS TX 07/03'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0295'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 71.88,
    'CORPUS MM/GAS 0 CORPUS CHRIS TX 07/03'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0295'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 35.0,
    'SERVICE CHARGES FOR THE MONTH OF JUNE'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0295'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 28.94,
    'TST* SMOLIKS SMOKEHOUSE Mathis TX 07/03'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0295'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 154.54,
    'NAPA MATHIS MATHIS TX 07/03'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0295'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 7.57,
    'NAPA MATHIS MATHIS TX 07/03'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0295'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 203.4,
    'LOWE''S #1825 CORPUS CHRSTI TX XX4487 07/03'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0296', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-06',
    'Expense',
    '1140',
    'Walmart',
    'ORIG CO NAME:IPFSXXX-XXX-2621 ORIG ID:0 ADXXX4370 DESC DATE: CO ENTRY DESCR:IPFSPMTTXPSEC:CCD TRACE#:XXXXXXXX1311125 EED:240708 IND ID:62397 IND NAME:10 NET ZERO INC. GDxLk2vV TRN: XXXXXX1125 TC'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0296'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 559.66,
    'ORIG CO NAME:IPFSXXX-XXX-2621 ORIG ID:0 ADXXX4370 DESC DATE: CO ENTRY DESCR:IPFSPMTTXPSEC:CCD TRACE#:XXXXXXXX1311125 EED:240708 IND ID:62397 IND NAME:10 NET ZERO INC. GDxLk2vV TRN: XXXXXX1125 TC'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0296'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 91.92,
    'WM SUPERCENTER #4111 RICHMOND TX XX3060 07/06'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0297', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-07',
    'Expense',
    '1140',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX3725 07/07'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0297'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 10.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX3725 07/07'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0297'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 8.66,
    'MINUTEKEY BOULDER CO 07/07'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0297'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 231.64,
    'BEST BUY XXXX5172 RICHMOND TX 07/07'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0298', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-08',
    'Expense',
    '1140',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX0469 07/08'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0298'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 10.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX0469 07/08'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0298'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 8.52,
    'ARLO TECHNOLOGIES INC XXX-XXX-3750 CA 07/09'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0299', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-09',
    'Expense',
    '1140',
    'Jack in the Box',
    'JACK IN THE BOX 3901 HOUSTON TX 07/09'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0299'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 15.35,
    'JACK IN THE BOX 3901 HOUSTON TX 07/09'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0299'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 20.25,
    'NETLIFY HTTPSWWW.NETL CA 07/09'
);

