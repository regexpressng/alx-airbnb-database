-- Write a query using an INNER JOIN to retrieve all bookings and the respective users who made those bookings.
-- Write a query using aLEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.
-- Write a query using a FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.

SELECT Bookings.id, User.email FROM Bookings INNER JOIN Bookings On Bookings.user_id=User.id;

SELECT 
    Bookings.id, 
    User.email 
FROM 
    Bookings 
INNER JOIN 
    Bookings On Bookings.user_id=User.id;

SELECT 
    Properties.id AS property_id,
    Properties.name AS property_name,
    Reviews.id AS review_id,
    Reviews.comment AS review_comment,
    Reviews.rating AS review_rating
FROM Properties
LEFT JOIN Reviews ON Properties.id = Reviews.property_id
ORDER BY Properties.name, Reviews.rating;

SELECT 
    Users.id AS user_id,
    Users.email AS user_email,
    Bookings.id AS booking_id,
    Bookings.property_id,
    Bookings.booking_date
FROM Users
FULL OUTER JOIN Bookings ON Users.id = Bookings.user_id;
