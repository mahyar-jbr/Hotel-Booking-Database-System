-- Sample Data for Hotel Booking Database
-- Realistic test data demonstrating system capabilities
-- Execute after running the schema creation scripts

-- =====================================================
-- LOOKUP AND REFERENCE DATA
-- =====================================================

-- Genius loyalty program levels
INSERT INTO GeniusLevel (LevelID, LevelName, Discount) VALUES
(1, 'Basic', 0.00),
(2, 'Genius Level 1', 10.00),
(3, 'Genius Level 2', 15.00),
(4, 'Genius Level 3', 20.00);

-- Property amenities
INSERT INTO Amenity (AmenityID, AmenityName) VALUES
(1, 'Free WiFi'),
(2, 'Swimming Pool'),
(3, 'Fitness Center'),
(4, 'Airport Shuttle'),
(5, 'Pet Friendly'),
(6, 'Breakfast Included'),
(7, 'Parking'),
(8, 'Spa and Wellness Center');

-- Room types and specifications
INSERT INTO Room (RoomID, RoomName, RoomOccupancy, RoomSize, RoomType) VALUES
(101, 'Standard Double Room', 2, 25.00, 'Standard'),
(102, 'Deluxe King Room', 2, 35.00, 'Deluxe'),
(103, 'Family Suite', 4, 50.00, 'Suite'),
(104, 'Single Economy Room', 1, 18.50, 'Economy'),
(105, 'Executive Suite', 2, 45.00, 'Suite'),
(106, 'Twin Room with City View', 2, 28.00, 'Standard');

-- =====================================================
-- USER DATA
-- =====================================================

-- Main user accounts (guests and hosts)
INSERT INTO [User] (UserID, FirstName, LastName, Email, HashedPass, LevelID) VALUES
(1, 'Emily', 'Stone', 'emily.stone@example.com', 'hashed_pass_1', 2),
(2, 'Daniel', 'Nguyen', 'dan.nguyen@example.com', 'hashed_pass_2', 3),
(3, 'Sofia', 'Martinez', 'sofia.martinez@example.com', 'hashed_pass_3', 1),
(4, 'Liam', 'Brien', 'liam.obrien@example.com', 'hashed_pass_4', NULL),
(5, 'Ava', 'Chen', 'ava.chen@example.com', 'hashed_pass_5', 4);

-- User phone numbers
INSERT INTO User_PhoneNumber (PhoneNumber, UserID) VALUES
('4161234567', 1),
('6479876543', 1),
('5143337788', 2),
('9057779999', 3),
('4382224455', 4),
('6041112222', 5),
('6043334444', 5);

-- Guest-specific information
INSERT INTO Guest (UserID, NumOfBookings) VALUES
(1, 5),
(2, 2),
(3, 10),
(4, 0);

-- Host-specific information
INSERT INTO Host (UserID, HostRating) VALUES
(2, 4.75),
(5, 4.90);

-- =====================================================
-- PAYMENT SYSTEM DATA
-- =====================================================

-- User payment cards
INSERT INTO CardInfo (CardID, CardName, ExpiryDate, CardNumber, SecurityDigits, UserID) VALUES
(1, 'Emily Stone Visa', '2027-09-30', '4111111111111111', '123', 1),
(2, 'Daniel Nguyen MasterCard', '2026-05-31', '5500000000000004', '456', 2),
(3, 'Sofia Martinez Amex', '2028-12-31', '340000000000009', '789', 3),
(4, 'Ava Chen Visa', '2029-03-15', '4111111111112222', '321', 5);

-- Payment transactions
INSERT INTO Payment (PaymentID, Amount, Method, PaymentDate, CardID) VALUES
(1, 120.50, 'Credit Card', '2025-07-01', 1),
(2, 89.99, 'Credit Card', '2025-07-03', 2),
(3, 215.00, 'Debit Card', '2025-07-05', 3),
(4, 150.25, 'Visa', '2025-07-10', 4),
(5, 330.75, 'MasterCard', '2025-07-15', 2);

-- =====================================================
-- BOOKING DATA
-- =====================================================

-- Booking reservations
INSERT INTO Booking (UserID, PaymentID, CheckIn, CheckOut) VALUES
(1, 1, '2025-07-01', '2025-07-05'),
(2, 2, '2025-07-04', '2025-07-06'),
(3, 3, '2025-07-07', '2025-07-12'),
(5, 4, '2025-07-10', '2025-07-13'),
(2, 5, '2025-07-15', '2025-07-18');

-- =====================================================
-- REVIEW DATA
-- =====================================================

-- Guest reviews for properties
INSERT INTO Review (ReviewID, Rating, Description, UserID) VALUES
(1, 4.5, 'Great place, clean and cozy. Host was very helpful!', 1),
(2, 3.8, 'Nice location but the room was smaller than expected.', 2),
(3, 5.0, 'Amazing experience! Will definitely book again.', 3),
(4, 2.5, 'The room wasn''t very clean and had a strange odor.', 4);

-- =====================================================
-- PROPERTY DATA
-- =====================================================

-- Property listings
INSERT INTO Property (PropertyID, PropertyName, City, Country, PostalCode, Rating, PropertyType, PricePerNight, UserID, PaymentID, AmenityID, RoomID, ReviewID) VALUES
(1, 'Downtown Comfort Inn', 'Toronto', 'Canada', 'M5H 2N2', 4.50, 'Hotel', 110.00, 2, 2, 1, 101, 2),
(2, 'Cozy Lakehouse', 'Muskoka', 'Canada', 'P1H 2M3', 4.90, 'Cabin', 160.00, 5, 4, 2, 102, 4),
(3, 'Modern Condo Suite', 'Vancouver', 'Canada', 'V6B 1G1', 4.30, 'Apartment', 140.00, 5, 4, 6, 103, 3),
(4, 'Urban Studio Flat', 'Montreal', 'Canada', 'H2X 1Y4', 3.80, 'Studio', 95.00, 2, 5, 3, 104, 1);

-- =====================================================
-- RELATIONSHIP DATA (MANY-TO-MANY)
-- =====================================================

-- Property-Room relationships
INSERT INTO PropertyRoom (PropertyID, RoomID, Quantity) VALUES
(1, 101, 5),
(1, 102, 3),
(2, 103, 2),
(3, 105, 1),
(3, 106, 2),
(4, 104, 4);

-- Property-Amenity relationships
INSERT INTO PropertyAmenity (PropertyID, AmenityID) VALUES
(1, 1),  -- Downtown Comfort Inn: Free WiFi
(1, 6),  -- Downtown Comfort Inn: Breakfast Included
(1, 7),  -- Downtown Comfort Inn: Parking
(2, 2),  -- Cozy Lakehouse: Swimming Pool
(2, 4),  -- Cozy Lakehouse: Airport Shuttle
(2, 5),  -- Cozy Lakehouse: Pet Friendly
(3, 1),  -- Modern Condo Suite: Free WiFi
(3, 3),  -- Modern Condo Suite: Fitness Center
(3, 6),  -- Modern Condo Suite: Breakfast Included
(3, 8),  -- Modern Condo Suite: Spa and Wellness Center
(4, 1),  -- Urban Studio Flat: Free WiFi
(4, 7);  -- Urban Studio Flat: Parking

-- =====================================================
-- DATA VERIFICATION QUERIES
-- =====================================================

-- Uncomment these queries to verify data integrity after insertion:

-- SELECT 'Users' AS TableName, COUNT(*) AS RecordCount FROM [User]
-- UNION ALL
-- SELECT 'Properties', COUNT(*) FROM Property
-- UNION ALL  
-- SELECT 'Bookings', COUNT(*) FROM Booking
-- UNION ALL
-- SELECT 'Reviews', COUNT(*) FROM Review
-- UNION ALL
-- SELECT 'Payments', COUNT(*) FROM Payment;
