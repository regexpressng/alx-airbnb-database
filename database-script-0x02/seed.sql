-- Sample Users
INSERT INTO users (first_name, last_name, email, password_hash, phone_number, role)
VALUES
('Alice', 'Johnson', 'alice@example.com', 'hashed_password_1', '08012345678', 'guest'),
('Bob', 'Smith', 'bob@example.com', 'hashed_password_2', '08098765432', 'host'),
('Charlie', 'Brown', 'charlie@example.com', 'hashed_password_3', NULL, 'guest'),
('Diana', 'Prince', 'diana@example.com', 'hashed_password_4', '08055555555', 'host');

-- Sample Properties
INSERT INTO properties (host_id, name, description, location, pricepernight)
VALUES
((SELECT user_id FROM users WHERE email='bob@example.com'), 'Cozy Apartment', '2-bedroom apartment near downtown', 'Lagos', 50.00),
((SELECT user_id FROM users WHERE email='bob@example.com'), 'Luxury Villa', 'Spacious villa with pool', 'Abuja', 200.00),
((SELECT user_id FROM users WHERE email='diana@example.com'), 'Beach House', 'Sea view house for vacation', 'Port Harcourt', 150.00);

-- Sample Bookings
INSERT INTO bookings (property_id, user_id, start_date, end_date, total_price, status)
VALUES
((SELECT property_id FROM properties WHERE name='Cozy Apartment'), (SELECT user_id FROM users WHERE email='alice@example.com'), '2025-09-01', '2025-09-05', 250.00, 'confirmed'),
((SELECT property_id FROM properties WHERE name='Luxury Villa'), (SELECT user_id FROM users WHERE email='charlie@example.com'), '2025-10-10', '2025-10-15', 1000.00, 'pending'),
((SELECT property_id FROM properties WHERE name='Beach House'), (SELECT user_id FROM users WHERE email='alice@example.com'), '2025-12-01', '2025-12-07', 1050.00, 'confirmed');

-- Sample Payments
INSERT INTO payments (booking_id, amount, payment_method)
VALUES
((SELECT booking_id FROM bookings WHERE total_price=250.00), 250.00, 'credit_card'),
((SELECT booking_id FROM bookings WHERE total_price=1000.00), 500.00, 'paypal'),
((SELECT booking_id FROM bookings WHERE total_price=1050.00), 1050.00, 'stripe');

-- Sample Reviews
INSERT INTO reviews (property_id, user_id, rating, comment)
VALUES
((SELECT property_id FROM properties WHERE name='Cozy Apartment'), (SELECT user_id FROM users WHERE email='alice@example.com'), 5, 'Great stay, very comfortable!'),
((SELECT property_id FROM properties WHERE name='Luxury Villa'), (SELECT user_id FROM users WHERE email='charlie@example.com'), 4, 'Spacious and clean, but a bit pricey.'),
((SELECT property_id FROM properties WHERE name='Beach House'), (SELECT user_id FROM users WHERE email='alice@example.com'), 5, 'Amazing view and perfect for vacation.');

-- Sample Messages
INSERT INTO messages (sender_id, recipient_id, message_body)
VALUES
((SELECT user_id FROM users WHERE email='alice@example.com'), (SELECT user_id FROM users WHERE email='bob@example.com'), 'Hi Bob, I am interested in booking your apartment next month.'),
((SELECT user_id FROM users WHERE email='charlie@example.com'), (SELECT user_id FROM users WHERE email='diana@example.com'), 'Hello Diana, is the beach house available in December?'),
((SELECT user_id FROM users WHERE email='bob@example.com'), (SELECT user_id FROM users WHERE email='alice@example.com'), 'Hi Alice, your booking is confirmed!');
