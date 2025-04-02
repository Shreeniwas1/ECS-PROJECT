-- Enable Row Level Security on inventory_items table
ALTER TABLE inventory_items ENABLE ROW LEVEL SECURITY;

-- Drop existing policies if they exist
DROP POLICY IF EXISTS "Allow users to view inventory" ON inventory_items;
DROP POLICY IF EXISTS "Allow users to insert inventory" ON inventory_items;
DROP POLICY IF EXISTS "Allow users to update inventory" ON inventory_items;
DROP POLICY IF EXISTS "Allow users to delete inventory" ON inventory_items;

-- Create policies for authenticated users
-- View policy (SELECT)
CREATE POLICY "Allow users to view inventory" 
ON inventory_items 
FOR SELECT 
USING (auth.role() = 'authenticated');

-- Insert policy
CREATE POLICY "Allow users to insert inventory" 
ON inventory_items 
FOR INSERT 
WITH CHECK (auth.role() = 'authenticated');

-- Update policy
CREATE POLICY "Allow users to update inventory" 
ON inventory_items 
FOR UPDATE 
USING (auth.role() = 'authenticated');

-- Delete policy
CREATE POLICY "Allow users to delete inventory" 
ON inventory_items 
FOR DELETE 
USING (auth.role() = 'authenticated');

-- For testing only: If you need to disable RLS temporarily to troubleshoot
-- ALTER TABLE inventory_items DISABLE ROW LEVEL SECURITY;

-- Note: You can also enable bypass_rls for specific users if needed
-- ALTER USER your_user_name SET bypass_rls = true;
