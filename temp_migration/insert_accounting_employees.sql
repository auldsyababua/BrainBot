-- Insert Accounting Employees
-- TODO: Match these with existing personnel records

-- Employee: Colin Aulds
-- MATCHES: personnel id 5f916b38-fddc-49b2-893b-1dc6ff7d4ee7 (colin)
INSERT INTO public.accounting_employees (
    employee_id_display, company_id, name, email, phone, address, is_active
    -- TODO: Add personnel_id after confirming matches
) VALUES (
    'EMP-002', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', 'Colin Aulds',
    NULL,
    NULL,
    NULL,
    true
);

-- Employee: Joel Fulford
INSERT INTO public.accounting_employees (
    employee_id_display, company_id, name, email, phone, address, is_active
    -- TODO: Add personnel_id after confirming matches
) VALUES (
    'EMP-003', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', 'Joel Fulford',
    'Joel@10netzero.com',
    NULL,
    NULL,
    true
);

-- Employee: Phillip Stanley
INSERT INTO public.accounting_employees (
    employee_id_display, company_id, name, email, phone, address, is_active
    -- TODO: Add personnel_id after confirming matches
) VALUES (
    'EMP-004', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', 'Phillip Stanley',
    NULL,
    NULL,
    NULL,
    true
);

-- Employee: S Bryan Aulds
INSERT INTO public.accounting_employees (
    employee_id_display, company_id, name, email, phone, address, is_active
    -- TODO: Add personnel_id after confirming matches
) VALUES (
    'EMP-005', '4e3daa5f-9015-4ae8-a79c-620ccc45757f', 'S Bryan Aulds',
    NULL,
    NULL,
    NULL,
    true
);

