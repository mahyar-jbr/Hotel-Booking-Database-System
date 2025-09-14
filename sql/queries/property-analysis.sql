-- Property Performance Analysis Queries
-- Supporting property management and market analysis
-- These queries help understand property popularity, ratings, and host performance

-- =====================================================
-- Query 3: Most Booked Properties
-- =====================================================
-- Purpose: Identifies properties with highest booking frequency
-- Business Value: Reveals popular properties for marketing insights and capacity optimization
-- Expected Output: Properties ranked by total number of bookings

SELECT 
    p.PropertyName, 
    COUNT(*) AS NumBookings
FROM Property p
JOIN Booking b ON p.UserID = b.UserID AND p.PaymentID = b.PaymentID
GROUP BY p.PropertyName
ORDER BY NumBookings DESC;

-- Sample Results:
-- PropertyName         | NumBookings
-- Cozy Lakehouse       | 1
-- Downtown Comfort Inn | 1
-- Modern Condo Suite   | 1
-- Urban Studio Flat    | 1

-- =====================================================
-- Query 4: Top Rated Properties
-- =====================================================
-- Purpose: Displays properties ranked by guest satisfaction ratings
-- Business Value: Identifies quality properties for featuring and best practice analysis
-- Expected Output: Properties sorted by rating with location details

SELECT 
    PropertyName, 
    City, 
    Country, 
    Rating
FROM Property
ORDER BY Rating DESC;

-- Sample Results:
-- PropertyName         | City      | Country | Rating
-- Cozy Lakehouse       | Muskoka   | Canada  | 4.90
-- Downtown Comfort Inn | Toronto   | Canada  | 4.50
-- Modern Condo Suite   | Vancouver | Canada  | 4.30
-- Urban Studio Flat    | Montreal  | Canada  | 3.80

-- =====================================================
-- Query 7: Host Ratings Report
-- =====================================================
-- Purpose: Evaluates host performance based on their ratings
-- Business Value: Supports host relationship management and quality assurance programs
-- Expected Output: Hosts ranked by their performance ratings

SELECT 
    h.UserID, 
    u.FirstName, 
    u.LastName, 
    h.HostRating
FROM Host h
JOIN [User] u ON u.UserID = h.UserID
ORDER BY h.HostRating DESC;

-- Sample Results:
-- UserID | FirstName | LastName | HostRating
-- 5      | Ava       | Chen     | 4.90
-- 2      | Daniel    | Nguyen   | 4.75

-- =====================================================
-- Property Management Insights
-- =====================================================
-- These analytics support strategic decisions:
-- 1. Market Position: Understand which properties attract most bookings
-- 2. Quality Standards: Identify top-rated properties for case studies
-- 3. Host Development: Focus support on lower-rated hosts for improvement
-- 4. Investment Priorities: Guide property development based on performance metrics
-- 5. Guest Satisfaction: Monitor property ratings for quality assurance
