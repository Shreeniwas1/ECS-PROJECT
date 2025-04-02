-- Create warehouse access permissions for staff

-- Warehouse #1 access
INSERT INTO warehouse_access (user_id, warehouse_id, access_level) VALUES
('11111111-1111-1111-1111-111111111111', 1, 'admin'), -- Warehouse Manager
('55555555-5555-5555-5555-555555555555', 1, 'manager'), -- Shift Supervisor
('22222222-2222-2222-2222-222222222222', 1, 'staff'), -- Inventory Specialist
('33333333-3333-3333-3333-333333333333', 1, 'staff'), -- Shipping Coordinator
('44444444-4444-4444-4444-444444444444', 1, 'staff'), -- Warehouse Associate
('66666666-6666-6666-6666-666666666666', 1, 'staff'), -- Inventory Clerk
('77777777-7777-7777-7777-777777777777', 1, 'staff'), -- Forklift Operator
('88888888-8888-8888-8888-888888888888', 1, 'staff'), -- Quality Control Specialist
('99999999-9999-9999-9999-999999999999', 1, 'staff'), -- Receiving Clerk
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 1, 'staff'), -- Administrative Assistant
('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 1, 'staff'), -- Material Handler
('cccccccc-cccc-cccc-cccc-cccccccccccc', 1, 'staff'), -- Shipping Clerk
('dddddddd-dddd-dddd-dddd-dddddddddddd', 1, 'staff'), -- Inventory Analyst
('45454545-cccc-4444-dddd-666666666666', 1, 'staff'); -- Inactive Warehouse Associate

-- Warehouse #2 access
INSERT INTO warehouse_access (user_id, warehouse_id, access_level) VALUES
('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 2, 'admin'), -- Warehouse Manager
('ffffffff-ffff-ffff-ffff-ffffffffffff', 2, 'manager'), -- Shift Supervisor
('11111111-aaaa-2222-bbbb-333333333333', 2, 'staff'), -- Shipping Coordinator
('22222222-bbbb-3333-cccc-444444444444', 2, 'staff'), -- Inventory Specialist
('33333333-cccc-4444-dddd-555555555555', 2, 'staff'), -- Quality Control Specialist
('44444444-dddd-5555-eeee-666666666666', 2, 'staff'), -- Forklift Operator
('55555555-eeee-6666-ffff-777777777777', 2, 'staff'), -- Warehouse Associate
('66666666-ffff-7777-0000-888888888888', 2, 'staff'), -- Material Handler
('77777777-0000-8888-1111-999999999999', 2, 'staff'), -- Administrative Assistant
('88888888-1111-9999-2222-aaaaaaaaaaaa', 2, 'staff'), -- Receiving Clerk
('99999999-2222-aaaa-3333-bbbbbbbbbbbb', 2, 'staff'), -- Shipping Clerk
('56565656-dddd-5555-eeee-777777777777', 2, 'staff'); -- Inactive Inventory Clerk

-- Warehouse #3 access
INSERT INTO warehouse_access (user_id, warehouse_id, access_level) VALUES
('aaaaaaaa-3333-bbbb-4444-cccccccccccc', 3, 'admin'), -- Warehouse Manager
('bbbbbbbb-4444-cccc-5555-dddddddddddd', 3, 'manager'), -- Shift Supervisor
('cccccccc-5555-dddd-6666-eeeeeeeeeeee', 3, 'staff'), -- Inventory Specialist
('dddddddd-6666-eeee-7777-ffffffffffff', 3, 'staff'), -- Warehouse Associate
('eeeeeeee-7777-ffff-8888-111111111111', 3, 'staff'), -- Forklift Operator
('ffffffff-8888-0000-9999-222222222222', 3, 'staff'), -- Shipping Coordinator
('12121212-9999-1111-aaaa-333333333333', 3, 'staff'), -- Quality Control Specialist
('23232323-aaaa-2222-bbbb-444444444444', 3, 'staff'), -- Material Handler
('34343434-bbbb-3333-cccc-555555555555', 3, 'staff'), -- Receiving Clerk
('67676767-eeee-6666-ffff-888888888888', 3, 'staff'); -- Inactive Shipping Clerk
