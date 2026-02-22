CREATE DATABASE business_expenses_db;
USE business_expenses_db;
CREATE TABLE User (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL
);
CREATE TABLE Category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);
CREATE TABLE Payment_Method (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    payment_type VARCHAR(50) NOT NULL
);
CREATE TABLE Expense (
    expense_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    category_id INT,
    payment_id INT,
    amount DECIMAL(10,2) NOT NULL,
    expense_date DATE NOT NULL,
    description VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (category_id) REFERENCES Category(category_id),
    FOREIGN KEY (payment_id) REFERENCES Payment_Method(payment_id)
);
INSERT INTO User (user_name, email, password, role) VALUES
('Rahul Sharma', 'rahul@gmail.com', 'rahul123', 'Admin'),
('Priya Patel', 'priya@gmail.com', 'priya123', 'User'),
('Amit Joshi', 'amit@gmail.com', 'amit123', 'User'),
('Sneha Mehta', 'sneha@gmail.com', 'sneha123', 'User');
INSERT INTO Category (category_name) VALUES
('Travel'),
('Food'),
('Office Supplies'),
('Utilities'),
('Maintenance');
INSERT INTO Payment_Method (payment_type) VALUES
('Cash'),
('UPI'),
('Credit Card'),
('Debit Card'),
('Net Banking');
INSERT INTO Expense (user_id, category_id, payment_id, amount, expense_date, description) VALUES
(1, 2, 2, 250.00, '2025-01-05', 'Lunch with client'),
(2, 1, 3, 1200.00, '2025-01-08', 'Taxi fare'),
(3, 3, 4, 850.00, '2025-01-10', 'Printer ink purchase'),
(4, 4, 5, 2300.00, '2025-01-12', 'Electricity bill'),
(1, 5, 1, 600.00, '2025-01-15', 'AC servicing'),
(2, 2, 2, 180.00, '2025-01-18', 'Snacks meeting'),
(3, 1, 3, 950.00, '2025-01-20', 'Fuel expense'),
(4, 3, 4, 400.00, '2025-01-22', 'Stationery purchase'),
(1, 4, 5, 2100.00, '2025-01-25', 'Internet bill'),
(2, 2, 2, 320.00, '2025-01-28', 'Dinner with vendor');
SELECT * FROM Expense;
SELECT * FROM Expense
WHERE amount > 1000;
SELECT e.expense_id, u.user_name, c.category_name, 
       p.payment_type, e.amount, e.expense_date
FROM Expense e
JOIN User u ON e.user_id = u.user_id
JOIN Category c ON e.category_id = c.category_id
JOIN Payment_Method p ON e.payment_id = p.payment_id;
SELECT c.category_name, SUM(e.amount) AS total_expense
FROM Expense e
JOIN Category c ON e.category_id = c.category_id
GROUP BY c.category_name;
SELECT c.category_name, SUM(e.amount) AS total_expense
FROM Expense e
JOIN Category c ON e.category_id = c.category_id
GROUP BY c.category_name
HAVING SUM(e.amount) > 2000;
SELECT * FROM Expense
WHERE amount > (SELECT AVG(amount) FROM Expense);
CREATE VIEW expense_report AS
SELECT e.expense_id, u.user_name, c.category_name,
       p.payment_type, e.amount, e.expense_date
FROM Expense e
JOIN User u ON e.user_id = u.user_id
JOIN Category c ON e.category_id = c.category_id
JOIN Payment_Method p ON e.payment_id = p.payment_id;
SELECT * FROM expense_report;
SET autocommit = 0;
START TRANSACTION;
INSERT INTO Expense (user_id, category_id, payment_id, amount, expense_date, description)
VALUES (1, 2, 1, 500.00, '2026-02-15', 'Stationery purchase');
UPDATE Category
SET category_name = 'Office Materials'
WHERE category_id = 2;
COMMIT;
ROLLBACK;
SET autocommit = 1;