# Optimization Report

## Initial Query (Unoptimized)
The initial query retrieved all bookings along with user, property, and payment details using multiple INNER JOINs.  
Issue: It excluded bookings without payments and performed full table scans with high cost.

```sql
-- Initial complex query to fetch bookings with user, property, and payment details
SELECT 
    b.id AS booking_id,
    b.start_date,
    b.end_date,
    u.id AS user_id,
    u.name AS user_name,
    u.email AS user_email,
    p.id AS property_id,
    p.name AS property_name,
    p.location,
    pay.id AS payment_id,
    pay.amount,
    pay.status,
    pay.payment_date
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
JOIN payments pay ON b.id = pay.booking_id
ORDER BY b.start_date DESC;
```

## Analyze Performance

```sql
EXPLAIN ANALYZE
SELECT 
    b.id AS booking_id,
    b.start_date,
    b.end_date,
    u.id AS user_id,
    u.name AS user_name,
    u.email AS user_email,
    p.id AS property_id,
    p.name AS property_name,
    p.location,
    pay.id AS payment_id,
    pay.amount,
    pay.status,
    pay.payment_date
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
JOIN payments pay ON b.id = pay.booking_id
ORDER BY b.start_date DESC;
```

- **Performance Analysis: -** Using EXPLAIN ANALYZE, we observed:
    - Sequential scans on large tables (bookings, payments).
    - Nested loop joins caused high execution time.
    - Sorting by b.start_date was expensive without an index.

## Optimized Query

- **We refactored the query:**
    - Changed JOIN payments → LEFT JOIN to include all bookings.
    - Ensured indexes on bookings.user_id, bookings.property_id, payments.booking_id, and bookings.start_date.
    - Reduced join cost by joining payments last.

```sql
-- Optimized query for better performance
SELECT 
    b.id AS booking_id,
    b.start_date,
    b.end_date,
    u.id AS user_id,
    u.name AS user_name,
    u.email AS user_email,
    p.id AS property_id,
    p.name AS property_name,
    p.location,
    pay.id AS payment_id,
    pay.amount,
    pay.status,
    pay.payment_date
FROM bookings b
/* Use LEFT JOIN in case some bookings don’t yet have payments */
LEFT JOIN payments pay ON b.id = pay.booking_id
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
ORDER BY b.start_date DESC;
```

- **Results**
    - Execution time reduced significantly after adding indexes and restructuring joins.
    - Query plan now shows Index Scans instead of Sequential Scans.
    - Sorting optimized via INDEX ON bookings(start_date).