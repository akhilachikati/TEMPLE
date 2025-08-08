use temples;
CREATE TABLE registrations (
    registration_id INT AUTO_INCREMENT PRIMARY KEY,
    devotee_id INT NOT NULL,
    admin_id INT NOT NULL,
    seva_id INT NOT NULL,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_status ENUM('Pending', 'Paid') DEFAULT 'Pending',
    payment_amount DECIMAL(10, 2),
    registration_status ENUM('Confirmed', 'Pending', 'Cancelled') DEFAULT 'Pending',
    donation DECIMAL(10, 2) DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (devotee_id) REFERENCES devotees(devotee_id),
    FOREIGN KEY (admin_id) REFERENCES admin(admin_id),
    FOREIGN KEY (seva_id) REFERENCES seva(seva_id)
);

ALTER TABLE registrations AUTO_INCREMENT = 2025070001;
INSERT INTO registrations (
    registration_id, devotee_id, admin_id, seva_id, payment_status, payment_amount, registration_status, donation
)
VALUES
    (2025070001, 1, 1, 1, 'Pending', 0.00, 'Pending', 50.00),
    (2025070002, 2, 2, 2, 'Paid', 100.00, 'Confirmed', 30.00),
    (2025070003, 3, 3, 3, 'Pending', 0.00, 'Pending', 0.00),
    (2025070004, 4, 4, 4, 'Paid', 50.00, 'Confirmed', 20.00),
    (2025070005, 5, 5, 5, 'Paid', 200.00, 'Confirmed', 100.00),
    (2025070006, 6, 6, 6, 'Pending', 0.00, 'Pending', 10.00);
use temples;
ALTER TABLE registrations
ADD COLUMN phone_number VARCHAR(15);
UPDATE registrations SET phone_number = '+919876543210' WHERE registration_id = 2025070001;
UPDATE registrations SET phone_number = '+919876543211' WHERE registration_id = 2025070002;
UPDATE registrations SET phone_number = '+919876543212' WHERE registration_id = 2025070003;
UPDATE registrations SET phone_number = '+919876543213' WHERE registration_id = 2025070004;
UPDATE registrations SET phone_number = '+919876543214' WHERE registration_id = 2025070005;
UPDATE registrations SET phone_number = '+919876543215' WHERE registration_id = 2025070006;
ALTER TABLE registrations
ADD COLUMN email VARCHAR(100);
UPDATE registrations SET email = 'ravi.kumar@example.com'     WHERE registration_id = 2025070001;
UPDATE registrations SET email = 'anita.sharma@example.com'    WHERE registration_id = 2025070002;
UPDATE registrations SET email = 'sunil.mehta@example.com'     WHERE registration_id = 2025070003;
UPDATE registrations SET email = 'priya.patel@example.com'     WHERE registration_id = 2025070004;
UPDATE registrations SET email = 'vikram.singh@example.com'    WHERE registration_id = 2025070005;
UPDATE registrations SET email = 'neha.verma@example.com'      WHERE registration_id = 2025070006;
use temples;
ALTER TABLE registrations
ADD COLUMN aadhar_number VARCHAR(12);
UPDATE registrations SET aadhar_number = '123412341234' WHERE registration_id = 2025070001;
UPDATE registrations SET aadhar_number = '234523452345' WHERE registration_id = 2025070002;
UPDATE registrations SET aadhar_number = '345634563456' WHERE registration_id = 2025070003;
UPDATE registrations SET aadhar_number = '456745674567' WHERE registration_id = 2025070004;
UPDATE registrations SET aadhar_number = '567856785678' WHERE registration_id = 2025070005;
UPDATE registrations SET aadhar_number = '678967896789' WHERE registration_id = 2025070006;
ALTER TABLE registrations
ADD COLUMN visit_date DATE;

ALTER TABLE registrations
ADD COLUMN visit_day VARCHAR(10);

ALTER TABLE registrations
ADD COLUMN visit_time TIME;

UPDATE registrations SET 
  visit_date = '2025-08-01', 
  visit_day = 'Friday', 
  visit_time = '08:00:00'
WHERE registration_id = 2025070001;

UPDATE registrations SET 
  visit_date = '2025-08-02', 
  visit_day = 'Saturday', 
  visit_time = '09:30:00'
WHERE registration_id = 2025070002;

UPDATE registrations SET 
  visit_date = '2025-08-03', 
  visit_day = 'Sunday', 
  visit_time = '10:00:00'
WHERE registration_id = 2025070003;

UPDATE registrations SET 
  visit_date = '2025-08-04', 
  visit_day = 'Monday', 
  visit_time = '07:45:00'
WHERE registration_id = 2025070004;

UPDATE registrations SET 
  visit_date = '2025-08-05', 
  visit_day = 'Tuesday', 
  visit_time = '11:15:00'
WHERE registration_id = 2025070005;

UPDATE registrations SET 
  visit_date = '2025-08-06', 
  visit_day = 'Wednesday', 
  visit_time = '06:30:00'
WHERE registration_id = 2025070006;