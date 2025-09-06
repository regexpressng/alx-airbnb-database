-- Write a query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause.

SELECT 
    u.id AS user_id,
    u.name AS user_name,
    COUNT(b.id) AS total_bookings
FROM Users u
LEFT JOIN Bookings b ON u.id = b.user_id
GROUP BY u.id, u.name;




-- Use a window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received.
SELECT 
    p.id AS property_id,
    p.name AS property_name,
    COUNT(b.id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.id) DESC) AS booking_rank
FROM Properties p
LEFT JOIN Bookings b ON p.id = b.property_id
GROUP BY p.id, p.name
ORDER BY booking_rank;