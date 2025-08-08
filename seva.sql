create database temples;
use temples;
CREATE TABLE seva (
    seva_id       INT PRIMARY KEY AUTO_INCREMENT,
    seva_type     VARCHAR(100) NOT NULL,         
    description      TEXT,
    seva_date     DATE NOT NULL,
    seva_time     TIME NOT NULL,
    day              VARCHAR(20),                   
    duration         VARCHAR(20),                   
    amount           DECIMAL(10,2) DEFAULT 0.00,    
    slots_available  INT NOT NULL
);
INSERT INTO seva (
    seva_type, description, seva_date, seva_time, day, duration, amount, slots_available
)
VALUES
    ('Archana', 
    'Chanting specific mantras and offering flowers and fruits to the deity to invoke divine blessings.',
    '2025-07-15', '10:00:00', 'Tuesday', '30 minutes', 50.00, 20),
    ('Abhishekam', 
    'Bathing the deity with sacred liquids like milk, honey, water, and ghee for purification and consecration.',
    '2025-07-16', '11:30:00', 'Wednesday', '1 hour', 100.00, 15),
    ('Puja', 
    'A formal worship ritual that includes chanting, offerings, and prayers to honor the deity.',
    '2025-07-17', '08:00:00', 'Thursday', '45 minutes', 75.00, 25),
    ('Vahan Seva', 
    'Offering the vehicle (mount) of the deity, such as a horse, elephant, or chariot, during a public procession.',
    '2025-07-18', '17:00:00', 'Friday', '2 hours', 200.00, 10),
    ('Rath Yatra', 
    'A procession of the deity in a chariot around the temple or town, followed by a large group of devotees.',
    '2025-07-19', '08:00:00', 'Saturday', '4 hours', 150.00, 30),

    ('Annadanam', 
    'Offering food to the deity and then distributing it as prasadam to the devotees.',
    '2025-07-20', '12:00:00', 'Sunday', '1 hour', 50.00, 50),
    ('Kalyanotsavam', 
    'The ceremonial re-enactment of the divine marriage of the deities to invoke prosperity and harmony for the devotees.',
    '2025-07-21', '09:00:00', 'Monday', '2 hours', 300.00, 5);