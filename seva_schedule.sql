use temples;
CREATE TABLE seva_schedule (
    seva_id INT auto_increment primary key,
    seva_type VARCHAR(50),
    seva_date DATE NOT NULL,
    seva_time TIME,
    FOREIGN KEY (seva_id) REFERENCES seva(seva_id)
);

INSERT INTO seva_schedule (seva_id, seva_type, seva_date, seva_time) VALUES
(1, 'Archana', '2025-07-15', '10:00:00'),
(2, 'Abhishekam', '2025-07-16', '11:30:00'),
(3, 'Puja', '2025-07-17', '08:00:00'),
(4, 'Vahan Seva', '2025-07-18', '17:00:00'),
(6, 'Annadanam', '2025-07-19', '12:00:00'),
(7, 'Kalyanotsavam', '2025-07-20', '09:00:00');