-- Journal Entries Final Batch 17

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0320', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-07-31',
    'Expense',
    '11',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX9874 07/31'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0320'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 15.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX9874 07/31'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0320'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 55.67,
    'WAL-MART #0703 TOMBALL TX XX0171 07/31'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0321', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-01',
    'Expense',
    '11',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX0323 08/01'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0321'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 14.17,
    'CIRCLE K #XXX1915 CYPRESS TX XX0323 08/01'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0321'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 40.59,
    'CIRCLE K #XXX1906 COLLEGE STATI TX XX1902 08/01'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0321'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 10.06,
    'MCDONALD''S FX2848 NAVASOTA TX 08/01'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0321'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 13.91,
    'CHIPOTLE 2794 TOMBALL TX 07/31'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0321'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 66.44,
    'GRAINGER XXX-XXX4643 IL 07/31'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0322', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-02',
    'Expense',
    '11',
    NULL,
    'APACHE OIL COMPANY PASADENA TX 08/02'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0322'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 1140.87,
    'APACHE OIL COMPANY PASADENA TX 08/02'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0323', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-05',
    'Deposit',
    '11',
    NULL,
    'FEDWIRE CREDIT VIA: FIRST FINANCIAL BANK/XXXXX1122 B/O: WASTEWATT VENTUR FORT WORTH, TX XXXXX4071 REF: CHASE NYC/CTR/BNF=10NETZERO, INC. HOUSTON TX XXXXX-6626 U S/AC-XXXX0000 5231 RFB=O/B FFIN ABILENE IMAD: 0805MMQFMPXXXX0012 TRN: XXXXXX1218 FF'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0323'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    20000.0, 0,
    'FEDWIRE CREDIT VIA: FIRST FINANCIAL BANK/XXXXX1122 B/O: WASTEWATT VENTUR FORT WORTH, TX XXXXX4071 REF: CHASE NYC/CTR/BNF=10NETZERO, INC. HOUSTON TX XXXXX-6626 U S/AC-XXXX0000 5231 RFB=O/B FFIN ABILENE IMAD: 0805MMQFMPXXXX0012 TRN: XXXXXX1218 FF'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0324', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-05',
    'Expense',
    '11',
    'Shell',
    'SHELL SERVICE STATION EAST BERNARD TXXX2760 08/05'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0324'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 91.51,
    'SHELL SERVICE STATION EAST BERNARD TXXX2760 08/05'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0324'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 80.28,
    'SHELL OIL XXXXXXX1528 EAST BERNARD TX 08/05'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0324'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 20.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX9032 08/05'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0324'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 30.0,
    'BUC-EE''S #30 WHARTON TX 08/05'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0324'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 75.0,
    'SERVICE CHARGES FOR THE MONTH OF JULY'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0324'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 62.81,
    'TST*SMOLIKS SMOKEHOUSE Mathis TX 08/05'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0324'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    7,
    0, 259.75,
    'O''REILLY 1652 REFUGIO TX XX9484 08/05'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0324'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    8,
    0, 40.0,
    'Gas'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0325', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-05',
    'Journal Entry',
    'DH38',
    NULL,
    'Journal Entry - 2024-08-05'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0325'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1300'),
    1,
    0, 18216.89,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0326', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-06',
    'Deposit',
    'DH38',
    'Zapata II, LLC',
    'Online Transfer from CHK ...5317 transaction#: XXXXXXX1342'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0326'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    18820.0, 0,
    'Online Transfer from CHK ...5317 transaction#: XXXXXXX1342'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0327', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-06',
    'Expense',
    'DH38',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX3866 08/06'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0327'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 15.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX3866 08/06'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0327'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 20.65,
    'CIRCLE K #XXX1487 CYPRESS TX XX3296 08/06'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0327'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 559.66,
    'ORIG CO NAME:IPFSXXX-XXX-2621 ORIG ID:0 ADXXX4370 DESC DATE: CO ENTRY DESCR:IPFSPMTTXPSEC:CCD TRACE#:XXXXXXXX2177554 EED:240806 IND ID:62397 IND NAME:10 NET ZERO INC. GDxLk2vV TRN: XXXXXX7554 TC'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0327'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 6644.0,
    'Online ACH Payment XXXXXXX9619 To JohnSchillereff (_#####5067)'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0327'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 1920.0,
    'Online ACH Payment XXXXXXX0877 To BarbeeCrane (_##4802)'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0327'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    6,
    0, 16900.0,
    'Online ACH Payment XXXXXXX6567 To JoeSingleSourceLufkin (_#####6386)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0328', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-07',
    'Deposit',
    'DH38',
    NULL,
    'BEST BUY MHT XXXX4134 CYPRESS TX 08/07'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0328'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    216.49, 0,
    'BEST BUY MHT XXXX4134 CYPRESS TX 08/07'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0329', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-07',
    'Expense',
    'DH38',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX4757 08/07'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0329'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 15.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX4757 08/07'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0329'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 216.49,
    'BEST BUY XXXX5172 RICHMOND TX XX2095 08/07'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0330', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-08',
    'Expense',
    'DH38',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX8093 08/08'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0330'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 6.5,
    'CIRCLE K #XXX1915 CYPRESS TX XX8093 08/08'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0330'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 20.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX4948 08/08'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0330'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 8.52,
    'ARLO TECHNOLOGIES INC XXX-XXX-3750 CA 08/09'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0331', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-09',
    'Expense',
    'DH38',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX1289 08/09'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0331'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 20.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX1289 08/09'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0331'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 40.05,
    'SOUTHWELLS HAMBURGER G HOUSTON TX 08/09'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0331'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 14.75,
    'TST* KIRBY ICE HOUSE - HOUSTON TX 08/10'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0331'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 20.25,
    'NETLIFY HTTPSWWW.NETL CA 08/09'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0331'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 760.65,
    'Online ACH Payment XXXXXXX4299 To Bernardo (_######3816)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0332', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-10',
    'Expense',
    'DH38',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX5860 08/10'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0332'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 20.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX5860 08/10'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0332'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 10.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX9378 08/10'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0332'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 4.05,
    'MCDONALD''S FX9431 CYPRESS TX 08/10'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0332'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 21.64,
    'ADOBE *XXX-XXX-6687 ADOBE.LY/ENUS CA 08/11'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0333', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-11',
    'Expense',
    'DH38',
    NULL,
    '9235 CLAY ROAD BUSINES HOUSTON TX XX3906 08/11'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0333'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 20.01,
    '9235 CLAY ROAD BUSINES HOUSTON TX XX3906 08/11'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0334', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-12',
    'Expense',
    'DH38',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX8419 08/12'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0334'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 11.69,
    'CIRCLE K #XXX1915 CYPRESS TX XX8419 08/12'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0334'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 20.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX5727 08/12'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0334'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 6.5,
    'MCDONALD''S FX9431 CYPRESS TX 08/12'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0334'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 60.98,
    'GRAINGER XXX-XXX4643 IL 08/12'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0335', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-13',
    'Expense',
    'DH38',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX5821 08/13'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0335'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 9.09,
    'CIRCLE K #XXX1915 CYPRESS TX XX5821 08/13'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0335'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 14.94,
    'PANDA EXPRESS #1900 HOUSTON TX 08/13'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0335'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 500.0,
    'ATT*BILL PAYMENT XXX-XXX-2020 TX 08/13'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0335'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 2022.5,
    'Online ACH Payment XXXXXXX6184 To GTCrane (_#####3597)'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0336', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-14',
    'Deposit',
    'DH38',
    NULL,
    'BOOK TRANSFER CREDIT B/O: ENGINEERED FLUIDS, INC. ST PETERSBURG FL XXXXX-2704 US REF: INV. 152 TRN: XXXXXX4227 ES'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0336'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    24000.0, 0,
    'BOOK TRANSFER CREDIT B/O: ENGINEERED FLUIDS, INC. ST PETERSBURG FL XXXXX-2704 US REF: INV. 152 TRN: XXXXXX4227 ES'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0337', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-14',
    'Expense',
    'DH38',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX9406 08/14'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0337'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 20.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX9406 08/14'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0337'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 6.5,
    'MCDONALD''S FX9431 CYPRESS TX 08/14'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0338', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-15',
    'Expense',
    'DH38',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX8393 08/15'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0338'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 5.19,
    'CIRCLE K #XXX1915 CYPRESS TX XX8393 08/15'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0338'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 67.6,
    'FESCO LTD XXXXXX7000X15 TX 08/15'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0338'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 67.6,
    'FESCO LTD XXXXXX7000X15 TX 08/15'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0339', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-08-16',
    'Deposit',
    'DH38',
    'Zapata II, LLC',
    'Online Transfer from CHK ...5317 transaction#: XXXXXXX4554'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0339'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    50000.0, 0,
    'Online Transfer from CHK ...5317 transaction#: XXXXXXX4554'
);

