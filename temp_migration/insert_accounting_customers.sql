-- Insert Accounting Customers (contractors/true customers)

INSERT INTO public.accounting_customers (
    customer_id_display, company_id, name, full_name, email, 
    billing_address, shipping_address, is_active
) VALUES (
    'CUST-001', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', 'Alpha Centauri Contractors',
    NULL,
    'ACCSA.statements@gmail.com',
    '1711 S. Laredo st
San Antonio TX 78207',
    '1711 S. Laredo st
San Antonio TX 78207',
    true
);
INSERT INTO public.accounting_customers (
    customer_id_display, company_id, name, full_name, email, 
    billing_address, shipping_address, is_active
) VALUES (
    'CUST-002', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', 'Asics Miners US',
    NULL,
    NULL,
    NULL,
    NULL,
    true
);
INSERT INTO public.accounting_customers (
    customer_id_display, company_id, name, full_name, email, 
    billing_address, shipping_address, is_active
) VALUES (
    'CUST-003', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', 'Ballard Law',
    NULL,
    NULL,
    NULL,
    NULL,
    true
);
INSERT INTO public.accounting_customers (
    customer_id_display, company_id, name, full_name, email, 
    billing_address, shipping_address, is_active
) VALUES (
    'CUST-004', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', 'HeatCore Inc',
    NULL,
    NULL,
    NULL,
    NULL,
    true
);
INSERT INTO public.accounting_customers (
    customer_id_display, company_id, name, full_name, email, 
    billing_address, shipping_address, is_active
) VALUES (
    'CUST-005', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', 'Upstream Data, LLC',
    'Daryl Willis',
    'daryl@upstreamdata.ca',
    NULL,
    NULL,
    true
);
INSERT INTO public.accounting_customers (
    customer_id_display, company_id, name, full_name, email, 
    billing_address, shipping_address, is_active
) VALUES (
    'CUST-006', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', 'Vibe Energy Systems LLC',
    NULL,
    NULL,
    NULL,
    NULL,
    true
);
