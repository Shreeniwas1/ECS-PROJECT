-- Check if tables exist
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public'
ORDER BY table_name;

-- Check warehouse table structure
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = 'warehouses'
ORDER BY ordinal_position;

-- Check inventory_categories table structure
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = 'inventory_categories'
ORDER BY ordinal_position;

-- Check inventory_items table structure
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = 'inventory_items'
ORDER BY ordinal_position;

-- Check if there are warehouses in the warehouses table
SELECT COUNT(*) FROM warehouses;

-- Check if there are categories in the inventory_categories table
SELECT COUNT(*) FROM inventory_categories;

-- Check if there are items in the inventory_items table
SELECT COUNT(*) FROM inventory_items;

-- Check for foreign key relationships
SELECT
    tc.table_schema, 
    tc.constraint_name, 
    tc.table_name, 
    kcu.column_name, 
    ccu.table_schema AS foreign_table_schema,
    ccu.table_name AS foreign_table_name,
    ccu.column_name AS foreign_column_name 
FROM 
    information_schema.table_constraints AS tc 
    JOIN information_schema.key_column_usage AS kcu
      ON tc.constraint_name = kcu.constraint_name
      AND tc.table_schema = kcu.table_schema
    JOIN information_schema.constraint_column_usage AS ccu
      ON ccu.constraint_name = tc.constraint_name
      AND ccu.table_schema = tc.table_schema
WHERE tc.constraint_type = 'FOREIGN KEY';
