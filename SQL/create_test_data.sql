-- Make sure we have a warehouse with ID 1
INSERT INTO warehouses (id, name, location, capacity, current_capacity, address)
VALUES 
(1, 'Warehouse #1', 'New York, USA', 1000, 0, '123 Main St, New York, NY')
ON CONFLICT (id) DO UPDATE SET 
    name = EXCLUDED.name,
    location = EXCLUDED.location;

-- Insert categories if they don't exist
INSERT INTO inventory_categories (id, name, description) 
VALUES 
(1, 'Electronics', 'Electronic devices and components'),
(2, 'Office Supplies', 'Office supplies and stationery')
ON CONFLICT (id) DO NOTHING;

-- Insert sample inventory items for Warehouse #1
INSERT INTO inventory_items 
(warehouse_id, category_id, name, sku, description, quantity, min_quantity, unit_price, location_in_warehouse, image_url) 
VALUES
-- Electronics category items
(1, 1, 'Dell XPS 13 Laptop', 'EL-LAP-001', '13-inch laptop with 16GB RAM, 512GB SSD', 42, 10, 1299.99, 'A1-B3', 'https://i.dell.com/is/image/DellContent/content/dam/ss2/product-images/dell-client-products/notebooks/xps-notebooks/xps-13-9315/media-gallery/xs9315-cnb-00000ff090-sl.psd?fmt=png-alpha&pscan=auto&scl=1&hei=402&wid=402&qlt=100,1&resMode=sharp2&size=402,402'),
(1, 1, 'iPhone 13', 'EL-PHN-002', 'iPhone 13 128GB Black', 75, 15, 799.99, 'A1-B4', 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-13-blue-select-2021?wid=470&hei=556&fmt=jpeg&qlt=95&.v=1645572386470'),

-- Office Supplies category items
(1, 2, 'Premium Notebook', 'OS-NB-001', 'Premium hardcover notebook, 200 pages', 120, 30, 14.99, 'B2-C1', 'https://m.media-amazon.com/images/I/71TzCXcVr1L._AC_SL1500_.jpg'),
(1, 2, 'Ballpoint Pen Pack', 'OS-PEN-002', 'Pack of 12 blue ballpoint pens', 85, 20, 7.99, 'B2-C3', 'https://m.media-amazon.com/images/I/71+mDoHG4mL.jpg')

ON CONFLICT (sku) DO UPDATE SET
    name = EXCLUDED.name,
    category_id = EXCLUDED.category_id,
    quantity = EXCLUDED.quantity,
    min_quantity = EXCLUDED.min_quantity,
    unit_price = EXCLUDED.unit_price,
    warehouse_id = EXCLUDED.warehouse_id,
    updated_at = NOW();
