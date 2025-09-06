-- Create indexes on frequently queried columns

-- Index on users.email (commonly used for login/search)
CREATE INDEX idx_users_email ON users(email);

-- Index on bookings.user_id (frequently used in joins and filters)
CREATE INDEX idx_bookings_user_id ON bookings(user_id);

-- Index on bookings.property_id (joins and aggregations)
CREATE INDEX idx_bookings_property_id ON bookings(property_id);

-- Index on properties.location (often searched/filtered by location)
CREATE INDEX idx_properties_location ON properties(location);

-- Index on properties.name for faster text-based search
CREATE INDEX idx_properties_name ON properties(name);

EXPLAIN ANALYZE
SELECT u.name, COUNT(b.id) AS total_bookings
FROM users u
JOIN bookings b ON u.id = b.user_id
GROUP BY u.id, u.name
ORDER BY total_bookings DESC;