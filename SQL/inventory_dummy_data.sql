-- Insert two sample inventory categories
INSERT INTO inventory_categories (id, name, description) 
VALUES 
(1, 'Electronics', 'Electronic devices, components and accessories'),
(2, 'Office Supplies', 'Stationery and general office supplies');

-- Insert inventory items for Electronics category
INSERT INTO inventory_items 
(warehouse_id, category_id, name, sku, description, quantity, min_quantity, unit_price, location_in_warehouse, image_url) 
VALUES
(1, 1, 'Laptop Dell XPS 13', 'EL-LAP-001', '13-inch Dell XPS laptop with 16GB RAM, 512GB SSD', 42, 10, 1299.99, 'A1-B3', 'https://example.com/images/laptop-dell.jpg'),
(1, 1, 'Apple iPhone 13', 'EL-PHN-002', 'iPhone 13 128GB Black', 75, 15, 799.99, 'A1-B4', 'https://example.com/images/iphone13.jpg'),
(2, 1, 'Samsung 4K Smart TV', 'EL-TV-003', '55-inch Samsung 4K Smart TV with HDR', 18, 5, 699.99, 'C3-D2', 'https://example.com/images/samsung-tv.jpg'),
(3, 1, 'Wireless Headphones', 'EL-AUD-004', 'Noise-cancelling Bluetooth headphones', 93, 20, 129.99, 'A2-B1', 'https://example.com/images/headphones.jpg');

-- Insert inventory items for Office Supplies category
INSERT INTO inventory_items 
(warehouse_id, category_id, name, sku, description, quantity, min_quantity, unit_price, location_in_warehouse, image_url) 
VALUES
(1, 2, 'Printer Paper A4', 'OS-PPR-001', '500 sheets A4 printer paper 80gsm', 120, 30, 4.99, 'B1-C1', 'https://example.com/images/printer-paper.jpg'),
(2, 2, 'Ballpoint Pen Pack', 'OS-PEN-002', 'Pack of 12 blue ballpoint pens', 85, 20, 3.49, 'B2-C3', 'https://example.com/images/ballpoint-pens.jpg'),
(3, 2, 'Sticky Notes', 'OS-STK-003', 'Pack of 12 sticky note pads assorted colors', 110, 25, 7.99, 'B3-C2', 'https://example.com/images/sticky-notes.jpg'),
(1, 2, 'Stapler', 'OS-STP-004', 'Desktop stapler with 1000 staples', 47, 10, 8.99, 'B1-C2', 'https://example.com/images/stapler.jpg');

-- Insert sample activity log entries related to inventory
INSERT INTO activities 
(warehouse_id, activity_type, description, related_entity_type, related_entity_id, icon, importance) 
VALUES
(1, 'inventory_update', 'New laptops added to inventory', 'inventory_items', 1, 'fa-laptop', 'normal'),
(2, 'low_stock', 'Smart TVs running low on stock', 'inventory_items', 3, 'fa-tv', 'high-- Insert two sample inventory categories
INSERT INTO inventory_categories (id, name, description) 
VALUES 
(1, 'Electronics', 'Electronic devices, components and accessories'),
(2, 'Office Supplies', 'Stationery and general office supplies');

-- Insert inventory items for Electronics category
INSERT INTO inventory_items 
(warehouse_id, category_id, name, sku, description, quantity, min_quantity, unit_price, location_in_warehouse, image_url) 
VALUES
(1, 1, 'Laptop Dell XPS 13', 'EL-LAP-001', '13-inch Dell XPS laptop with 16GB RAM, 512GB SSD', 42, 10, 1299.99, 'A1-B3', 'https://i.dell.com/sites/csimages/Product_Imagery/all/xps-13-9340-laptop.jpg'),
(1, 1, 'Apple iPhone 13', 'EL-PHN-002', 'iPhone 13 128GB Black', 75, 15, 799.99, 'A1-B4', 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-13-black-select'),
(2, 1, 'Samsung 55-Inch 4K Smart TV', 'EL-TV-003', '55-inch Samsung 4K Smart TV with HDR', 18, 5, 699.99, 'C3-D2', 'https://image-us.samsung.com/SamsungUS/home/television-home-theater/tvs/oled/pdp/qn55s95dafxza/gallery/01_QN55S95DAFXZA_1600x1200.jpg'),
(3, 1, 'Wireless Noise-Cancelling Headphones', 'EL-AUD-004', 'Noise-cancelling Bluetooth headphones', 93, 20, 129.99, 'A2-B1', 'https://m.media-amazon.com/images/I/61CGHv6kmWL._AC_SL1500_.jpg');

-- Insert inventory items for Office Supplies category
INSERT INTO inventory_items 
(warehouse_id, category_id, name, sku, description, quantity, min_quantity, unit_price, location_in_warehouse, image_url) 
VALUES
(1, 2, 'Printer Paper A4', 'OS-PPR-001', '500 sheets A4 printer paper 80gsm', 120, 30, 4.99, 'B1-C1', 'https://m.media-amazon.com/images/I/71n+3pux9FL._AC_SL1500_.jpg'),
(2, 2, 'Ballpoint Pen Pack', 'OS-PEN-002', 'Pack of 12 blue ballpoint pens', 85, 20, 3.49, 'B2-C3', 'https://m.media-amazon.com/images/I/81vQqZ3z2nL._AC_SL1500_.jpg'),
(3, 2, 'Sticky Notes', 'OS-STK-003', 'Pack of 12 sticky note pads assorted colors', 110, 25, 7.99, 'B3-C2', 'https://m.media-amazon.com/images/I/71UQp+uD6FL._AC_SL1500_.jpg'),
(1, 2, 'Stapler', 'OS-STP-004', 'Desktop stapler with 1000 staples', 47, 10, 8.99, 'B1-C2', 'https://m.media-amazon.com/images/I/61sZy2Y7x5L._AC_SL1500_.jpg');

-- Insert sample activity log entries related to inventory
INSERT INTO activities 
(warehouse_id, activity_type, description, related_entity_type, related_entity_id, icon, importance) 
VALUES
(1, 'inventory_update', 'New laptops added to inventory', 'inventory_items', 1, 'fa-laptop', 'normal'),
(2, 'low_stock', 'Smart TVs running low on stock', 'inventory_items', 3, 'fa-tv', 'high');
');
