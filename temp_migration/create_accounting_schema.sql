-- Accounting Migration Schema for 10NetZero, Inc.
-- Integrates with existing FLRTS schema

-- 1. Companies table (for multi-company support)
CREATE TABLE IF NOT EXISTS public.companies (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  company_id_display character varying NOT NULL UNIQUE,
  name character varying NOT NULL,
  tax_id character varying,
  address_street character varying,
  address_city character varying,
  address_state character varying,
  address_zip character varying,
  phone character varying,
  email character varying,
  website character varying,
  fiscal_year_end character varying,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT companies_pkey PRIMARY KEY (id)
);

-- 2. Chart of Accounts
CREATE TABLE IF NOT EXISTS public.chart_of_accounts (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  account_id_display character varying NOT NULL UNIQUE,
  company_id uuid NOT NULL,
  account_number character varying NOT NULL,
  account_name character varying NOT NULL,
  account_type character varying NOT NULL CHECK (account_type IN ('Asset', 'Liability', 'Equity', 'Income', 'Expense')),
  account_subtype character varying,
  parent_account_id uuid,
  is_active boolean DEFAULT true,
  normal_balance character varying CHECK (normal_balance IN ('Debit', 'Credit')),
  opening_balance numeric DEFAULT 0,
  opening_balance_date date,
  description text,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT chart_of_accounts_pkey PRIMARY KEY (id),
  CONSTRAINT chart_of_accounts_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id),
  CONSTRAINT chart_of_accounts_parent_account_id_fkey FOREIGN KEY (parent_account_id) REFERENCES public.chart_of_accounts(id),
  CONSTRAINT unique_account_number_per_company UNIQUE (company_id, account_number)
);

-- 3. Accounting Customers (for true customers, not partners)
CREATE TABLE IF NOT EXISTS public.accounting_customers (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  customer_id_display character varying NOT NULL UNIQUE,
  company_id uuid NOT NULL,
  name character varying NOT NULL,
  full_name character varying,
  email character varying,
  phone character varying,
  billing_address text,
  shipping_address text,
  terms character varying,
  credit_limit numeric,
  is_active boolean DEFAULT true,
  quickbooks_id character varying,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT accounting_customers_pkey PRIMARY KEY (id),
  CONSTRAINT accounting_customers_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id)
);

-- 4. Accounting Employees (links to personnel)
CREATE TABLE IF NOT EXISTS public.accounting_employees (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  employee_id_display character varying NOT NULL UNIQUE,
  company_id uuid NOT NULL,
  personnel_id uuid,
  name character varying NOT NULL,
  email character varying,
  phone character varying,
  address text,
  is_active boolean DEFAULT true,
  quickbooks_id character varying,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT accounting_employees_pkey PRIMARY KEY (id),
  CONSTRAINT accounting_employees_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id),
  CONSTRAINT accounting_employees_personnel_id_fkey FOREIGN KEY (personnel_id) REFERENCES public.personnel(id)
);

-- 5. Journal Entries
CREATE TABLE IF NOT EXISTS public.journal_entries (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  journal_entry_id_display character varying NOT NULL UNIQUE,
  company_id uuid NOT NULL,
  entry_date date NOT NULL,
  transaction_type character varying,
  reference_number character varying,
  entity_type character varying CHECK (entity_type IN ('Customer', 'Vendor', 'Employee', 'Partner', 'Other', NULL)),
  entity_id uuid,
  entity_name character varying,
  memo text,
  is_adjusting_entry boolean DEFAULT false,
  is_closing_entry boolean DEFAULT false,
  quickbooks_txn_id character varying,
  created_by uuid,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT journal_entries_pkey PRIMARY KEY (id),
  CONSTRAINT journal_entries_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id),
  CONSTRAINT journal_entries_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.flrts_users(id)
);

-- 6. Journal Entry Lines
CREATE TABLE IF NOT EXISTS public.journal_entry_lines (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  journal_entry_id uuid NOT NULL,
  account_id uuid NOT NULL,
  line_number integer NOT NULL,
  debit numeric(15,2) DEFAULT 0,
  credit numeric(15,2) DEFAULT 0,
  description text,
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT journal_entry_lines_pkey PRIMARY KEY (id),
  CONSTRAINT journal_entry_lines_journal_entry_id_fkey FOREIGN KEY (journal_entry_id) REFERENCES public.journal_entries(id) ON DELETE CASCADE,
  CONSTRAINT journal_entry_lines_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.chart_of_accounts(id),
  CONSTRAINT check_debit_credit_not_both CHECK (NOT (debit > 0 AND credit > 0)),
  CONSTRAINT check_debit_credit_positive CHECK (debit >= 0 AND credit >= 0)
);

-- 7. General Ledger
CREATE TABLE IF NOT EXISTS public.general_ledger (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  company_id uuid NOT NULL,
  account_id uuid NOT NULL,
  journal_entry_id uuid,
  transaction_date date NOT NULL,
  transaction_type character varying,
  reference_number character varying,
  entity_name character varying,
  memo text,
  debit numeric(15,2) DEFAULT 0,
  credit numeric(15,2) DEFAULT 0,
  running_balance numeric(15,2),
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT general_ledger_pkey PRIMARY KEY (id),
  CONSTRAINT general_ledger_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id),
  CONSTRAINT general_ledger_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.chart_of_accounts(id),
  CONSTRAINT general_ledger_journal_entry_id_fkey FOREIGN KEY (journal_entry_id) REFERENCES public.journal_entries(id)
);

-- 8. Trial Balance Snapshots
CREATE TABLE IF NOT EXISTS public.trial_balance_snapshots (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  company_id uuid NOT NULL,
  account_id uuid NOT NULL,
  as_of_date date NOT NULL,
  debit_balance numeric(15,2) DEFAULT 0,
  credit_balance numeric(15,2) DEFAULT 0,
  net_balance numeric(15,2) DEFAULT 0,
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT trial_balance_snapshots_pkey PRIMARY KEY (id),
  CONSTRAINT trial_balance_snapshots_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id),
  CONSTRAINT trial_balance_snapshots_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.chart_of_accounts(id),
  CONSTRAINT unique_trial_balance_snapshot UNIQUE (company_id, account_id, as_of_date)
);

-- 9. Financial Statement Snapshots
CREATE TABLE IF NOT EXISTS public.financial_statement_snapshots (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  company_id uuid NOT NULL,
  statement_type character varying NOT NULL CHECK (statement_type IN ('balance_sheet', 'income_statement')),
  as_of_date date NOT NULL,
  account_id uuid NOT NULL,
  amount numeric(15,2) DEFAULT 0,
  line_item_order integer,
  parent_line_item character varying,
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT financial_statement_snapshots_pkey PRIMARY KEY (id),
  CONSTRAINT financial_statement_snapshots_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id),
  CONSTRAINT financial_statement_snapshots_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.chart_of_accounts(id)
);

-- Create indexes
CREATE INDEX idx_journal_entries_date ON public.journal_entries(entry_date);
CREATE INDEX idx_journal_entries_company ON public.journal_entries(company_id);
CREATE INDEX idx_general_ledger_date ON public.general_ledger(transaction_date);
CREATE INDEX idx_general_ledger_account ON public.general_ledger(account_id);
CREATE INDEX idx_chart_of_accounts_number ON public.chart_of_accounts(account_number);
CREATE INDEX idx_trial_balance_date ON public.trial_balance_snapshots(as_of_date);