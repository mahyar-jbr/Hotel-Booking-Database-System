-- Hotel Booking Database Schema
-- Comprehensive database for managing hotel reservations and properties
-- Supports user management, property listings, bookings, payments, and reviews
-- Designed for scalability and data integrity

-- =====================================================
-- LOOKUP AND REFERENCE TABLES
-- =====================================================

-- Genius loyalty program levels
CREATE TABLE GeniusLevel (
    LevelID INT PRIMARY KEY,
    LevelName VARCHAR(30) NOT NULL UNIQUE,
    Discount DECIMAL(5,2) CHECK (Discount >= 0 AND Discount <= 100)
);

-- Property amenities lookup
CREATE TABLE Amenity (
    AmenityID INT PRIMARY KEY,
    AmenityName VARCHAR(50) NOT NULL UNIQUE
);

-- Room types and specifications
CREATE TABLE Room (
    RoomID INT PRIMARY KEY,
    RoomName VARCHAR(100) NOT NULL,
    RoomOccupancy INT CHECK (RoomOccupancy > 0),
    RoomSize DECIMAL(6,2),
    RoomType VARCHAR(50) NOT NULL
);

-- =====================================================
-- USER MANAGEMENT TABLES
-- =====================================================

-- Main user table supporting both guests and hosts
CREATE TABLE [User] (
    UserID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    HashedPass VARCHAR(255) NOT NULL,
    LevelID INT,
    FOREIGN KEY (LevelID) REFERENCES GeniusLevel(LevelID)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- User phone numbers (separate table for normalization)
CREATE TABLE User_PhoneNumber (
    PhoneNumber VARCHAR(20),
    UserID INT,
    PRIMARY KEY (PhoneNumber, UserID),
    FOREIGN KEY (UserID) REFERENCES [User](UserID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Guest-specific information
CREATE TABLE Guest (
    UserID INT PRIMARY KEY,
    NumOfBookings INT DEFAULT 0 CHECK (NumOfBookings >= 0),
    FOREIGN KEY (UserID) REFERENCES [User](UserID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Host-specific information and ratings
CREATE TABLE Host (
    UserID INT PRIMARY KEY,
    HostRating DECIMAL(3,2) CHECK (HostRating >= 0 AND HostRating <= 5),
    FOREIGN KEY (UserID) REFERENCES [User](UserID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- =====================================================
-- PAYMENT SYSTEM TABLES
-- =====================================================

-- User payment card information
CREATE TABLE CardInfo (
    CardID INT PRIMARY KEY,
    CardName VARCHAR(50) NOT NULL,
    ExpiryDate DATE NOT NULL,
    CardNumber VARCHAR(20) NOT NULL,
    SecurityDigits CHAR(3) NOT NULL,
    UserID INT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES [User](UserID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Payment transactions
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    Amount DECIMAL(10,2) CHECK (Amount >= 0),
    Method VARCHAR(30) NOT NULL,
    PaymentDate DATE NOT NULL,
    CardID INT NOT NULL,
    FOREIGN KEY (CardID) REFERENCES CardInfo(CardID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- =====================================================
-- BOOKING SYSTEM TABLES
-- =====================================================

-- Booking transactions
CREATE TABLE Booking (
    UserID INT NOT NULL,
    PaymentID INT NOT NULL,
    CheckIn DATE NOT NULL,
    CheckOut DATE NOT NULL,
    PRIMARY KEY (UserID, PaymentID),
    FOREIGN KEY (UserID) REFERENCES [User](UserID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (PaymentID) REFERENCES Payment(PaymentID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- =====================================================
-- REVIEW SYSTEM TABLES
-- =====================================================

-- Guest reviews for properties
CREATE TABLE Review (
    ReviewID INT PRIMARY KEY,
    Rating DECIMAL(3,2) CHECK (Rating >= 0 AND Rating <= 5),
    Description TEXT,
    UserID INT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Guest(UserID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- =====================================================
-- PROPERTY MANAGEMENT TABLES
-- =====================================================

-- Main property listings
CREATE TABLE Property (
    PropertyID INT PRIMARY KEY,
    PropertyName VARCHAR(100) NOT NULL,
    City VARCHAR(50),
    Country VARCHAR(50),
    PostalCode VARCHAR(15),
    Rating DECIMAL(3,2) CHECK (Rating >= 0 AND Rating <= 5),
    PropertyType VARCHAR(50),
    PricePerNight DECIMAL(10,2) CHECK (PricePerNight >= 0),
    UserID INT NOT NULL,
    PaymentID INT NOT NULL,
    AmenityID INT,
    RoomID INT,
    ReviewID INT,
    FOREIGN KEY (UserID) REFERENCES Host(UserID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (UserID, PaymentID) REFERENCES Booking(UserID, PaymentID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (AmenityID) REFERENCES Amenity(AmenityID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (ReviewID) REFERENCES Review(ReviewID)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- =====================================================
-- RELATIONSHIP TABLES (MANY-TO-MANY)
-- =====================================================

-- Property-Room relationships (rooms available at each property)
CREATE TABLE PropertyRoom (
    PropertyID INT NOT NULL,
    RoomID INT NOT NULL,
    Quantity INT CHECK (Quantity > 0),
    PRIMARY KEY (PropertyID, RoomID),
    FOREIGN KEY (PropertyID) REFERENCES Property(PropertyID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Property-Amenity relationships (amenities available at each property)
CREATE TABLE PropertyAmenity (
    PropertyID INT NOT NULL,
    AmenityID INT NOT NULL,
    PRIMARY KEY (PropertyID, AmenityID),
    FOREIGN KEY (PropertyID) REFERENCES Property(PropertyID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (AmenityID) REFERENCES Amenity(AmenityID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
