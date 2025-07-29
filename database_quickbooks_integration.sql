-- QuickBooks Integration Schema Updates
-- Add QuickBooks-specific fields and tables to existing Supabase database

-- 1. Add QuickBooks sync fields to companies table
ALTER TABLE public.companies
ADD COLUMN IF NOT EXISTS quickbooks_company_id VARCHAR(255),
ADD COLUMN IF NOT EXISTS quickbooks_sync_token TEXT,
ADD COLUMN IF NOT EXISTS quickbooks_realm_id VARCHAR(255),
ADD COLUMN IF NOT EXISTS quickbooks_last_sync_at TIMESTAMP WITH TIME ZONE,
ADD COLUMN IF NOT EXISTS quickbooks_sync_enabled BOOLEAN DEFAULT false;

-- 2. QuickBooks OAuth tokens storage
CREATE TABLE IF NOT EXISTS public.quickbooks_auth (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  company_id uuid NOT NULL,
  realm_id VARCHAR(255) NOT NULL UNIQUE,
  access_token TEXT NOT NULL,
  refresh_token TEXT NOT NULL,
  token_expires_at TIMESTAMP WITH TIME ZONE NOT NULL,
  token_created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  CONSTRAINT quickbooks_auth_pkey PRIMARY KEY (id),
  CONSTRAINT quickbooks_auth_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id)
);

-- 3. QuickBooks webhook events log
CREATE TABLE IF NOT EXISTS public.quickbooks_webhook_events (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  event_id VARCHAR(255) UNIQUE,
  realm_id VARCHAR(255),
  event_type VARCHAR(100),
  entity_name VARCHAR(100),
  entity_id VARCHAR(255),
  operation VARCHAR(50),
  event_time TIMESTAMP WITH TIME ZONE,
  processed_at TIMESTAMP WITH TIME ZONE,
  processing_status VARCHAR(50) DEFAULT 'pending',
  error_message TEXT,
  payload JSONB,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  CONSTRAINT quickbooks_webhook_events_pkey PRIMARY KEY (id)
);

-- 4. QuickBooks sync mapping table
CREATE TABLE IF NOT EXISTS public.quickbooks_sync_mapping (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  company_id uuid NOT NULL,
  local_table VARCHAR(100) NOT NULL,
  local_id uuid NOT NULL,
  quickbooks_entity_type VARCHAR(100) NOT NULL,
  quickbooks_id VARCHAR(255) NOT NULL,
  quickbooks_sync_token VARCHAR(255),
  last_synced_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  sync_status VARCHAR(50) DEFAULT 'active',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  CONSTRAINT quickbooks_sync_mapping_pkey PRIMARY KEY (id),
  CONSTRAINT quickbooks_sync_mapping_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id),
  CONSTRAINT unique_quickbooks_mapping UNIQUE (company_id, local_table, local_id),
  CONSTRAINT unique_quickbooks_id UNIQUE (company_id, quickbooks_entity_type, quickbooks_id)
);

-- 5. QuickBooks sync queue for outbound changes
CREATE TABLE IF NOT EXISTS public.quickbooks_sync_queue (
  id uuid NOT NULL DEFAULT uuid_generate_v4(),
  company_id uuid NOT NULL,
  operation_type VARCHAR(50) NOT NULL, -- 'create', 'update', 'delete'
  entity_type VARCHAR(100) NOT NULL,
  entity_id uuid NOT NULL,
  quickbooks_id VARCHAR(255),
  payload JSONB NOT NULL,
  priority INTEGER DEFAULT 5,
  attempts INTEGER DEFAULT 0,
  max_attempts INTEGER DEFAULT 3,
  status VARCHAR(50) DEFAULT 'pending', -- 'pending', 'processing', 'completed', 'failed'
  error_message TEXT,
  scheduled_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  processed_at TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  CONSTRAINT quickbooks_sync_queue_pkey PRIMARY KEY (id),
  CONSTRAINT quickbooks_sync_queue_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id)
);

-- 6. Add QuickBooks fields to existing accounting tables
ALTER TABLE public.chart_of_accounts
ADD COLUMN IF NOT EXISTS quickbooks_account_id VARCHAR(255),
ADD COLUMN IF NOT EXISTS quickbooks_sync_token VARCHAR(255),
ADD COLUMN IF NOT EXISTS quickbooks_last_sync TIMESTAMP WITH TIME ZONE;

ALTER TABLE public.accounting_customers
ADD COLUMN IF NOT EXISTS quickbooks_customer_id VARCHAR(255),
ADD COLUMN IF NOT EXISTS quickbooks_sync_token VARCHAR(255),
ADD COLUMN IF NOT EXISTS quickbooks_last_sync TIMESTAMP WITH TIME ZONE;

ALTER TABLE public.accounting_employees  
ADD COLUMN IF NOT EXISTS quickbooks_employee_id VARCHAR(255),
ADD COLUMN IF NOT EXISTS quickbooks_sync_token VARCHAR(255),
ADD COLUMN IF NOT EXISTS quickbooks_last_sync TIMESTAMP WITH TIME ZONE;

ALTER TABLE public.journal_entries
ADD COLUMN IF NOT EXISTS quickbooks_journal_entry_id VARCHAR(255),
ADD COLUMN IF NOT EXISTS quickbooks_sync_token VARCHAR(255),
ADD COLUMN IF NOT EXISTS quickbooks_last_sync TIMESTAMP WITH TIME ZONE;

-- 7. Create indexes for performance
CREATE INDEX idx_quickbooks_webhook_events_realm_id ON public.quickbooks_webhook_events(realm_id);
CREATE INDEX idx_quickbooks_webhook_events_status ON public.quickbooks_webhook_events(processing_status);
CREATE INDEX idx_quickbooks_webhook_events_entity ON public.quickbooks_webhook_events(entity_name, entity_id);
CREATE INDEX idx_quickbooks_sync_mapping_local ON public.quickbooks_sync_mapping(local_table, local_id);
CREATE INDEX idx_quickbooks_sync_mapping_quickbooks ON public.quickbooks_sync_mapping(quickbooks_entity_type, quickbooks_id);
CREATE INDEX idx_quickbooks_sync_queue_status ON public.quickbooks_sync_queue(status, scheduled_at);
CREATE INDEX idx_quickbooks_sync_queue_entity ON public.quickbooks_sync_queue(entity_type, entity_id);

-- 8. Create RLS policies for QuickBooks tables
ALTER TABLE public.quickbooks_auth ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.quickbooks_webhook_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.quickbooks_sync_mapping ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.quickbooks_sync_queue ENABLE ROW LEVEL SECURITY;

-- Create service role policies (adjust based on your auth setup)
CREATE POLICY "Service role can manage QuickBooks auth" ON public.quickbooks_auth
  FOR ALL USING (true);

CREATE POLICY "Service role can manage webhook events" ON public.quickbooks_webhook_events
  FOR ALL USING (true);

CREATE POLICY "Service role can manage sync mappings" ON public.quickbooks_sync_mapping
  FOR ALL USING (true);

CREATE POLICY "Service role can manage sync queue" ON public.quickbooks_sync_queue
  FOR ALL USING (true);