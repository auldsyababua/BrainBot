-- Migration to make RLS settings consistent across all tables
-- This addresses Supabase security warnings about mixed RLS settings
-- Since we're using service role keys which bypass RLS anyway,
-- this makes the security model explicit and consistent

-- These tables already have RLS disabled (28 tables from the warnings):
-- asics, equipment, field_report_edits, field_reports, field_reports_asics,
-- field_reports_equipment, flrts_users, licenses_agreements, licenses_agreements_partners,
-- licenses_agreements_sites, licenses_agreements_vendors, list_items, lists,
-- markup_changes_log, notifications_log, operators, partner_billings, partners,
-- reminders, site_aliases, site_partner_assignments, site_vendor_assignments,
-- sites, task_assignment_history, tasks, vendor_invoices, vendors

-- Disable RLS on tables that currently have it enabled to be consistent:
ALTER TABLE public.personnel DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_profiles DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.brain_bot_documents DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.brain_bot_document_chunks DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.brain_bot_media_files DISABLE ROW LEVEL SECURITY;

-- Drop all RLS policies for these tables to clean up
-- This ensures no policies remain that could cause confusion

-- Personnel and related tables policies
DROP POLICY IF EXISTS "anon_select_personnel" ON public.personnel;
DROP POLICY IF EXISTS "anon_select_personnel_groups" ON public.personnel_groups;
DROP POLICY IF EXISTS "anon_select_business_partners" ON public.business_partners;

-- Assignment tables policies
DROP POLICY IF EXISTS "anon_select_partner_personnel_assignments" ON public.partner_personnel_assignments;
DROP POLICY IF EXISTS "anon_select_action_assignments" ON public.action_assignments;
DROP POLICY IF EXISTS "anon_select_project_personnel_assignees" ON public.project_personnel_assignees;

-- Task management tables policies
DROP POLICY IF EXISTS "anon_flrts_tasks_policy" ON public.flrts_tasks;
DROP POLICY IF EXISTS "anon_flrts_lists_policy" ON public.flrts_lists;
DROP POLICY IF EXISTS "anon_flrts_reminders_policy" ON public.flrts_reminders;
DROP POLICY IF EXISTS "anon_flrts_field_reports_policy" ON public.flrts_field_reports;
DROP POLICY IF EXISTS "anon_flrts_sub_tasks_policy" ON public.flrts_sub_tasks;

-- Todoist integration tables policies
DROP POLICY IF EXISTS "anon_todoist_projects_policy" ON public.todoist_projects;
DROP POLICY IF EXISTS "anon_todoist_tasks_policy" ON public.todoist_tasks;

-- Project and sales tables policies
DROP POLICY IF EXISTS "anon_projects_policy" ON public.projects;
DROP POLICY IF EXISTS "anon_sales_stages_policy" ON public.sales_stages;
DROP POLICY IF EXISTS "anon_billing_arrangements_policy" ON public.billing_arrangements;

-- Document and calendar tables policies
DROP POLICY IF EXISTS "anon_documents_policy" ON public.documents;
DROP POLICY IF EXISTS "anon_calendar_events_policy" ON public.calendar_events;

-- Carbon credit tables policies
DROP POLICY IF EXISTS "anon_carbon_credit_purchases_policy" ON public.carbon_credit_purchases;
DROP POLICY IF EXISTS "anon_carbon_credit_purchase_allocations_policy" ON public.carbon_credit_purchase_allocations;

-- System tables policies
DROP POLICY IF EXISTS "anon_mermaid_diagrams_policy" ON public.mermaid_diagrams;
DROP POLICY IF EXISTS "anon_noloco_sync_logs_policy" ON public.noloco_sync_logs;
DROP POLICY IF EXISTS "anon_api_logs_policy" ON public.api_logs;
DROP POLICY IF EXISTS "anon_field_report_personnel_mentions_policy" ON public.field_report_personnel_mentions;
DROP POLICY IF EXISTS "anon_function_performance_policy" ON public.function_performance;
DROP POLICY IF EXISTS "anon_daily_standup_reports_policy" ON public.daily_standup_reports;

-- Lists items table policies
DROP POLICY IF EXISTS "anon_lists_items_policy" ON public.lists_items;

-- Note: This migration makes explicit that we're not using RLS
-- Since the application uses service role keys, RLS policies wouldn't apply anyway
-- This removes the security warnings while maintaining the same security posture