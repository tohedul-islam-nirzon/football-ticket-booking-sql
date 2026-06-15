-- Football Ticket Booking System
-- PostgreSQL schema, sample data, and required assignment queries.

DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS matches;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id INTEGER PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    role VARCHAR(30) NOT NULL CHECK (role IN ('Ticket Manager', 'Football Fan')),
    phone_number VARCHAR(20)
);

CREATE TABLE matches (
    match_id INTEGER PRIMARY KEY,
    fixture VARCHAR(150) NOT NULL,
    tournament_category VARCHAR(80) NOT NULL,
    base_ticket_price INTEGER NOT NULL CHECK (base_ticket_price >= 0),
    match_status VARCHAR(30) NOT NULL CHECK (
        match_status IN ('Available', 'Selling Fast', 'Sold Out', 'Postponed')
    )
);

CREATE TABLE bookings (
    booking_id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(user_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    match_id INTEGER NOT NULL REFERENCES matches(match_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    seat_number VARCHAR(10),
    payment_status VARCHAR(20) CHECK (
        payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded')
    ),
    total_cost INTEGER NOT NULL CHECK (total_cost >= 0),
    UNIQUE (match_id, seat_number)
);

INSERT INTO users (user_id, full_name, email, role, phone_number) VALUES
(1, 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
(2, 'Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
(3, 'Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
(4, 'Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL);

INSERT INTO matches (match_id, fixture, tournament_category, base_ticket_price, match_status) VALUES
(101, 'Real Madrid vs Barcelona', 'Champions League', 150, 'Available'),
(102, 'Man City vs Liverpool', 'Premier League', 120, 'Selling Fast'),
(103, 'Bayern Munich vs PSG', 'Champions League', 130, 'Available'),
(104, 'AC Milan vs Inter Milan', 'Serie A', 90, 'Sold Out'),
(105, 'Juventus vs Roma', 'Serie A', 80, 'Available');

INSERT INTO bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost) VALUES
(501, 1, 101, 'A-12', 'Confirmed', 150),
(502, 1, 102, 'B-04', 'Confirmed', 120),
(503, 2, 101, 'A-13', 'Confirmed', 150),
(504, 2, 101, NULL, NULL, 150),
(505, 3, 102, 'C-20', 'Pending', 120);

-- Query 1:
-- Retrieve all upcoming football matches belonging to the 'Champions League'
-- where the match status is 'Available'.
SELECT
    match_id,
    fixture,
    base_ticket_price
FROM matches
WHERE tournament_category = 'Champions League'
  AND match_status = 'Available'
ORDER BY match_id;

-- Query 2:
-- Search for all users whose full names start with 'Tanvir' or contain
-- the phrase 'Haque' using case-insensitive pattern matching.
SELECT
    user_id,
    full_name,
    email
FROM users
WHERE LOWER(full_name) LIKE LOWER('Tanvir%')
   OR full_name ILIKE '%Haque%'
ORDER BY user_id;

-- Query 3:
-- Retrieve all booking records where payment status is missing, replacing
-- the NULL status with 'Action Required'.
SELECT
    booking_id,
    user_id,
    match_id,
    COALESCE(payment_status, 'Action Required') AS systematic_status
FROM bookings
WHERE payment_status IS NULL
ORDER BY booking_id;

-- Query 4:
-- Retrieve booking details with the user's full name and match fixture.
SELECT
    b.booking_id,
    u.full_name,
    m.fixture,
    b.total_cost
FROM bookings AS b
INNER JOIN users AS u
    ON b.user_id = u.user_id
INNER JOIN matches AS m
    ON b.match_id = m.match_id
ORDER BY b.booking_id;

-- Query 5:
-- Display all users and their booking IDs, including users without bookings.
SELECT
    u.user_id,
    u.full_name,
    b.booking_id
FROM users AS u
LEFT JOIN bookings AS b
    ON u.user_id = b.user_id
ORDER BY u.user_id, b.booking_id;

-- Query 6:
-- Find ticket bookings where total cost is higher than the average booking cost.
SELECT
    booking_id,
    match_id,
    total_cost
FROM bookings
WHERE total_cost > (
    SELECT AVG(total_cost)
    FROM bookings
)
ORDER BY booking_id;

-- Query 7:
-- Retrieve the top 2 most expensive matches after skipping the absolute highest.
SELECT
    match_id,
    fixture,
    base_ticket_price
FROM matches
ORDER BY base_ticket_price DESC
LIMIT 2 OFFSET 1;
