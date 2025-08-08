USE temples;

-- Create table (only run once)
CREATE TABLE IF NOT EXISTS devotees (
    devotee_id INT AUTO_INCREMENT UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    age INT CHECK (age >= 0),
    phone_number VARCHAR(15) NOT NULL,
    email VARCHAR(100),
    aadhar_number CHAR(12) PRIMARY KEY,
    visit_date DATE NOT NULL,
    visit_time TIME NOT NULL,
    visit_day VARCHAR(10),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert data
INSERT INTO devotees (
    first_name, last_name, gender, age, phone_number, email, aadhar_number, visit_date, visit_time, visit_day
)
VALUES
    ('Meera', 'Bhat', 'Female', 29, '+919876543998', 'meera.bhat2025@devotee.com', '234567890123', '2025-07-16', '11:30:00', 'Wednesday'),
    ('Sanjay', 'Kumar', 'Male', 41, '+919876543997', 'sanjay.kumar2025@devotee.com', '345678901234', '2025-07-17', '08:00:00', 'Thursday'),
    ('Kavita', 'Gupta', 'Female', 36, '+919876543996', 'kavita.gupta2025@devotee.com', '456789012345', '2025-07-18', '17:00:00', 'Friday'),
    ('Rajesh', 'Rai', 'Male', 37, '+919876543995', 'rajesh.rai2025@devotee.com', '567890123456', '2025-07-19', '08:30:00', 'Saturday'),
    ('Priyanka', 'Nair', 'Female', 34, '+919876543994', 'priyanka.nair2025@devotee.com', '678901234567', '2025-07-20', '12:00:00', 'Sunday'),
    ('Vikrant', 'Soni', 'Male', 28, '+919876543993', 'vikrant.soni2025@devotee.com', '789012345678', '2025-07-21', '09:00:00', 'Monday');