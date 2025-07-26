-- Database Schema Updates for FLRTS Forms Integration
-- Run these migrations to support the new UI form fields

-- =====================================================
-- FIELD REPORTS TABLE UPDATES
-- =====================================================

-- =====================================================
-- USER TABLE CONSOLIDATION
-- =====================================================

-- First, ensure personnel table has all necessary fields
ALTER TABLE personnel 
ADD COLUMN IF NOT EXISTS email VARCHAR(255),
ADD COLUMN IF NOT EXISTS username VARCHAR(100),
ADD COLUMN IF NOT EXISTS password_hash VARCHAR(255),
ADD COLUMN IF NOT EXISTS is_active BOOLEAN DEFAULT TRUE,
ADD COLUMN IF NOT EXISTS created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
ADD COLUMN IF NOT EXISTS last_login TIMESTAMP WITH TIME ZONE;

-- Migrate data from flrts_users to personnel (if needed)
-- This assumes personnel records already exist and we're just adding missing fields
-- UPDATE personnel SET email = fu.email FROM flrts_users fu WHERE personnel.flrts_user_id = fu.id;

-- Migrate data from user_profiles to personnel (if needed)
-- UPDATE personnel SET username = up.username FROM user_profiles up WHERE personnel.user_profile_id = up.id;

-- =====================================================
-- UPDATE ALL FOREIGN KEY REFERENCES
-- =====================================================

-- Add new fields to field_reports table (referencing personnel instead of flrts_users)
ALTER TABLE field_reports 
ADD COLUMN IF NOT EXISTS report_date DATE DEFAULT CURRENT_DATE,
ADD COLUMN IF NOT EXISTS report_id_display VARCHAR(50) UNIQUE,
ADD COLUMN IF NOT EXISTS submission_timestamp TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
ADD COLUMN IF NOT EXISTS last_modified_timestamp TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
ADD COLUMN IF NOT EXISTS submitted_by_user_id UUID REFERENCES personnel(id);

-- Create trigger to auto-update last_modified_timestamp
CREATE OR REPLACE FUNCTION update_last_modified_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.last_modified_timestamp = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER field_reports_update_timestamp
    BEFORE UPDATE ON field_reports
    FOR EACH ROW
    EXECUTE FUNCTION update_last_modified_timestamp();

-- Create function to generate unique report_id_display
CREATE OR REPLACE FUNCTION generate_report_id_display()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.report_id_display IS NULL THEN
        NEW.report_id_display = 'FR-' || TO_CHAR(NOW(), 'YYYYMMDD') || '-' || LPAD(NEXTVAL('report_id_seq')::TEXT, 4, '0');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create sequence for report IDs
CREATE SEQUENCE IF NOT EXISTS report_id_seq START 1;

CREATE TRIGGER field_reports_generate_id
    BEFORE INSERT ON field_reports
    FOR EACH ROW
    EXECUTE FUNCTION generate_report_id_display();

-- =====================================================
-- JUNCTION TABLES FOR FIELD REPORTS
-- =====================================================

-- Junction table for field reports and ASICs
CREATE TABLE IF NOT EXISTS field_reports_asics (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    field_report_id UUID NOT NULL REFERENCES field_reports(id) ON DELETE CASCADE,
    asic_id UUID NOT NULL REFERENCES asics(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(field_report_id, asic_id)
);

-- Junction table for field reports and equipment
CREATE TABLE IF NOT EXISTS field_reports_equipment (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    field_report_id UUID NOT NULL REFERENCES field_reports(id) ON DELETE CASCADE,
    equipment_id UUID NOT NULL REFERENCES equipment(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(field_report_id, equipment_id)
);

-- =====================================================
-- LISTS TABLE UPDATES
-- =====================================================

-- Add new fields to lists table (referencing personnel instead of flrts_users)
ALTER TABLE lists 
ADD COLUMN IF NOT EXISTS site_id UUID REFERENCES sites(id),
ADD COLUMN IF NOT EXISTS description TEXT CHECK (LENGTH(description) <= 150),
ADD COLUMN IF NOT EXISTS owner_user_id UUID REFERENCES personnel(id),
ADD COLUMN IF NOT EXISTS is_master_sop_list BOOLEAN DEFAULT FALSE;

-- Update status field to use new enum values
DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'list_status_enum') THEN
        CREATE TYPE list_status_enum AS ENUM ('Active', 'Archived');
    END IF;
END $$;

-- Add status column if it doesn't exist, or update existing
ALTER TABLE lists 
ADD COLUMN IF NOT EXISTS status list_status_enum DEFAULT 'Active';

-- =====================================================
-- TASKS TABLE UPDATES  
-- =====================================================

-- Add new fields to tasks table (referencing personnel instead of flrts_users)
ALTER TABLE tasks 
ADD COLUMN IF NOT EXISTS reminder_time TIMESTAMP WITH TIME ZONE,
ADD COLUMN IF NOT EXISTS due_at TIMESTAMP WITH TIME ZONE,
ADD COLUMN IF NOT EXISTS related_field_report_id UUID REFERENCES field_reports(id),
ADD COLUMN IF NOT EXISTS priority VARCHAR(10) CHECK (priority IN ('High', 'Medium', 'Low')) DEFAULT 'Medium',
ADD COLUMN IF NOT EXISTS parent_task_id UUID REFERENCES tasks(id),
ADD COLUMN IF NOT EXISTS task_id_display VARCHAR(50) UNIQUE,
ADD COLUMN IF NOT EXISTS submission_timestamp TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
ADD COLUMN IF NOT EXISTS last_modified_timestamp TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
ADD COLUMN IF NOT EXISTS submitted_by_user_id UUID REFERENCES personnel(id);

-- Note: Future date constraints are not applied to existing data
-- These would be enforced at the application level for new tasks
-- Uncomment the following lines if you want strict database-level validation:
-- ALTER TABLE tasks 
-- ADD CONSTRAINT reminder_time_future CHECK (reminder_time IS NULL OR reminder_time > NOW()),
-- ADD CONSTRAINT due_at_future CHECK (due_at IS NULL OR due_at > NOW());

-- Drop existing views that reference the tasks table before altering column types
DROP VIEW IF EXISTS tasks_with_details;
DROP VIEW IF EXISTS field_reports_with_details;
DROP VIEW IF EXISTS lists_with_details;
DROP VIEW IF EXISTS tasks_view;  -- Drop any other existing task views

-- Update status enum to include new values
DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'task_status_enum_new') THEN
        CREATE TYPE task_status_enum_new AS ENUM ('To Do', 'In Progress', 'Completed', 'Blocked', 'Cancelled', 'Reassigned');
    END IF;
END $$;

-- Migrate existing status values and update column type
-- First, drop the existing default constraint
ALTER TABLE tasks ALTER COLUMN status DROP DEFAULT;

-- Then alter the column type with explicit casting and mapping
ALTER TABLE tasks 
ALTER COLUMN status TYPE task_status_enum_new 
USING (
    CASE 
        WHEN status IS NULL THEN 'To Do'::task_status_enum_new
        WHEN status::text = 'todo' THEN 'To Do'::task_status_enum_new
        WHEN status::text = 'in_progress' THEN 'In Progress'::task_status_enum_new
        WHEN status::text = 'completed' THEN 'Completed'::task_status_enum_new
        WHEN status::text = 'blocked' THEN 'Blocked'::task_status_enum_new
        WHEN status::text = 'cancelled' THEN 'Cancelled'::task_status_enum_new
        WHEN status::text = 'reassigned' THEN 'Reassigned'::task_status_enum_new
        -- Handle any existing exact matches
        WHEN status::text = 'To Do' THEN 'To Do'::task_status_enum_new
        WHEN status::text = 'In Progress' THEN 'In Progress'::task_status_enum_new
        WHEN status::text = 'Completed' THEN 'Completed'::task_status_enum_new
        WHEN status::text = 'Blocked' THEN 'Blocked'::task_status_enum_new
        WHEN status::text = 'Cancelled' THEN 'Cancelled'::task_status_enum_new
        WHEN status::text = 'Reassigned' THEN 'Reassigned'::task_status_enum_new
        -- Default fallback
        ELSE 'To Do'::task_status_enum_new
    END
);

-- Set new default value
ALTER TABLE tasks ALTER COLUMN status SET DEFAULT 'To Do';

-- =====================================================
-- UPDATE EXISTING FOREIGN KEY REFERENCES TO PERSONNEL
-- =====================================================

-- Update existing tasks table foreign keys to reference personnel
-- First, we need to update existing data (if any exists)
-- This assumes there's a mapping between existing user references and personnel records

-- Update assigned_to_user_id references (if they currently reference flrts_users)
-- You may need to adjust this based on your current schema:
-- UPDATE tasks SET assigned_to_user_id = p.id 
-- FROM personnel p 
-- WHERE tasks.assigned_to_user_id = p.flrts_user_id;

-- Update created_by_user_id references (if they currently reference flrts_users)
-- UPDATE tasks SET created_by_user_id = p.id 
-- FROM personnel p 
-- WHERE tasks.created_by_user_id = p.flrts_user_id;

-- Drop and recreate foreign key constraints to reference personnel table
-- (Only if the existing constraints reference other tables)
-- ALTER TABLE tasks DROP CONSTRAINT IF EXISTS tasks_assigned_to_user_id_fkey;
-- ALTER TABLE tasks ADD CONSTRAINT tasks_assigned_to_user_id_fkey 
--     FOREIGN KEY (assigned_to_user_id) REFERENCES personnel(id);

-- ALTER TABLE tasks DROP CONSTRAINT IF EXISTS tasks_created_by_user_id_fkey;
-- ALTER TABLE tasks ADD CONSTRAINT tasks_created_by_user_id_fkey 
--     FOREIGN KEY (created_by_user_id) REFERENCES personnel(id);

-- Update task_assignment_history table to reference personnel
-- ALTER TABLE task_assignment_history DROP CONSTRAINT IF EXISTS task_assignment_history_assigned_to_user_id_fkey;
-- ALTER TABLE task_assignment_history ADD CONSTRAINT task_assignment_history_assigned_to_user_id_fkey 
--     FOREIGN KEY (assigned_to_user_id) REFERENCES personnel(id);

-- ALTER TABLE task_assignment_history DROP CONSTRAINT IF EXISTS task_assignment_history_assigned_by_user_id_fkey;
-- ALTER TABLE task_assignment_history ADD CONSTRAINT task_assignment_history_assigned_by_user_id_fkey 
--     FOREIGN KEY (assigned_by_user_id) REFERENCES personnel(id);

-- Create trigger for tasks timestamp updates
CREATE TRIGGER tasks_update_timestamp
    BEFORE UPDATE ON tasks
    FOR EACH ROW
    EXECUTE FUNCTION update_last_modified_timestamp();

-- Create function to generate unique task_id_display
CREATE OR REPLACE FUNCTION generate_task_id_display()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.task_id_display IS NULL THEN
        NEW.task_id_display = 'T-' || TO_CHAR(NOW(), 'YYYYMMDD') || '-' || LPAD(NEXTVAL('task_id_seq')::TEXT, 4, '0');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create sequence for task IDs
CREATE SEQUENCE IF NOT EXISTS task_id_seq START 1;

CREATE TRIGGER tasks_generate_id
    BEFORE INSERT ON tasks
    FOR EACH ROW
    EXECUTE FUNCTION generate_task_id_display();

-- =====================================================
-- INDEXES FOR PERFORMANCE
-- =====================================================

-- Indexes for junction tables
CREATE INDEX IF NOT EXISTS idx_field_reports_asics_report_id ON field_reports_asics(field_report_id);
CREATE INDEX IF NOT EXISTS idx_field_reports_asics_asic_id ON field_reports_asics(asic_id);
CREATE INDEX IF NOT EXISTS idx_field_reports_equipment_report_id ON field_reports_equipment(field_report_id);
CREATE INDEX IF NOT EXISTS idx_field_reports_equipment_equipment_id ON field_reports_equipment(equipment_id);

-- Indexes for new foreign keys
CREATE INDEX IF NOT EXISTS idx_lists_site_id ON lists(site_id);
CREATE INDEX IF NOT EXISTS idx_lists_owner_user_id ON lists(owner_user_id);
CREATE INDEX IF NOT EXISTS idx_tasks_related_field_report_id ON tasks(related_field_report_id);
CREATE INDEX IF NOT EXISTS idx_tasks_parent_task_id ON tasks(parent_task_id);
CREATE INDEX IF NOT EXISTS idx_tasks_submitted_by_user_id ON tasks(submitted_by_user_id);
CREATE INDEX IF NOT EXISTS idx_field_reports_submitted_by_user_id ON field_reports(submitted_by_user_id);

-- Indexes for commonly queried fields
CREATE INDEX IF NOT EXISTS idx_tasks_reminder_time ON tasks(reminder_time) WHERE reminder_time IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_tasks_due_at ON tasks(due_at) WHERE due_at IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_tasks_priority ON tasks(priority);
CREATE INDEX IF NOT EXISTS idx_field_reports_report_date ON field_reports(report_date);
CREATE INDEX IF NOT EXISTS idx_lists_status ON lists(status);

-- =====================================================
-- VIEWS FOR COMMON QUERIES
-- =====================================================

-- View for tasks with related information (using personnel table)
CREATE OR REPLACE VIEW tasks_with_details AS
SELECT 
    t.*,
    s.site_name,
    fr.report_title_summary as related_report_title,
    p_assigned.first_name as assigned_to_name,
    p_created.first_name as created_by_name,
    pt.task_title as parent_task_title
FROM tasks t
LEFT JOIN sites s ON t.site_id = s.id
LEFT JOIN field_reports fr ON t.related_field_report_id = fr.id
LEFT JOIN personnel p_assigned ON t.assigned_to_user_id = p_assigned.id
LEFT JOIN personnel p_created ON t.created_by_user_id = p_created.id
LEFT JOIN tasks pt ON t.parent_task_id = pt.id;

-- View for field reports with related information (using personnel table)
CREATE OR REPLACE VIEW field_reports_with_details AS
SELECT 
    fr.*,
    s.site_name,
    p.first_name as submitted_by_name,
    COALESCE(
        ARRAY_AGG(DISTINCT CONCAT(a.asic_name_model, ' (', a.serial_number, ')')) FILTER (WHERE a.id IS NOT NULL), 
        ARRAY[]::TEXT[]
    ) as related_asics,
    COALESCE(
        ARRAY_AGG(DISTINCT CONCAT(e.equipment_name, ' (', e.serial_number, ')')) FILTER (WHERE e.id IS NOT NULL), 
        ARRAY[]::TEXT[]
    ) as related_equipment
FROM field_reports fr
LEFT JOIN sites s ON fr.site_id = s.id
LEFT JOIN personnel p ON fr.submitted_by_user_id = p.id
LEFT JOIN field_reports_asics fra ON fr.id = fra.field_report_id
LEFT JOIN asics a ON fra.asic_id = a.id
LEFT JOIN field_reports_equipment fre ON fr.id = fre.field_report_id
LEFT JOIN equipment e ON fre.equipment_id = e.id
GROUP BY fr.id, s.site_name, p.first_name;

-- View for lists with details (using personnel table)
CREATE OR REPLACE VIEW lists_with_details AS
SELECT 
    l.*,
    s.site_name,
    p.first_name as owner_name
FROM lists l
LEFT JOIN sites s ON l.site_id = s.id
LEFT JOIN personnel p ON l.owner_user_id = p.id;

-- =====================================================
-- CLEANUP OBSOLETE USER TABLES (UNCOMMENT WHEN READY)
-- =====================================================

-- After confirming all data has been migrated and foreign keys updated:

-- Drop flrts_users table (uncomment when ready)
-- DROP TABLE IF EXISTS flrts_users CASCADE;

-- Drop user_profiles table (uncomment when ready)  
-- DROP TABLE IF EXISTS user_profiles CASCADE;

-- Note: Use CASCADE carefully - it will drop dependent objects like foreign keys
-- Make sure all references have been updated to personnel table first

COMMIT;