-- Booking and Guest Management Reports
-- Operational queries for reservation tracking and guest analytics
-- These queries support day-to-day booking operations and guest relationship management

-- =====================================================
-- Query 2: Bookings Report - User Names and Stay Dates
-- =====================================================
-- Purpose: Provides complete booking overview with guest details and stay periods
-- Business Value: Essential for reservation management and guest service operations
-- Expected Output: Chronological list of all bookings with guest information

SELECT 
    u.FirstName, 
    u.LastName, 
    b.CheckIn, 
    b.CheckOut
FROM Booking b
JOIN [User] u ON b.UserID = u.UserID
ORDER BY b.CheckIn DESC;

-- Sample Results:
-- FirstName | LastName | CheckIn    | CheckOut
-- Daniel    | Nguyen   | 2025-07-15 | 2025-07-18
-- Ava       | Chen     | 2025-07-10 | 2025-07-13
-- Sofia     | Martinez | 2025-07-07 | 2025-07-12
-- Daniel    | Nguyen   | 2025-07-04 | 2025-07-06
-- Emily     | Stone    | 2025-07-01 | 2025-07-05

-- =====================================================
-- Query 6: Active Guests and Their Booking Counts
-- =====================================================
-- Purpose: Identifies most active guests for loyalty program and customer retention
-- Business Value: Supports VIP guest recognition and targeted marketing campaigns
-- Expected Output: Guest ranking by booking frequency

SELECT 
    g.UserID, 
    u.FirstName, 
    u.LastName, 
    g.NumOfBookings
FROM Guest g
JOIN [User] u ON u.UserID = g.UserID
WHERE g.NumOfBookings > 0
ORDER BY g.NumOfBookings DESC;

-- Sample Results:
-- UserID | FirstName | LastName | NumOfBookings
-- 3      | Sofia     | Martinez | 10
-- 1      | Emily     | Stone    | 5
-- 2      | Daniel    | Nguyen   | 2

-- =====================================================
-- Operational Insights
-- =====================================================
-- These reports enable:
-- 1. Booking Management: Track all reservations chronologically for operations
-- 2. Guest Segmentation: Identify high-value repeat customers
-- 3. Customer Service: Quick access to guest booking history
-- 4. Marketing Targeting: Focus retention efforts on active bookers
-- 5. Capacity Planning: Understand booking patterns and guest behavior
