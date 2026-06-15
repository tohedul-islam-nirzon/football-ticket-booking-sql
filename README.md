# Football Ticket Booking System

This repository contains the SQL solution for the Football Ticket Booking System database assignment.

## Files

- `QUERY.sql` - PostgreSQL schema, sample data, and the 7 required SQL queries.

## Database Tables

The system uses three tables:

- `users`
- `matches`
- `bookings`

The `bookings` table connects users with matches through foreign keys.

## Queries Covered

The SQL file includes queries for:

- Filtering matches by tournament and status
- Case-insensitive user search with `LIKE` and `ILIKE`
- Handling `NULL` payment status with `COALESCE`
- Joining bookings with users and matches
- Listing users with or without bookings using `LEFT JOIN`
- Comparing ticket costs with an aggregate subquery
- Sorting and paginating match records with `LIMIT` and `OFFSET`

## How to Run

Run the SQL file in PostgreSQL:

```bash
psql -U postgres -d your_database_name -f QUERY.sql
```

The file creates the tables, inserts the sample data, and runs all required queries.

## Verification

The SQL script was tested with PostgreSQL 16 and produced the expected sample outputs for all seven queries.

## Assignment Notes

The ERD public link and viva/interview video link are submitted separately through the assignment submission portal.
