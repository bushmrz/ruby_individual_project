USE carshering;

-- Insert 30 owners
INSERT INTO Owner (FirstName, LastName, FatherName)
VALUES
       ('John', 'Doe', 'Paul'),
       ('Jane', 'Doe', NULL),
       ('Robert', 'Johnson', 'Michael'),
       ('Emily', 'Smith', NULL),
       ('David', 'Lee', 'William'),
       ('Sarah', 'Taylor', NULL),
       ('Thomas', 'Brown', NULL),
       ('Elizabeth', 'Wilson', 'Jennifer'),
       ('Richard', 'Anderson', 'Matthew'),
       ('Karen', 'Martin', NULL),
       ('William', 'Thompson', NULL),
       ('Nancy', 'Garcia', NULL),
       ('Michael', 'Davis', 'Anthony'),
       ('Mary', 'Miller', NULL),
       ('Christopher', 'Jackson', NULL),
       ('Jessica', 'Perez', 'Marie'),
       ('Brian', 'Moore', NULL),
       ('Megan', 'Allen', NULL),
       ('Anthony', 'Young', NULL),
       ('Laura', 'Harris', 'Christine'),
       ('Kevin', 'King', NULL),
       ('Stephanie', 'Scott', NULL),
       ('Jason', 'Turner', 'Eric'),
       ('Melissa', 'Walker', NULL),
       ('Mark', 'Collins', NULL),
       ('Tiffany', 'Nelson', NULL),
       ('Eric', 'Gonzalez', NULL),
       ('Amy', 'Carter', 'Jennifer'),
       ('Matthew', 'Baker', NULL),
       ('Samantha', 'Edwards', NULL);

-- Insert 9 Tenants
INSERT INTO Tenant (FirstName, LastName, Phone)
VALUES
       ('Penguin', 'Huse', '+79009009090'),
       ('Harper', 'Collins', NULL),
       ('Hachette', 'Caroup', NULL),
       ('Macmillan', 'Pusher', '+79990900909'),
       ('Simon' , 'Schuster', '+79876009090'),
       ('Oxford', 'Usiress', NULL),
       ('Cambe',  'Uveress', '+79999999999'),
       ('Pear', 'Etion', NULL),
       ('Bloom', 'Puling', '+79690807766');

INSERT INTO car(Model, OwnerID, TenantID)
VALUES
    ('BMW', 2, 4),
    ('Audi', 5, 7),
    ('Lada', 7, 4),
    ('Tesla', 12, 9);