-- Active: 1747682997670@@localhost@5432@conservation_db

-- Creating Database  

CREATE DATABASE conservation_db;


-- Creating Tables and insert data into it

-- Rangers Table
CREATE TABLE rangers(
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    region VARCHAR(100)
);

INSERT INTO rangers (name, region) VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range');

SELECT * FROM rangers;

INSERT INTO rangers (name, region) VALUES
('Mike Rose', 'North River'),
('Josh Paul', 'South Forest');


-- Species Table
CREATE TABLE species(
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(100),
    scientific_name VARCHAR(200),
    discovery_date DATE,
    conservation_status VARCHAR(50)
);

INSERT INTO species (common_name,
scientific_name,
discovery_date,
conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

SELECT * FROM species;


-- sightings table
CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    species_id INTEGER REFERENCES species(species_id),
    ranger_id INTEGER REFERENCES rangers(ranger_id),
    location VARCHAR(150),
    sighting_time TIMESTAMP without time zone,
    notes VARCHAR(250)
);

ALTER table sightings 
    alter COLUMN notes SET DEFAULT NULL

INSERT INTO sightings (species_id,
ranger_id,
location,
sighting_time,
notes) VALUES
(1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 1, 'Peak Ridge', '2024-05-10 07:45:00', DEFAULT );

SELECT * from sightings


---------------------------------------------------------------------
---------------------------------------------------------------------

                        -- Problem Solutions
---------------------------------------------------------------------
---------------------------------------------------------------------


-- Registering a new data in ranger table
INSERT INTO rangers (name, region) VALUES
('Derek Fox', 'Coastal Plains');

SELECT * from rangers


-- count unique species ever sighted
SELECT COUNT(DISTINCT species_id) AS unique_species_count
    FROM sightings;


-- Find all sightings where the location includes "Pass"
SELECT * FROM sightings
    WHERE location ILIKE '%Pass%';


--  List each ranger's name and their total number of sightings.
SELECT 
    r.name,
    COUNT(s.sighting_id) AS total_sightings FROM rangers r
    LEFT JOIN sightings s ON r.ranger_id = s.ranger_id
        GROUP BY r.name
        ORDER BY r.name;


-- List species that have never been sighted.
SELECT s.common_name FROM species s
    LEFT JOIN sightings si ON s.species_id = si.species_id
        WHERE si.species_id IS NULL;


-- Show the most recent 2 sightings.
SELECT 
    sp.common_name,
    si.sighting_time,
    r.name
    FROM sightings si
JOIN species sp ON si.species_id = sp.species_id
JOIN rangers r ON si.ranger_id = r.ranger_id
    ORDER BY si.sighting_time DESC
    LIMIT 2;


-- Update all species discovered before year 1800 to have status 'Historic'.
UPDATE species
    SET conservation_status = 'Historic'
    WHERE discovery_date < '1800-01-01';


-- Label each sighting's time of day as 'Morning', 'Afternoon', or 'Evening'.
SELECT 
    sighting_id,
    CASE
        WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sighting_time) >= 12 AND EXTRACT(HOUR FROM sighting_time) < 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day
FROM sightings;


-- Delete rangers who have never sighted any species
DELETE FROM rangers
    WHERE ranger_id NOT IN (
        SELECT DISTINCT ranger_id FROM sightings
    );
