-- Reset sequences for inventory tables to prevent ID conflicts
SELECT setval('inventory_categories_id_seq', COALESCE((SELECT MAX(id) FROM inventory_categories), 0) + 1, false);
SELECT setval('inventory_items_id_seq', COALESCE((SELECT MAX(id) FROM inventory_items), 0) + 1, false);

-- Check current sequence values
SELECT 
    currval('inventory_categories_id_seq') as categories_next_id,
    currval('inventory_items_id_seq') as items_next_id;

-- Set up additional sample data if needed
INSERT INTO warehouses (id, name, location, capacity, current_capacity, address, latitude, longitude)
VALUES (1, 'Warehouse #1', 'New York, USA', 1000, 0, '123 Main St, New York, NY', 40.7128, -74.0060)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    capacity = EXCLUDED.capacity;

-- Insert sample data for testing if inventory is empty
DO $$
DECLARE
    item_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO item_count FROM inventory_items;
    
    IF item_count = 0 THEN
        -- Clear and reset categories
        TRUNCATE inventory_categories RESTART IDENTITY CASCADE;
        
        -- Insert basic categories
        INSERT INTO inventory_categories (name, description) VALUES
        ('Electronics', 'Electronic devices and components'),
        ('Office Supplies', 'Office supplies and stationery');
        
        -- Insert test items
        INSERT INTO inventory_items 
        (warehouse_id, category_id, name, sku, description, quantity, min_quantity, unit_price, location_in_warehouse, image_url) 
        VALUES
        (1, 1, 'Test Laptop', 'TEST-001', 'Test laptop item', 10, 5, 999.99, 'A1-B1', 'https://via.placeholder.com/150'),
        (1, 2, 'Test Paper', 'TEST-002', 'Test paper item', 100, 25, 9.99, 'C1-D1', 'https://via.placeholder.com/150');
    END IF;
END $$;
