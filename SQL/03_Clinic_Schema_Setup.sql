-- CLINICS TABLE
CREATE TABLE clinics (
    cid VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100)
);

-- CUSTOMERS TABLE
CREATE TABLE customers (
    uid VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    mobile VARCHAR(15)
);

-- CLINIC SALES TABLE
CREATE TABLE clinic_sales (
    oid VARCHAR(50) PRIMARY KEY,
    uid VARCHAR(50),
    cid VARCHAR(50),
    amount DECIMAL(10,2),
    datetime TIMESTAMP,
    sales_channel VARCHAR(50),
    FOREIGN KEY (uid) REFERENCES customers(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

-- EXPENSES TABLE
CREATE TABLE expenses (
    eid VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50),
    description TEXT,
    amount DECIMAL(10,2),
    datetime TIMESTAMP,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

-- CLINICS
INSERT INTO clinics VALUES
('c1', 'HealthPlus', 'Delhi', 'Delhi', 'India'),
('c2', 'CarePoint', 'Mumbai', 'Maharashtra', 'India'),
('c3', 'MediLife', 'Delhi', 'Delhi', 'India');

-- CUSTOMERS
INSERT INTO customers VALUES
('u1', 'John Doe', '9876543210'),
('u2', 'Alice Smith', '9123456780'),
('u3', 'Bob Lee', '9988776655');

-- CLINIC SALES
INSERT INTO clinic_sales VALUES
('o1', 'u1', 'c1', 5000, '2021-09-10 10:00:00', 'online'),
('o2', 'u2', 'c1', 7000, '2021-09-15 12:00:00', 'offline'),
('o3', 'u3', 'c2', 3000, '2021-09-20 14:00:00', 'online'),
('o4', 'u1', 'c3', 8000, '2021-09-25 16:00:00', 'app');

-- EXPENSES
INSERT INTO expenses VALUES
('e1', 'c1', 'Supplies', 2000, '2021-09-10 09:00:00'),
('e2', 'c2', 'Maintenance', 1500, '2021-09-20 10:00:00'),
('e3', 'c3', 'Equipment', 4000, '2021-09-25 11:00:00');
