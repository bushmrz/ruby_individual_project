USE carshering;

-- Table 1: Owner
CREATE TABLE Owner
(
    OwnerID   INT PRIMARY KEY AUTO_INCREMENT,
    FirstName  VARCHAR(50) NOT NULL,
    LastName   VARCHAR(50) NOT NULL,
    FatherName VARCHAR(50)
);

-- Table 2: Tenant
CREATE TABLE Tenant
(
    TenantID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName  VARCHAR(50) NOT NULL,
    LastName   VARCHAR(50) NOT NULL,
    Phone      VARCHAR(25)
);
-- Table 3: Car
CREATE TABLE Car
(
    CarID      INT PRIMARY KEY AUTO_INCREMENT,
    Model       VARCHAR(255) NOT NULL,
    OwnerID    INT NOT NULL,
    TenantID INT NOT NULL,
    FOREIGN KEY (OwnerID) REFERENCES Owner (OwnerID),
    FOREIGN KEY (TenantID) REFERENCES Tenant (TenantID)
);
