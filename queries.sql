-- Existing queries
SELECT * FROM animals WHERE name LIKE '%mon%';
SELECT (name) FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-12-31';
SELECT (name) FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT (date_of_birth) FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT (name, escape_attempts) FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name NOT IN ('Gabumon');
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- New transactional queries

-- Step 1: Update species to 'unspecified' and then rollback
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;

-- Step 2: Update species based on animal names and commit
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon%';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;

-- Step 3: Delete all records and then rollback
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;

-- Step 4: Multiple operations with Savepoint
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT sp1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO sp1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

-- Previous queries
SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, AVG(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

-- New queries for final task
-- What animals belong to Melody Pond?
SELECT a.name FROM animals a JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Melody Pond';
-- List of all animals that are Pokemon
SELECT a.name FROM animals a JOIN species s ON a.species_id = s.id WHERE s.name = 'Pokemon';
-- List all owners and their animals, if they have any
SELECT o.full_name AS "Owner", a.name AS "Animal" FROM owners o LEFT JOIN animals a ON o.id = a.owner_id ORDER BY o.full_name;
-- Count the number of animals per species
SELECT s.name AS "Species", COUNT(a.id) AS "Number of Animals" FROM species s LEFT JOIN animals a ON s.id = a.species_id GROUP BY s.name ORDER BY COUNT(a.id) DESC;
-- List all Digimon owned by Jennifer Orwell
SELECT a.name AS "Animal" FROM animals a JOIN owners o ON a.owner_id = o.id JOIN species s ON a.species_id = s.id WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';
-- List all animals owned by Dean Winchester that haven't tried to escape
SELECT a.name AS "Animal" FROM animals a JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0; 
-- Who owns the most animals?
SELECT o.full_name AS "Owner", COUNT(a.id) AS "Number of Animals" FROM owners o LEFT JOIN animals a ON o.id = a.owner_id GROUP BY o.full_name ORDER BY COUNT(a.id) DESC LIMIT 1;
