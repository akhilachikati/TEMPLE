use temples;
CREATE TABLE admin (
    admin_id        INT PRIMARY KEY AUTO_INCREMENT,
    first_name      VARCHAR(50) NOT NULL,
    last_name       VARCHAR(50) NOT NULL,
    gender          CHAR(1) NOT NULL,
    phone_number    VARCHAR(15) NOT NULL,
    email           VARCHAR(100) NOT NULL UNIQUE,
    aadhar_number   VARCHAR(12) NOT NULL UNIQUE,
    password        VARCHAR(255) NOT NULL,
    created_at      DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
INSERT INTO admin (
    first_name, last_name, gender, phone_number, email, aadhar_number, password
)
VALUES
    ('Ravi', 'Kumar', 'M', '+919876543210', 'ravi.kumar@example.com', '123412341234', 'hashed_password_1'),
    ('Anita', 'Sharma', 'F', '+919876543211', 'anita.sharma@example.com', '234523452345', 'hashed_password_2'),
    ('Sunil', 'Mehta', 'M', '+919876543212', 'sunil.mehta@example.com', '345634563456', 'hashed_password_3'),
    ('Priya', 'Patel', 'F', '+919876543213', 'priya.patel@example.com', '456745674567', 'hashed_password_4'),
    ('Vikram', 'Singh', 'M', '+919876543214', 'vikram.singh@example.com', '567856785678', 'hashed_password_5'),
    ('Neha', 'Verma', 'F', '+919876543215', 'neha.verma@example.com', '678967896789', 'hashed_password_6'),
    ('Amit', 'Desai', 'M', '+919876543216', 'amit.desai@example.com', '789078907890', 'hashed_password_7');

use temples;
UPDATE admin
SET password = 'scrypt:32768:8:1$qhKvAP4wkAZM60Vs$b51bb840051d3cdaad6a95f241ea78d7e996d03dbdb90184116e7929dbcda0f7341dfbc30bb12effdd96d66d917a60e1b9bc360175714c4b7fa1cbc8f023446f'
WHERE email = 'ravi.kumar@example.com';
UPDATE Admin
SET password = 'scrypt:32768:8:1$Rpg5ekKk5eJ0xVn8$0101dfb121d26a6903fda185713424037dbc752e1eaae67c236564afd8483c19476a20206624501f202908414cbc1807704d5cec3c95ee0060ebde7311b97755'
WHERE email = 'anita.sharma@example.com';
UPDATE Admin
SET password = 'scrypt:32768:8:1$DkdmZpqcbr6258UT$3eaeba507899b54794ec29636f4f65535d37f4e01c339e4f25b4bb23c3d3493b3c89b79b8fa9c1b9a9557d180ca3c4a3aa10e92206691f964934736639dc29f2'
WHERE email = 'sunil.mehta@example.com';
UPDATE Admin
SET password = 'scrypt:32768:8:1$cRjV11PiTenuvGA0$fc26951ea42305aa8f1680b942aac2c50e2aad6bd10d29afd446cfd15ed528bc47043c2b51d43d056c303aacaf49369e2abc7efd7c92f9af8893cbb3271932bc'
WHERE email = 'priya.patel@example.com';
UPDATE Admin
SET password = 'scrypt:32768:8:1$FFDhasHkDhO2tdA0$e71f671055b254201d9d55db9af29dc408c0d01a7e881b8e73b1326994b49a40ea59098fd124c740b2dbfb3d4bd5c485f62b626890a40845a97f39a1286deb28'
WHERE email = 'vikram.singh@example.com';
UPDATE Admin
SET password = 'scrypt:32768:8:1$VRaVHUH1AJSwCe5R$742911ce0bf8bf9181407e243d35f538617996a473655e6827ba65968fb4da2c9da8dcf4f2f95e0c1b7be62896ad0480fcd76bb11e51a693cc112310758bea55'
WHERE email = 'neha.verma@example.com';
UPDATE Admin
SET password = 'scrypt:32768:8:1$sb4fof2YhYHxMISC$6d1aaaba4498b0f8eeb2bae1e5d22f434176b418d5d0e8436f693ccda81ce4429f80aa9b772753b5f4c39a425a41633a94c0ad91b2e913a0e6aa3c2ea7fcfc8d'
WHERE email = 'amit.desai@example.com';