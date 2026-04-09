-- USERS TABLE
CREATE TABLE users (
    user_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    phone_number VARCHAR(15),
    mail_id VARCHAR(100),
    billing_address TEXT
);

-- BOOKINGS TABLE
CREATE TABLE bookings (
    booking_id VARCHAR(50) PRIMARY KEY,
    booking_date TIMESTAMP,
    room_no VARCHAR(50),
    user_id VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- ITEMS TABLE
CREATE TABLE items (
    item_id VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(100),
    item_rate DECIMAL(10,2)
);

-- BOOKING COMMERCIALS
CREATE TABLE booking_commercials (
    id VARCHAR(50) PRIMARY KEY,
    booking_id VARCHAR(50),
    bill_id VARCHAR(50),
    bill_date TIMESTAMP,
    item_id VARCHAR(50),
    item_quantity DECIMAL(10,2),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

-- USERS
INSERT INTO users VALUES
('u1', 'John Doe', '9876543210', 'john@example.com', 'Delhi'),
('u2', 'Alice Smith', '9123456780', 'alice@example.com', 'Mumbai'),
('u3', 'Bob Lee', '9988776655', 'bob@example.com', 'Bangalore');

-- BOOKINGS
INSERT INTO bookings VALUES
('b1', '2021-11-10 10:00:00', 'R101', 'u1'),
('b2', '2021-11-15 12:00:00', 'R102', 'u1'),
('b3', '2021-10-05 09:30:00', 'R103', 'u2'),
('b4', '2021-11-20 14:00:00', 'R104', 'u3');

-- ITEMS
INSERT INTO items VALUES
('i1', 'Tawa Paratha', 20),
('i2', 'Mix Veg', 100),
('i3', 'Paneer Butter Masala', 200);

-- BOOKING COMMERCIALS
INSERT INTO booking_commercials VALUES
('c1', 'b1', 'bill1', '2021-11-10 12:00:00', 'i1', 2),
('c2', 'b1', 'bill1', '2021-11-10 12:00:00', 'i2', 1),
('c3', 'b2', 'bill2', '2021-11-15 13:00:00', 'i3', 3),
('c4', 'b3', 'bill3', '2021-10-05 10:00:00', 'i2', 15),
('c5', 'b4', 'bill4', '2021-11-20 15:00:00', 'i1', 5);

select * from booking_commercials
select * from items
select * from bookings
select * from users

