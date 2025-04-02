-- First let's check what's in our inventory table
SELECT COUNT(*) FROM inventory_items;

-- Check if we have categories
SELECT COUNT(*) FROM inventory_categories;

-- Check warehouses
SELECT * FROM warehouses;

-- If there's no data, re-insert the categories
INSERT INTO inventory_categories (id, name, description) 
VALUES 
(1, 'Electronics', 'Electronic devices, components and accessories'),
(2, 'Office Supplies', 'Stationery and general office supplies')
ON CONFLICT (id) DO NOTHING;

-- Fix data insertion to ensure it matches warehouse IDs
-- First, ensure the test data uses valid warehouse IDs from the warehouses table
INSERT INTO inventory_items 
(warehouse_id, category_id, name, sku, description, quantity, min_quantity, unit_price, location_in_warehouse, image_url) 
VALUES
(1, 1, 'Laptop Dell XPS 13', 'EL-LAP-001', '13-inch Dell XPS laptop with 16GB RAM, 512GB SSD', 42, 10, 1299.99, 'A1-B3', 'https://i.dell.com/sites/csimages/Product_Imagery/all/xps-13-9340-laptop.jpg'),
(1, 1, 'Apple iPhone 13', 'EL-PHN-002', 'iPhone 13 128GB Black', 75, 15, 799.99, 'A1-B4', 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-13-black-select')
ON CONFLICT (sku) DO NOTHING;

-- Add a direct insert for warehouse #1 to ensure we have data for the default view
INSERT INTO inventory_items 
(warehouse_id, category_id, name, sku, description, quantity, min_quantity, unit_price, location_in_warehouse, image_url) 
VALUES
(1, 2, 'Premium Notebook', 'OS-NB-001', 'Premium hardcover notebook, 200 pages', 65, 15, 14.99, 'B2-C1', 'https://m.media-amazon.com/images/I/71TzCXcVr1L._AC_SL1500_.jpg')
ON CONFLICT (sku) DO NOTHING;

-- Create a trigger to automatically update the updated_at timestamp
CREATE OR REPLACE FUNCTION update_modified_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply the trigger to inventory_items if not already
DROP TRIGGER IF EXISTS set_timestamp ON inventory_items;
CREATE TRIGGER set_timestamp
BEFORE UPDATE ON inventory_items
FOR EACH ROW
EXECUTE FUNCTION update_modified_column();

-- Update all items to refresh their updated_at timestamp
UPDATE inventory_items SET quantity = quantity WHERE id > 0;
