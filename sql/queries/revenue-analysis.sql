-- Revenue Analysis Queries
-- Supporting business intelligence and financial reporting
-- These queries help management understand revenue patterns and host performance

-- =====================================================
-- Query 1: Total Revenue by Host
-- =====================================================
-- Purpose: Identifies which hosts generate the most revenue for the platform
-- Business Value: Helps prioritize host relationships and identify top performers
-- Expected Output: Host details with total revenue generated

SELECT 
    h.UserID, 
    u.FirstName, 
    u.LastName, 
    SUM(p.Amount) AS TotalRevenue
FROM Host h
JOIN [User] u ON u.UserID = h.UserID
JOIN Property pr ON pr.UserID = h.UserID
JOIN Payment p ON pr.PaymentID = p.PaymentID
GROUP BY h.UserID, u.FirstName, u.LastName
ORDER BY TotalRevenue DESC;

-- Sample Results:
-- UserID | FirstName | LastName | TotalRevenue
-- 2      | Daniel    | Nguyen   | 420.74
-- 5      | Ava       | Chen     | 300.50

-- =====================================================
-- Query 5: Monthly Revenue Report
-- =====================================================
-- Purpose: Tracks revenue trends over time for financial planning
-- Business Value: Enables monthly performance analysis and forecasting
-- Expected Output: Month-by-month revenue breakdown

SELECT
    FORMAT(PaymentDate, 'yyyy-MM') AS Month,
    SUM(Amount) AS MonthlyRevenue
FROM Payment
GROUP BY FORMAT(PaymentDate, 'yyyy-MM')
ORDER BY Month;

-- Sample Results:
-- Month   | MonthlyRevenue
-- 2025-07 | 906.49

-- =====================================================
-- Business Intelligence Notes
-- =====================================================
-- These queries support key business decisions:
-- 1. Host Performance: Identify top revenue-generating hosts for partnership programs
-- 2. Seasonal Trends: Track monthly patterns for capacity planning
-- 3. Financial Forecasting: Use historical data for budget predictions
-- 4. Commission Optimization: Understand revenue distribution for pricing strategies
