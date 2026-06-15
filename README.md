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

## How to Run

Run the SQL file in PostgreSQL:

```bash
psql -U postgres -d your_database_name -f QUERY.sql
```

The file creates the tables, inserts the sample data, and runs all required queries.

## Assignment Notes

The ERD public link and viva/interview video link are submitted separately through the assignment submission portal.
