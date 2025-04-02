-- First, insert users into auth.users table to satisfy the foreign key constraint
-- Note: Using simplified user records with just the essential fields for demo purposes

-- Create users for Warehouse #1 Staff
INSERT INTO auth.users (id, email, encrypted_password, email_confirmed_at, created_at) VALUES
('11111111-1111-1111-1111-111111111111', 'john.smith@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2020-01-15T09:00:00Z'),
('22222222-2222-2222-2222-222222222222', 'sarah.johnson@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2021-03-10T10:30:00Z'),
('33333333-3333-3333-3333-333333333333', 'michael.chen@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2019-06-05T08:15:00Z'),
('44444444-4444-4444-4444-444444444444', 'jessica.brown@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2022-02-20T11:45:00Z'),
('55555555-5555-5555-5555-555555555555', 'robert.wilson@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2020-09-12T13:00:00Z'),
('66666666-6666-6666-6666-666666666666', 'emily.davis@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2021-07-30T09:30:00Z'),
('77777777-7777-7777-7777-777777777777', 'david.martinez@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2020-11-15T08:00:00Z'),
('88888888-8888-8888-8888-888888888888', 'amanda.taylor@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2021-05-18T10:15:00Z'),
('99999999-9999-9999-9999-999999999999', 'james.anderson@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2022-01-10T14:30:00Z'),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'lisa.thomas@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2021-08-05T09:45:00Z'),
('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'kevin.jackson@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2020-03-25T11:00:00Z'),
('cccccccc-cccc-cccc-cccc-cccccccccccc', 'nicole.white@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2021-10-12T08:30:00Z'),
('dddddddd-dddd-dddd-dddd-dddddddddddd', 'thomas.harris@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2020-07-20T13:15:00Z');

-- Create users for Warehouse #2 Staff
INSERT INTO auth.users (id, email, encrypted_password, email_confirmed_at, created_at) VALUES
('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'jennifer.garcia@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2019-12-05T10:00:00Z'),
('ffffffff-ffff-ffff-ffff-ffffffffffff', 'daniel.miller@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2020-05-15T09:15:00Z'),
('11111111-aaaa-2222-bbbb-333333333333', 'rachel.wilson@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2021-02-28T11:30:00Z'),
('22222222-bbbb-3333-cccc-444444444444', 'christopher.moore@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2020-08-10T14:00:00Z'),
('33333333-cccc-4444-dddd-555555555555', 'michelle.lee@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2021-04-22T10:45:00Z'),
('44444444-dddd-5555-eeee-666666666666', 'brian.clark@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2020-10-18T08:30:00Z'),
('55555555-eeee-6666-ffff-777777777777', 'stephanie.lewis@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2021-06-15T13:30:00Z'),
('66666666-ffff-7777-0000-888888888888', 'jason.young@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2022-01-05T09:00:00Z'),
('77777777-0000-8888-1111-999999999999', 'lauren.allen@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2020-12-10T11:15:00Z'),
('88888888-1111-9999-2222-aaaaaaaaaaaa', 'eric.walker@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2021-07-25T08:45:00Z'),
('99999999-2222-aaaa-3333-bbbbbbbbbbbb', 'amy.scott@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2020-04-30T10:30:00Z');

-- Create users for Warehouse #3 Staff
INSERT INTO auth.users (id, email, encrypted_password, email_confirmed_at, created_at) VALUES
('aaaaaaaa-3333-bbbb-4444-cccccccccccc', 'matthew.adams@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2020-02-10T08:00:00Z'),
('bbbbbbbb-4444-cccc-5555-dddddddddddd', 'laura.green@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2020-06-20T09:45:00Z'),
('cccccccc-5555-dddd-6666-eeeeeeeeeeee', 'patrick.baker@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2021-01-15T11:30:00Z'),
('dddddddd-6666-eeee-7777-ffffffffffff', 'rebecca.rivera@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2020-09-05T14:15:00Z'),
('eeeeeeee-7777-ffff-8888-111111111111', 'jonathan.campbell@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2021-03-28T08:30:00Z'),
('ffffffff-8888-0000-9999-222222222222', 'elizabeth.mitchell@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2020-07-15T10:00:00Z'),
('12121212-9999-1111-aaaa-333333333333', 'michael.roberts@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2021-05-10T13:45:00Z'),
('23232323-aaaa-2222-bbbb-444444444444', 'samantha.carter@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2020-11-20T09:15:00Z'),
('34343434-bbbb-3333-cccc-555555555555', 'andrew.phillips@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2021-08-15T11:00:00Z');

-- Create users for staff on leave or inactive
INSERT INTO auth.users (id, email, encrypted_password, email_confirmed_at, created_at) VALUES
('45454545-cccc-4444-dddd-666666666666', 'olivia.evans@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2019-10-10T08:00:00Z'),
('56565656-dddd-5555-eeee-777777777777', 'william.turner@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2020-04-05T09:30:00Z'),
('67676767-eeee-6666-ffff-888888888888', 'sophia.cooper@example.com', '$2a$10$abcdefghijklmnopqrstuvwxyz123456', NOW(), '2021-02-12T13:00:00Z');

-- Now insert staff data after users have been created

-- Warehouse #1 Staff
INSERT INTO staff (user_id, first_name, last_name, position, department, warehouse_id, contact_number, is_active, created_at) VALUES
('11111111-1111-1111-1111-111111111111', 'John', 'Smith', 'Warehouse Manager', 'Management', 1, '555-123-4567', TRUE, '2020-01-15T09:00:00Z'),
('22222222-2222-2222-2222-222222222222', 'Sarah', 'Johnson', 'Inventory Specialist', 'Operations', 1, '555-234-5678', TRUE, '2021-03-10T10:30:00Z'),
('33333333-3333-3333-3333-333333333333', 'Michael', 'Chen', 'Shipping Coordinator', 'Shipping', 1, '555-345-6789', TRUE, '2019-06-05T08:15:00Z'),
('44444444-4444-4444-4444-444444444444', 'Jessica', 'Brown', 'Warehouse Associate', 'Operations', 1, '555-456-7890', TRUE, '2022-02-20T11:45:00Z'),
('55555555-5555-5555-5555-555555555555', 'Robert', 'Wilson', 'Shift Supervisor', 'Management', 1, '555-567-8901', TRUE, '2020-09-12T13:00:00Z'),
('66666666-6666-6666-6666-666666666666', 'Emily', 'Davis', 'Inventory Clerk', 'Operations', 1, '555-678-9012', TRUE, '2021-07-30T09:30:00Z'),
('77777777-7777-7777-7777-777777777777', 'David', 'Martinez', 'Forklift Operator', 'Operations', 1, '555-789-0123', TRUE, '2020-11-15T08:00:00Z'),
('88888888-8888-8888-8888-888888888888', 'Amanda', 'Taylor', 'Quality Control Specialist', 'Operations', 1, '555-890-1234', TRUE, '2021-05-18T10:15:00Z'),
('99999999-9999-9999-9999-999999999999', 'James', 'Anderson', 'Receiving Clerk', 'Operations', 1, '555-901-2345', TRUE, '2022-01-10T14:30:00Z'),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Lisa', 'Thomas', 'Administrative Assistant', 'Management', 1, '555-012-3456', TRUE, '2021-08-05T09:45:00Z'),
('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'Kevin', 'Jackson', 'Material Handler', 'Operations', 1, '555-123-7890', TRUE, '2020-03-25T11:00:00Z'),
('cccccccc-cccc-cccc-cccc-cccccccccccc', 'Nicole', 'White', 'Shipping Clerk', 'Shipping', 1, '555-234-8901', TRUE, '2021-10-12T08:30:00Z'),
('dddddddd-dddd-dddd-dddd-dddddddddddd', 'Thomas', 'Harris', 'Inventory Analyst', 'Operations', 1, '555-345-9012', TRUE, '2020-07-20T13:15:00Z');

-- Warehouse #2 Staff
INSERT INTO staff (user_id, first_name, last_name, position, department, warehouse_id, contact_number, is_active, created_at) VALUES
('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'Jennifer', 'Garcia', 'Warehouse Manager', 'Management', 2, '555-456-0123', TRUE, '2019-12-05T10:00:00Z'),
('ffffffff-ffff-ffff-ffff-ffffffffffff', 'Daniel', 'Miller', 'Shift Supervisor', 'Management', 2, '555-567-1234', TRUE, '2020-05-15T09:15:00Z'),
('11111111-aaaa-2222-bbbb-333333333333', 'Rachel', 'Wilson', 'Shipping Coordinator', 'Shipping', 2, '555-678-2345', TRUE, '2021-02-28T11:30:00Z'),
('22222222-bbbb-3333-cccc-444444444444', 'Christopher', 'Moore', 'Inventory Specialist', 'Operations', 2, '555-789-3456', TRUE, '2020-08-10T14:00:00Z'),
('33333333-cccc-4444-dddd-555555555555', 'Michelle', 'Lee', 'Quality Control Specialist', 'Operations', 2, '555-890-4567', TRUE, '2021-04-22T10:45:00Z'),
('44444444-dddd-5555-eeee-666666666666', 'Brian', 'Clark', 'Forklift Operator', 'Operations', 2, '555-901-5678', TRUE, '2020-10-18T08:30:00Z'),
('55555555-eeee-6666-ffff-777777777777', 'Stephanie', 'Lewis', 'Warehouse Associate', 'Operations', 2, '555-012-6789', TRUE, '2021-06-15T13:30:00Z'),
('66666666-ffff-7777-0000-888888888888', 'Jason', 'Young', 'Material Handler', 'Operations', 2, '555-123-7890', TRUE, '2022-01-05T09:00:00Z'),
('77777777-0000-8888-1111-999999999999', 'Lauren', 'Allen', 'Administrative Assistant', 'Management', 2, '555-234-8901', TRUE, '2020-12-10T11:15:00Z'),
('88888888-1111-9999-2222-aaaaaaaaaaaa', 'Eric', 'Walker', 'Receiving Clerk', 'Operations', 2, '555-345-9012', TRUE, '2021-07-25T08:45:00Z'),
('99999999-2222-aaaa-3333-bbbbbbbbbbbb', 'Amy', 'Scott', 'Shipping Clerk', 'Shipping', 2, '555-456-0123', TRUE, '2020-04-30T10:30:00Z');

-- Warehouse #3 Staff
INSERT INTO staff (user_id, first_name, last_name, position, department, warehouse_id, contact_number, is_active, created_at) VALUES
('aaaaaaaa-3333-bbbb-4444-cccccccccccc', 'Matthew', 'Adams', 'Warehouse Manager', 'Management', 3, '555-567-1234', TRUE, '2020-02-10T08:00:00Z'),
('bbbbbbbb-4444-cccc-5555-dddddddddddd', 'Laura', 'Green', 'Shift Supervisor', 'Management', 3, '555-678-2345', TRUE, '2020-06-20T09:45:00Z'),
('cccccccc-5555-dddd-6666-eeeeeeeeeeee', 'Patrick', 'Baker', 'Inventory Specialist', 'Operations', 3, '555-789-3456', TRUE, '2021-01-15T11:30:00Z'),
('dddddddd-6666-eeee-7777-ffffffffffff', 'Rebecca', 'Rivera', 'Warehouse Associate', 'Operations', 3, '555-890-4567', TRUE, '2020-09-05T14:15:00Z'),
('eeeeeeee-7777-ffff-8888-111111111111', 'Jonathan', 'Campbell', 'Forklift Operator', 'Operations', 3, '555-901-5678', TRUE, '2021-03-28T08:30:00Z'),
('ffffffff-8888-0000-9999-222222222222', 'Elizabeth', 'Mitchell', 'Shipping Coordinator', 'Shipping', 3, '555-012-6789', TRUE, '2020-07-15T10:00:00Z'),
('12121212-9999-1111-aaaa-333333333333', 'Michael', 'Roberts', 'Quality Control Specialist', 'Operations', 3, '555-123-7890', TRUE, '2021-05-10T13:45:00Z'),
('23232323-aaaa-2222-bbbb-444444444444', 'Samantha', 'Carter', 'Material Handler', 'Operations', 3, '555-234-8901', TRUE, '2020-11-20T09:15:00Z'),
('34343434-bbbb-3333-cccc-555555555555', 'Andrew', 'Phillips', 'Receiving Clerk', 'Operations', 3, '555-345-9012', TRUE, '2021-08-15T11:00:00Z');

-- Add some staff who are on leave or inactive
INSERT INTO staff (user_id, first_name, last_name, position, department, warehouse_id, contact_number, is_active, created_at) VALUES
('45454545-cccc-4444-dddd-666666666666', 'Olivia', 'Evans', 'Warehouse Associate', 'Operations', 1, '555-456-0123', FALSE, '2019-10-10T08:00:00Z'),
('56565656-dddd-5555-eeee-777777777777', 'William', 'Turner', 'Inventory Clerk', 'Operations', 2, '555-567-1234', FALSE, '2020-04-05T09:30:00Z'),
('67676767-eeee-6666-ffff-888888888888', 'Sophia', 'Cooper', 'Shipping Clerk', 'Shipping', 3, '555-678-2345', FALSE, '2021-02-12T13:00:00Z');
