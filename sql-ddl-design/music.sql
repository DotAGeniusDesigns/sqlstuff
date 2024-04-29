-- from the terminal run:
-- psql < music.sql

DROP DATABASE IF EXISTS music;

CREATE DATABASE music;

\c music

-- Creating tables for artists, albums, and producers
CREATE TABLE artists (
    artist_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE albums (
    album_id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    release_date DATE NOT NULL,
    artist_id INT REFERENCES artists(artist_id)  -- Assuming albums are primarily linked to a main artist
);

CREATE TABLE producers (
    producer_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

-- Redefining the songs table with normalization
CREATE TABLE songs (
    song_id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    duration TIME NOT NULL,
    album_id INT REFERENCES albums(album_id)
);

-- Many-to-many relationship tables
CREATE TABLE song_artists (
    song_id INT REFERENCES songs(song_id),
    artist_id INT REFERENCES artists(artist_id),
    PRIMARY KEY (song_id, artist_id)
);

CREATE TABLE song_producers (
    song_id INT REFERENCES songs(song_id),
    producer_id INT REFERENCES producers(producer_id),
    PRIMARY KEY (song_id, producer_id)
);

-- Sample inserts for artists and producers
INSERT INTO artists (name) VALUES ('Hanson'), ('Queen'), ('Mariah Carey');
INSERT INTO producers (name) VALUES ('Dust Brothers'), ('Stephen Lironi'), ('Roy Thomas Baker');

-- Sample inserts for albums, assuming artists have been inserted
INSERT INTO albums (title, release_date, artist_id) VALUES 
('Middle of Nowhere', '1997-04-15', 1), 
('A Night at the Opera', '1975-10-31', 2);

-- Updated inserts for songs, now referencing albums
INSERT INTO songs (title, duration, album_id) VALUES
('MMMBop', '00:03:58', 1),
('Bohemian Rhapsody', '00:05:55', 2);

-- Insert relations into song_artists and song_producers
INSERT INTO song_artists (song_id, artist_id) VALUES (1, 1), (2, 2);
INSERT INTO song_producers (song_id, producer_id) VALUES (1, 1), (2, 3);

