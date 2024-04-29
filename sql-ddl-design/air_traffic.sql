-- from the terminal run:
-- psql < air_traffic.sql

DROP DATABASE IF EXISTS air_traffic;

CREATE DATABASE air_traffic;

\c air_traffic

-- Creating tables for airports and airlines
CREATE TABLE airlines (
    airline_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE airports (
    airport_id SERIAL PRIMARY KEY,
    city TEXT NOT NULL,
    country TEXT NOT NULL,
    code TEXT NOT NULL UNIQUE -- IATA airport code
);

-- Redefining the tickets table with normalization
CREATE TABLE tickets (
    ticket_id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    seat TEXT NOT NULL,
    departure TIMESTAMPTZ NOT NULL,
    arrival TIMESTAMPTZ NOT NULL,
    airline_id INT REFERENCES airlines(airline_id),
    from_airport_id INT REFERENCES airports(airport_id),
    to_airport_id INT REFERENCES airports(airport_id),
    flight_number TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'On-time' CHECK (status IN ('On-time', 'Delayed', 'Cancelled'))
);

-- Sample inserts for airlines
INSERT INTO airlines (name) VALUES ('United'), ('British Airways'), ('Delta'), ('TUI Fly Belgium'), ('Air China'), ('American Airlines'), ('Avianca Brasil');

-- Sample inserts for airports
INSERT INTO airports (city, country, code) VALUES
('Washington DC', 'United States', 'IAD'),
('Seattle', 'United States', 'SEA'),
('Tokyo', 'Japan', 'HND'),
('London', 'United Kingdom', 'LHR'),
-- Add more as necessary

-- Updated inserts for tickets, now referencing airlines and airports
INSERT INTO tickets (first_name, last_name, seat, departure, arrival, airline_id, from_airport_id, to_airport_id, flight_number, status) VALUES
('Jennifer', 'Finch', '33B', '2018-04-08 09:00:00+00', '2018-04-08 12:00:00+00', 1, 1, 2, 'UA100', 'On-time'),
-- Add more detailed inserts as necessary
