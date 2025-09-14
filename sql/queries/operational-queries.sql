-- Operational and Administrative Queries
-- Supporting day-to-day database operations and administrative reporting
-- These queries provide essential operational data for system management

-- =====================================================
-- Query 8: Rooms Per Property with Quantities
-- =====================================================
-- Purpose: Displays room inventory for each property with availability quantities
-- Business Value: Critical for inventory management and booking capacity planning
-- Expected Output: Property-room relationships with available quantities

SELECT 
    pr.PropertyName, 
    r.RoomName, 
    prr.Quantity
FROM PropertyRoom prr
JOIN Property pr ON prr.PropertyID = pr.PropertyID
JOIN Room r ON prr.RoomID = r.RoomID
ORDER BY pr.PropertyName;

-- Sample Results:
-- PropertyName           | RoomName                | Quantity
-- Cozy Lakehouse         | Family Suite            | 2
-- Downtown Comfort Inn   | Standard Double Room    | 5
-- Downtown Comfort Inn   | Deluxe King Room        | 3
-- Modern Condo Suite     | Executive Suite         | 1
-- Modern Condo Suite     | Twin Room with City View| 2
-- Urban Studio Flat      | Single Economy Room     | 4

-- =====================================================
-- Query 9: Amenities Offered by Each Property
-- =====================================================
-- Purpose: Lists all amenities available at each property for guest information
-- Business Value: Supports marketing efforts and guest service inquiries
-- Expected Output: Property-amenity mapping for operational reference

SELECT 
    p.PropertyName, 
    a.AmenityName
FROM PropertyAmenity pa
JOIN Property p ON pa.PropertyID = p.PropertyID
JOIN Amenity a ON pa.AmenityID = a.AmenityID
ORDER BY p.PropertyName;

-- Sample Results:
-- PropertyName           | AmenityName
-- Cozy Lakehouse         | Swimming Pool
-- Cozy Lakehouse         | Airport Shuttle
-- Cozy Lakehouse         | Pet Friendly
-- Downtown Comfort Inn   | Free WiFi
-- Downtown Comfort Inn   | Breakfast Included
-- Downtown Comfort Inn   | Parking
-- Modern Condo Suite     | Free WiFi
-- Modern Condo Suite     | Fitness Center
-- Modern Condo Suite     | Breakfast Included
-- Modern Condo Suite     | Spa and Wellness Center
-- Urban Studio Flat      | Free WiFi
-- Urban Studio Flat      | Parking

-- =====================================================
-- Query 10: Users With Stored Credit Cards
-- =====================================================
-- Purpose: Shows users who have saved payment methods for quick booking processing
-- Business Value: Identifies users with streamlined payment setup for customer service
-- Expected Output: User and payment card information for account management

SELECT DISTINCT 
    u.FirstName, 
    u.LastName, 
    c.CardName, 
    c.ExpiryDate
FROM CardInfo c
JOIN [User] u ON c.UserID = u.UserID
ORDER BY u.LastName;

-- Sample Results:
-- FirstName | LastName | CardName                | ExpiryDate
-- Ava       | Chen     | Ava Chen Visa           | 2029-03-15
-- Sofia     | Martinez | Sofia Martinez Amex     | 2028-12-31
-- Daniel    | Nguyen   | Daniel Nguyen MasterCard| 2026-05-31
-- Emily     | Stone    | Emily Stone Visa        | 2027-09-30

-- =====================================================
-- Administrative Applications
-- =====================================================
-- These queries support operational efficiency:
-- 1. Inventory Management: Track room availability across all properties
-- 2. Marketing Support: Generate amenity lists for property descriptions
-- 3. Customer Service: Quick access to user payment information
-- 4. System Administration: Monitor user account completeness
-- 5. Booking Operations: Verify payment method availability before processing
