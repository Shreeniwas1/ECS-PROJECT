-- Enable Row Level Security
ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

-- Setup storage for user profiles and product images
CREATE SCHEMA IF NOT EXISTS storage;

-- WAREHOUSES TABLE
CREATE TABLE warehouses (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  location TEXT,
  address TEXT,
  latitude DECIMAL(10, 6),
  longitude DECIMAL(10, 6),
  capacity INT NOT NULL DEFAULT 100,
  current_capacity INT NOT NULL DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- WAREHOUSE ACCESS (for user permissions)
CREATE TABLE warehouse_access (
  id SERIAL PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  warehouse_id INT REFERENCES warehouses(id) ON DELETE CASCADE,
  access_level VARCHAR(20) NOT NULL CHECK (access_level IN ('admin', 'manager', 'staff', 'viewer')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(user_id, warehouse_id)
);

-- CLIMATE DATA (Temperature/Humidity)
CREATE TABLE climate_data (
  id SERIAL PRIMARY KEY,
  warehouse_id INT REFERENCES warehouses(id) ON DELETE CASCADE,
  temperature DECIMAL(5, 2),
  humidity DECIMAL(5, 2),
  recorded_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  alert_triggered BOOLEAN DEFAULT FALSE
);

-- CLIMATE ALERT SETTINGS
CREATE TABLE climate_settings (
  id SERIAL PRIMARY KEY,
  warehouse_id INT REFERENCES warehouses(id) ON DELETE CASCADE,
  temp_min DECIMAL(5, 2) DEFAULT 15,
  temp_max DECIMAL(5, 2) DEFAULT 30,
  humid_min DECIMAL(5, 2) DEFAULT 30,
  humid_max DECIMAL(5, 2) DEFAULT 70,
  notify_email BOOLEAN DEFAULT TRUE,
  notify_sms BOOLEAN DEFAULT FALSE,
  updated_by UUID REFERENCES auth.users(id),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- EQUIPMENT
CREATE TABLE equipment (
  id SERIAL PRIMARY KEY,
  warehouse_id INT REFERENCES warehouses(id) ON DELETE CASCADE,
  name VARCHAR(100) NOT NULL,
  type VARCHAR(50) NOT NULL,
  status VARCHAR(50) NOT NULL CHECK (status IN ('operational', 'maintenance', 'offline', 'repair')),
  last_maintenance TIMESTAMP WITH TIME ZONE,
  next_maintenance TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- INVENTORY CATEGORIES
CREATE TABLE inventory_categories (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- INVENTORY ITEMS
CREATE TABLE inventory_items (
  id SERIAL PRIMARY KEY,
  warehouse_id INT REFERENCES warehouses(id) ON DELETE CASCADE,
  category_id INT REFERENCES inventory_categories(id),
  name VARCHAR(200) NOT NULL,
  sku VARCHAR(50) UNIQUE,
  description TEXT,
  quantity INT NOT NULL DEFAULT 0,
  min_quantity INT DEFAULT 0,
  unit_price DECIMAL(10, 2),
  location_in_warehouse VARCHAR(100),
  image_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ORDERS
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  warehouse_id INT REFERENCES warehouses(id) ON DELETE CASCADE,
  order_number VARCHAR(50) UNIQUE,
  status VARCHAR(50) NOT NULL CHECK (status IN ('pending', 'processing', 'shipped', 'delivered', 'cancelled')),
  customer_name VARCHAR(200),
  customer_email VARCHAR(200),
  total_amount DECIMAL(12, 2),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  processed_by UUID REFERENCES auth.users(id)
);

-- ORDER ITEMS
CREATE TABLE order_items (
  id SERIAL PRIMARY KEY,
  order_id INT REFERENCES orders(id) ON DELETE CASCADE,
  inventory_item_id INT REFERENCES inventory_items(id),
  quantity INT NOT NULL,
  unit_price DECIMAL(10, 2) NOT NULL,
  total_price DECIMAL(10, 2) NOT NULL
);

-- SHIPMENTS
CREATE TABLE shipments (
  id SERIAL PRIMARY KEY,
  warehouse_id INT REFERENCES warehouses(id) ON DELETE CASCADE,
  shipment_number VARCHAR(50) UNIQUE,
  status VARCHAR(50) NOT NULL CHECK (status IN ('pending', 'in_transit', 'delivered', 'returned')),
  order_id INT REFERENCES orders(id),
  carrier VARCHAR(100),
  tracking_number VARCHAR(100),
  shipped_date TIMESTAMP WITH TIME ZONE,
  expected_delivery TIMESTAMP WITH TIME ZONE,
  actual_delivery TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  processed_by UUID REFERENCES auth.users(id)
);

-- STAFF
CREATE TABLE staff (
  id SERIAL PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  position VARCHAR(100),
  department VARCHAR(100),
  warehouse_id INT REFERENCES warehouses(id) ON DELETE CASCADE,
  contact_number VARCHAR(20),
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ACTIVITIES LOG
CREATE TABLE activities (
  id SERIAL PRIMARY KEY,
  warehouse_id INT REFERENCES warehouses(id) ON DELETE CASCADE,
  user_id UUID REFERENCES auth.users(id),
  activity_type VARCHAR(50) NOT NULL,
  description TEXT NOT NULL,
  related_entity_type VARCHAR(50),
  related_entity_id INT,
  icon VARCHAR(50),
  importance VARCHAR(20) DEFAULT 'normal',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- WAREHOUSE PERFORMANCE
CREATE TABLE performance_metrics (
  id SERIAL PRIMARY KEY,
  warehouse_id INT REFERENCES warehouses(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  items_processed INT DEFAULT 0,
  items_shipped INT DEFAULT 0,
  processing_time_avg DECIMAL(10, 2), -- in minutes
  picking_accuracy DECIMAL(5, 2), -- percentage
  on_time_delivery DECIMAL(5, 2), -- percentage
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- User Profile Extension
CREATE TABLE user_profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  full_name TEXT,
  avatar_url TEXT,
  phone_number TEXT,
  theme_preference VARCHAR(20) DEFAULT 'system',
  notification_preferences JSONB DEFAULT '{"email": true, "sms": false, "push": true}'::jsonb,
  last_active TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- USER NOTIFICATIONS
CREATE TABLE notifications (
  id SERIAL PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  title VARCHAR(255) NOT NULL,
  message TEXT NOT NULL,
  read BOOLEAN DEFAULT FALSE,
  notification_type VARCHAR(50) NOT NULL,
  related_entity_type VARCHAR(50),
  related_entity_id INT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create Row Level Security Policies

-- Warehouse access policy
CREATE POLICY warehouse_access_policy ON warehouses
  USING (id IN (
    SELECT warehouse_id FROM warehouse_access WHERE user_id = auth.uid()
  ));

-- Climate data access policy
CREATE POLICY climate_data_access_policy ON climate_data
  USING (warehouse_id IN (
    SELECT warehouse_id FROM warehouse_access WHERE user_id = auth.uid()
  ));

-- Equipment access policy
CREATE POLICY equipment_access_policy ON equipment
  USING (warehouse_id IN (
    SELECT warehouse_id FROM warehouse_access WHERE user_id = auth.uid()
  ));

-- Activities access policy
CREATE POLICY activities_access_policy ON activities
  USING (warehouse_id IN (
    SELECT warehouse_id FROM warehouse_access WHERE user_id = auth.uid()
  ));

-- User profile access policy
CREATE POLICY user_profile_access_policy ON user_profiles
  USING (id = auth.uid());

-- Enable Row Level Security on all tables
ALTER TABLE warehouses ENABLE ROW LEVEL SECURITY;
ALTER TABLE warehouse_access ENABLE ROW LEVEL SECURITY;
ALTER TABLE climate_data ENABLE ROW LEVEL SECURITY;
ALTER TABLE climate_settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE equipment ENABLE ROW LEVEL SECURITY;
ALTER TABLE inventory_categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE inventory_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE order_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE shipments ENABLE ROW LEVEL SECURITY;
ALTER TABLE staff ENABLE ROW LEVEL SECURITY;
ALTER TABLE activities ENABLE ROW LEVEL SECURITY;
ALTER TABLE performance_metrics ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;

-- Insert default data
INSERT INTO warehouses (name, location, latitude, longitude, capacity) 
VALUES 
('Warehouse #1', 'New York, USA', 40.7128, -74.0060, 1000),
('Warehouse #2', 'Los Angeles, USA', 34.0522, -118.2437, 1500),
('Warehouse #3', 'Chicago, USA', 41.8781, -87.6298, 800);

-- Create a trigger to update updated_at timestamps
CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create triggers for tables with updated_at columns
CREATE TRIGGER update_warehouses_timestamp
BEFORE UPDATE ON warehouses
FOR EACH ROW EXECUTE PROCEDURE update_timestamp();

CREATE TRIGGER update_equipment_timestamp
BEFORE UPDATE ON equipment
FOR EACH ROW EXECUTE PROCEDURE update_timestamp();

CREATE TRIGGER update_inventory_items_timestamp
BEFORE UPDATE ON inventory_items
FOR EACH ROW EXECUTE PROCEDURE update_timestamp();

CREATE TRIGGER update_orders_timestamp
BEFORE UPDATE ON orders
FOR EACH ROW EXECUTE PROCEDURE update_timestamp();

CREATE TRIGGER update_shipments_timestamp
BEFORE UPDATE ON shipments
FOR EACH ROW EXECUTE PROCEDURE update_timestamp();

CREATE TRIGGER update_staff_timestamp
BEFORE UPDATE ON staff
FOR EACH ROW EXECUTE PROCEDURE update_timestamp();

CREATE TRIGGER update_user_profiles_timestamp
BEFORE UPDATE ON user_profiles
FOR EACH ROW EXECUTE PROCEDURE update_timestamp();
