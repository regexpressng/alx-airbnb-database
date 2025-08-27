# AirBnB Database Schema Documentation

This document provides a comprehensive overview of the AirBnB database schema, including entities, attributes, relationships, normalization, constraints, and indexing. It is prepared for GitHub documentation and can be used as a reference for development and maintenance.

---

## Table of Contents
1. [Entities and Attributes](#entities-and-attributes)
2. [Normalization Steps](#normalization-steps)
3. [Constraints and Indexing](#constraints-and-indexing)
4. [Relationships](#relationships)
5. [Summary](#summary)

---

## Entities and Attributes

### User
| Column | Type | Constraints |
|--------|------|-------------|
| user_id | UUID | Primary Key, Indexed |
| first_name | VARCHAR | NOT NULL |
| last_name | VARCHAR | NOT NULL |
| email | VARCHAR | UNIQUE, NOT NULL |
| password_hash | VARCHAR | NOT NULL |
| phone_number | VARCHAR | NULL |
| role | ENUM(guest, host, admin) | NOT NULL |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

### Property
| Column | Type | Constraints |
|--------|------|-------------|
| property_id | UUID | Primary Key, Indexed |
| host_id | UUID | Foreign Key → User(user_id) |
| name | VARCHAR | NOT NULL |
| description | TEXT | NOT NULL |
| location | VARCHAR | NOT NULL |
| pricepernight | DECIMAL | NOT NULL |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | ON UPDATE CURRENT_TIMESTAMP |

### Booking
| Column | Type | Constraints |
|--------|------|-------------|
| booking_id | UUID | Primary Key, Indexed |
| property_id | UUID | Foreign Key → Property(property_id) |
| user_id | UUID | Foreign Key → User(user_id) |
| start_date | DATE | NOT NULL |
| end_date | DATE | NOT NULL |
| total_price | DECIMAL | NOT NULL |
| status | ENUM(pending, confirmed, canceled) | NOT NULL |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

### Payment
| Column | Type | Constraints |
|--------|------|-------------|
| payment_id | UUID | Primary Key, Indexed |
| booking_id | UUID | Foreign Key → Booking(booking_id) |
| amount | DECIMAL | NOT NULL |
| payment_date | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| payment_method | ENUM(credit_card, paypal, stripe) | NOT NULL |

### Review
| Column | Type | Constraints |
|--------|------|-------------|
| review_id | UUID | Primary Key, Indexed |
| property_id | UUID | Foreign Key → Property(property_id) |
| user_id | UUID | Foreign Key → User(user_id) |
| rating | INTEGER | CHECK rating >= 1 AND rating <= 5, NOT NULL |
| comment | TEXT | NOT NULL |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

### Message
| Column | Type | Constraints |
|--------|------|-------------|
| message_id | UUID | Primary Key, Indexed |
| sender_id | UUID | Foreign Key → User(user_id) |
| recipient_id | UUID | Foreign Key → User(user_id) |
| message_body | TEXT | NOT NULL |
| sent_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

---

## Normalization Steps

### 1. First Normal Form (1NF)
- All columns have atomic values.
- No repeating groups or arrays.
- **Result:** Schema is in 1NF.

### 2. Second Normal Form (2NF)
- Schema is in 1NF.
- No partial dependencies; all columns depend on the full primary key.
- **Result:** Schema is in 2NF.

### 3. Third Normal Form (3NF)
- Schema is in 2NF.
- No transitive dependencies (non-key columns do not depend on other non-key columns).
- Optional: `total_price` in Booking can be derived at runtime to strictly satisfy 3NF.
- **Result:** Schema is in 3NF.

---

## Constraints and Indexing
- **Primary Keys:** Automatically indexed.
- **Additional Indexes:**
  - `email` in User
  - `property_id` in Property and Booking
  - `booking_id` in Booking and Payment
- **Constraints:**
  - Unique constraint on User.email
  - Foreign key constraints on host_id, property_id, user_id, booking_id, sender_id, recipient_id
  - ENUM constraints on role, booking status, payment_method
  - Rating check constraint (1-5)

---

## Relationships
- **User ↔ Property:** One-to-many (host can have multiple properties).
- **User ↔ Booking:** One-to-many (user can have multiple bookings).
- **Property ↔ Booking:** One-to-many (property can have multiple bookings).
- **Booking ↔ Payment:** One-to-one or one-to-many (booking can have one or multiple payments depending on business logic).
- **User ↔ Review:** One-to-many (user can leave multiple reviews).
- **Property ↔ Review:** One-to-many (property can have multiple reviews).
- **User ↔ Message:** One-to-many (sender and recipient relationships for messages).

---

## Summary
This AirBnB database schema has been fully normalized to 3NF, ensuring data integrity, minimizing redundancy, and optimizing query performance. All tables include proper primary keys, foreign keys, constraints, enums, timestamps, and indexes, making the schema ready for production use.

---


