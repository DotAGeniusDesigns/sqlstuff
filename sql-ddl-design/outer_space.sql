-- from the terminal run:
-- psql < outer_space.sql

DROP DATABASE IF EXISTS outer_space;

CREATE DATABASE outer_space;

\c outer_space

CREATE TABLE galaxies (
  galaxy_id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE
);

CREATE TABLE stars (
  star_id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  galaxy_id INT REFERENCES galaxies(galaxy_id)
);

CREATE TABLE planets
(
  planet_id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  orbital_period_in_years DECIMAL(10, 2) NOT NULL CHECK (orbital_period_in_years > 0),
  star_id INT REFERENCES stars(star_id)
);

CREATE TABLE moons (
  moon_id SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  planet_id INT REFERENCES planets(planet_id)
);

INSERT INTO galaxies (name) VALUES ('Milky Way');

INSERT INTO stars (name, galaxy_id) VALUES ('Sun', 1), ('Proxima Centauri', 1), ('Gliese 876', 1);

INSERT INTO planets (name, orbital_period_in_years, star_id) VALUES ('Earth', 1.00, 1), ('Mars', 1.88, 1), ('Proxima Centauri b', 0.03, 2), ('Gliese 876 b', 0.23, 3);

INSERT INTO moons (name, planet_id) VALUES ('Moon', 1);