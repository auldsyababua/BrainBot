-- Journal Entries Final Batch 21

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0400', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-07',
    'Expense',
    '1005',
    NULL,
    'ARLO TECHNOLOGIES INC XXX-XXX-3750 CA 11/09'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0400'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 8.52,
    'ARLO TECHNOLOGIES INC XXX-XXX-3750 CA 11/09'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0400'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 649.0,
    'LEGALZOOM* TRADEMARK XXX-XXX0151 CA 11/07'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0401', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-09',
    'Expense',
    '1005',
    NULL,
    'NETLIFY NETLIFY.COM CA 11/09'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0401'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 20.25,
    'NETLIFY NETLIFY.COM CA 11/09'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0402', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-10',
    'Expense',
    '1005',
    'Adobe',
    'ADOBE *XXX-XXX-6687 ADOBE.LY/ENUS CA 11/11'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0402'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 21.64,
    'ADOBE *XXX-XXX-6687 ADOBE.LY/ENUS CA 11/11'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0403', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-13',
    'Expense',
    '1005',
    'QuickBooks Payments',
    'INTUIT *QBooks Onlin CL.INTUIT.COM CA 11/13'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0403'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 69.29,
    'INTUIT *QBooks Onlin CL.INTUIT.COM CA 11/13'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0404', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-15',
    'Expense',
    '1006',
    NULL,
    'TACTACAM WWW.REVEALCEL MN 11/15'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0404'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 9.0,
    'TACTACAM WWW.REVEALCEL MN 11/15'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0404'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 9.0,
    'TACTACAM WWW.REVEALCEL MN 11/15'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0405', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-15',
    'Invoice',
    '1006',
    'WasteWatt Ventures LLC',
    'Invoice - 2024-11-15'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0405'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1100'),
    1,
    3498.33, 0,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0406', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-15',
    'Payment',
    '1006',
    'WasteWatt Ventures LLC',
    'Payment - 2024-11-15'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0406'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    1210.52, 0,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0407', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-16',
    'Payment',
    '1006',
    'WasteWatt Ventures LLC',
    'Payment - 2024-11-16'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0407'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    3498.33, 0,
    ''
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0407'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    1616.6, 0,
    ''
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0408', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-19',
    'Expense',
    '1006',
    'Circle K',
    'CIRCLE K #XXX1403 ROSENBERG TX XX8454 11/19'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0408'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 20.0,
    'CIRCLE K #XXX1403 ROSENBERG TX XX8454 11/19'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0408'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 83.14,
    'HINZE COUNTRY KITCHEN WHARTON TX 11/19'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0408'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 3128.0,
    'Online Payment XXXXXXX6615 To Kebo Oil and Gas, INC 11/19'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0408'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 10.0,
    'H-E-B GAS #233 WHARTON TX XX1751 11/19'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0409', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-20',
    'Expense',
    '1006',
    'Circle K',
    'CIRCLE K #XXX1915 CYPRESS TX XX7305 11/20'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0409'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 10.0,
    'CIRCLE K #XXX1915 CYPRESS TX XX7305 11/20'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0410', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-21',
    'Expense',
    '1006',
    'Chevron',
    'BUC-EE''S #48 ENNIS TX 11/21'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0410'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 30.0,
    'BUC-EE''S #48 ENNIS TX 11/21'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0410'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 30.0,
    'BUC-EE''S #26 MADISONVILLE TX 11/21'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0410'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 50.0,
    'CHEVRON XXX5974 HOUSTON TX 11/21'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0410'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 3.0,
    'X1272 - DALLAS ON STREE DALLAS TX 11/21'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0410'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    5,
    0, 10.0,
    'SP BUSH CENTER XXX-XXXX4300 TX 11/21'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0411', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-22',
    'Expense',
    '1006',
    'Costco Gas',
    'BUC-EE''S #40 KATY TX 11/22'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0411'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 20.0,
    'BUC-EE''S #40 KATY TX 11/22'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0411'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 65.19,
    'COSTCO GAS #1167 KATY TX XX9453 11/22'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0412', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-11-29',
    'Expense',
    '1006',
    'AT&T',
    'ATT*BILL PAYMENT XXX-XXX-2020 TX 11/29'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0412'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 280.93,
    'ATT*BILL PAYMENT XXX-XXX-2020 TX 11/29'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0413', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-02',
    'Expense',
    '1006',
    NULL,
    'NAPA MATHIS MATHIS TX 12/02'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0413'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 104.41,
    'NAPA MATHIS MATHIS TX 12/02'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0413'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 104.27,
    'TACTACAM WWW.REVEALCEL MN 12/02'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0413'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 104.27,
    'TACTACAM WWW.REVEALCEL MN 12/02'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0414', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-04',
    'Expense',
    '1006',
    'Martin Legal PLLC',
    'SERVICE CHARGES FOR THE MONTH OF NOVEMBER'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0414'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 168.5,
    'SERVICE CHARGES FOR THE MONTH OF NOVEMBER'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0414'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 39.49,
    'CORPUS MM/GAS XX0273 CORPUS CHRIS TX XX9491 12/04'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0414'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 805.0,
    'Online ACH Payment XXXXXXX0351 To MartinLegal (_#####2006)'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0414'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 325.0,
    'CORPORATE FILINGS LLC XXX-XXX8466 WY 12/04'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0415', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-07',
    'Expense',
    '1006',
    NULL,
    'ARLO TECHNOLOGIES INC XXX-XXX-3750 CA 12/09'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0415'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 8.52,
    'ARLO TECHNOLOGIES INC XXX-XXX-3750 CA 12/09'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0416', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-08',
    'Expense',
    '1006',
    NULL,
    'MCDONALD''S FX6227 CYPRESS TX 12/08'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0416'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 7.66,
    'MCDONALD''S FX6227 CYPRESS TX 12/08'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0416'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 35.0,
    'STAR STOP 127 HOUSTON TX XX6567 12/08'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0417', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-09',
    'Deposit',
    '1006',
    'McKain Power Systems',
    'FEDWIRE CREDIT VIA: THIRD COAST BANK/XXXXX4149 B/O: MCKAIN POWER SYSTEMS CONSULTING LLCKATY TX XXXXX-0000 REF: CHASE NYC/CTR/BNF=10NETZERO, INC. HOUSTON TX 7709 X-6626 US/AC-XXXX0000 5231 RFB=O/B THIRD COAST IMAD: 1209MMQFMPGXXX0090 TRN: XXXXXX1344 FF'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0417'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    260234.83, 0,
    'FEDWIRE CREDIT VIA: THIRD COAST BANK/XXXXX4149 B/O: MCKAIN POWER SYSTEMS CONSULTING LLCKATY TX XXXXX-0000 REF: CHASE NYC/CTR/BNF=10NETZERO, INC. HOUSTON TX 7709 X-6626 US/AC-XXXX0000 5231 RFB=O/B THIRD COAST IMAD: 1209MMQFMPGXXX0090 TRN: XXXXXX1344 FF'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0418', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-09',
    'Expense',
    '1006',
    'Chipotle',
    'CHIPOTLE 1808 DALLAS TX 12/09'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0418'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 13.37,
    'CHIPOTLE 1808 DALLAS TX 12/09'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0418'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 40.5,
    'NETLIFY NETLIFY.COM CA 12/09'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0418'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 41.0,
    'QT 874 FORT WORTH TX 12/09'
);

INSERT INTO public.journal_entries (
    journal_entry_id_display, company_id, entry_date, transaction_type,
    reference_number, entity_name, memo
) VALUES (
    'JE-0419', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', '2024-12-10',
    'Expense',
    '1006',
    'Chevron',
    'CHEVRON XXX4712 BELLVILLE TX 12/10'
) ON CONFLICT (journal_entry_id_display) DO NOTHING;

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0419'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    1,
    0, 74.66,
    'CHEVRON XXX4712 BELLVILLE TX 12/10'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0419'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    2,
    0, 21.64,
    'ADOBE *XXX-XXX-6687 ADOBE.LY/ENUS CA 12/11'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0419'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    3,
    0, 25000.0,
    'Online ACH Payment XXXXXXX2955 To Chiron (_#####8441)'
);

INSERT INTO public.journal_entry_lines (
    journal_entry_id, account_id, line_number,
    debit, credit, description
) VALUES (
    (SELECT id FROM journal_entries WHERE journal_entry_id_display = 'JE-0419'),
    (SELECT id FROM chart_of_accounts WHERE account_id_display = 'ACC-1000'),
    4,
    0, 15.0,
    'H-E-B GAS #577 HOUSTON TX XX3696 12/10'
);

