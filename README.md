# Hotel Booking Database System

A comprehensive relational database system modeled after Booking.com's core functionality, designed to handle hotel reservations, property management, and user interactions at scale.

## 🎯 Project Overview

This project implements a normalized relational database schema that captures the essential features of a hotel booking platform, including user management (guests and hosts), property listings, room reservations, payment processing, reviews, and loyalty programs.

## ✨ Key Features

- **Dual User System**: Separate registration and authentication flows for guests and property hosts
- **Property Management**: Complete property and room listing system with amenities and availability tracking
- **Booking Engine**: Full reservation system with date validation and conflict prevention
- **Payment Integration**: Secure payment processing with stored payment methods
- **Review System**: Guest feedback and rating system for properties
- **Loyalty Program**: Genius-level rewards system for repeat customers
- **Advanced Search**: Multi-criteria property search with filtering capabilities

## 🏗️ Database Architecture

### Entity-Relationship Diagram
![ER Diagram](docs/er-diagram.png)

### Database Schema
![Database Schema](docs/database-schema.png)

### Entity-Relationship Model
The database follows a normalized design with proper foreign key relationships and data integrity constraints:

- **Users**: Guest and Host user management with role-based access
- **Properties**: Hotel and accommodation listings with detailed information
- **Rooms**: Individual room inventory with pricing and availability
- **Bookings**: Reservation management with date validation
- **Reviews**: Customer feedback system
- **Payments**: Secure transaction processing
- **Amenities**: Property features and facilities

### Key Design Decisions
- Implemented proper normalization to eliminate data redundancy
- Used cascading deletes for maintaining referential integrity
- Designed for horizontal scalability with indexed primary keys
- Separated user roles while maintaining unified authentication

## 🛠️ Technical Implementation

### Database Management System
- **Platform**: Microsoft SQL Server
- **Development Environment**: Visual Studio Code with SQL extensions
- **Design Tools**: ER diagram modeling and relational schema design

### Schema Highlights
```sql
-- Example table structure
CREATE TABLE Properties (
    PropertyID INT PRIMARY KEY IDENTITY(1,1),
    HostID INT FOREIGN KEY REFERENCES Users(UserID),
    PropertyName NVARCHAR(100) NOT NULL,
    Location NVARCHAR(200) NOT NULL,
    PropertyType NVARCHAR(50) NOT NULL,
    Rating DECIMAL(3,2) DEFAULT 0.00,
    CreatedDate DATETIME DEFAULT GETDATE()
);
```

## 📊 Advanced SQL Queries

The system includes sophisticated queries for business intelligence and application functionality:

- Revenue analysis by host and time period
- Property performance metrics and ratings
- User booking history and loyalty tracking
- Room availability and occupancy reports
- Dynamic pricing and inventory management

## 🎮 Demo Queries

### Revenue Analysis
```sql
-- Total revenue by host
SELECT 
    u.FirstName + ' ' + u.LastName AS HostName,
    SUM(p.Amount) AS TotalRevenue,
    COUNT(b.BookingID) AS TotalBookings
FROM Users u
JOIN Properties pr ON u.UserID = pr.HostID
JOIN Bookings b ON pr.PropertyID = b.PropertyID
JOIN Payments p ON b.PaymentID = p.PaymentID
GROUP BY u.UserID, u.FirstName, u.LastName
ORDER BY TotalRevenue DESC;
```

### Property Performance
```sql
-- Top-rated properties with booking counts
SELECT 
    p.PropertyName,
    p.Rating,
    COUNT(b.BookingID) AS BookingCount,
    AVG(r.Rating) AS AverageReviewRating
FROM Properties p
LEFT JOIN Bookings b ON p.PropertyID = b.PropertyID
LEFT JOIN Reviews r ON p.PropertyID = r.PropertyID
GROUP BY p.PropertyID, p.PropertyName, p.Rating
HAVING COUNT(b.BookingID) > 0
ORDER BY p.Rating DESC, BookingCount DESC;
```

## 🚀 Getting Started

### Prerequisites
- SQL Server 2019 or later
- SQL Server Management Studio or Visual Studio Code with SQL extension
- Basic understanding of relational databases

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/mahyar-jbr/Hotel-Booking-Database-System
   cd Hotel-Booking-Database-System
   ```

2. Execute the database creation scripts:
   ```sql
   -- Run in order:
   -- 1. schema-creation.sql
   -- 2. sample-data.sql
   -- 3. indexes-and-constraints.sql
   ```

3. Test with sample queries:
   ```sql
   -- Execute queries from /queries/ folder
   ```

## 📁 Project Structure

```
hotel-booking-database/
├── sql/
│   ├── schema/
│   │   ├── create-tables.sql
│   │   ├── constraints.sql
│   │   └── indexes.sql
│   ├── data/
│   │   └── sample-data.sql
│   └── queries/
│       ├── business-intelligence/
│       ├── application-queries/
│       └── reports/
├── docs/
│   ├── er-diagram.png
│   ├── relational-schema.png
│   └── technical-report.pdf
├── README.md
└── LICENSE
```

## 🎯 Learning Outcomes

This project demonstrates proficiency in:
- **Database Design**: ER modeling, normalization, and schema optimization
- **SQL Development**: Complex queries, joins, subqueries, and stored procedures
- **Data Integrity**: Constraints, triggers, and referential integrity
- **Performance Optimization**: Indexing strategies and query optimization
- **Business Analysis**: Translating real-world requirements into data models

## 🤝 Contributing

While this is a personal project, I'm open to suggestions and improvements! Feel free to:
- Report issues or bugs
- Suggest performance optimizations  
- Recommend additional features
- Submit pull requests for enhancements

---

**Note**: This project demonstrates core database design principles and SQL development skills applicable to real-world e-commerce platforms.
