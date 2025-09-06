-- Drop the table if it already exists (for clean setup during testing)
DROP TABLE IF EXISTS bookings CASCADE;

-- Recreate the bookings table with partitioning by RANGE on start_date
CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) PARTITION BY RANGE (start_date);

-- Create partitions for different years (example: 2023, 2024, 2025)
CREATE TABLE bookings_2023 PARTITION OF bookings
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE bookings_2024 PARTITION OF bookings
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE bookings_2025 PARTITION OF bookings
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Optional: Default partition for any date outside defined ranges
CREATE TABLE bookings_default PARTITION OF bookings DEFAULT;

-- Example query to test performance improvement
EXPLAIN ANALYZE
SELECT * 
FROM bookings
WHERE start_date BETWEEN '2024-03-01' AND '2024-03-31';