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

-- Previous queries 
SELECT a.name FROM animals a JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Melody Pond';
SELECT a.name FROM animals a JOIN species s ON a.species_id = s.id WHERE s.name = 'Pokemon';
SELECT o.full_name AS "Owner", a.name AS "Animal" FROM owners o LEFT JOIN animals a ON o.id = a.owner_id ORDER BY o.full_name;
SELECT s.name AS "Species", COUNT(a.id) AS "Number of Animals" FROM species s LEFT JOIN animals a ON s.id = a.species_id GROUP BY s.name ORDER BY COUNT(a.id) DESC;
SELECT a.name AS "Animal" FROM animals a JOIN owners o ON a.owner_id = o.id JOIN species s ON a.species_id = s.id WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';
SELECT a.name AS "Animal" FROM animals a JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0; 
SELECT o.full_name AS "Owner", COUNT(a.id) AS "Number of Animals" FROM owners o LEFT JOIN animals a ON o.id = a.owner_id GROUP BY o.full_name ORDER BY COUNT(a.id) DESC LIMIT 1;

-- New queries for final task
-- Who was the last animal seen by William Tatcher?
SELECT animals.name, MAX(visits.visit_date) FROM visits JOIN animals ON visits.animal_id = animals.id JOIN vets ON visits.vet_id = vets.id WHERE vets.name = 'William Tatcher' GROUP BY animals.name ORDER BY MAX(visits.visit_date) DESC LIMIT 1;
-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT animal_id) FROM visits JOIN vets ON visits.vet_id = vets.id WHERE vets.name = 'Stephanie Mendez';
-- List all vets and their specialties, including vets with no specialties
SELECT vets.name, species.name FROM vets LEFT JOIN specializations ON vets.id = specializations.vet_id LEFT JOIN species ON specializations.species_id = species.id ORDER BY vets.name;
-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020
SELECT DISTINCT animals.name FROM visits JOIN animals ON visits.animal_id = animals.id JOIN vets ON visits.vet_id = vets.id WHERE vets.name = 'Stephanie Mendez' AND visits.visit_date BETWEEN '2020-04-01' AND '2020-08-30' ORDER BY animals.name;
-- What animal has the most visits to vets?
SELECT animals.name, COUNT(*) FROM visits JOIN animals ON visits.animal_id = animals.id GROUP BY animals.name ORDER BY COUNT(*) DESC LIMIT 1;
-- Who was Maisy Smith's first visit?
SELECT animals.name, MIN(visits.visit_date) FROM visits JOIN animals ON visits.animal_id = animals.id JOIN vets ON visits.vet_id = vets.id WHERE vets.name = 'Maisy Smith' GROUP BY animals.name ORDER BY MIN(visits.visit_date) ASC LIMIT 1;
-- Details for most recent visit: animal information, vet information, and date of visit
SELECT animals.name AS animal_name, vets.name AS vet_name, MAX(visits.visit_date) FROM visits JOIN animals ON visits.animal_id = animals.id JOIN vets ON visits.vet_id = vets.id GROUP BY animals.name, vets.name ORDER BY MAX(visits.visit_date) DESC LIMIT 1;
-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) FROM visits LEFT JOIN specializations ON visits.vet_id = specializations.vet_id WHERE visits.animal_id NOT IN (SELECT animal_id FROM animals WHERE species_id = specializations.species_id);
-- What specialty should Maisy Smith consider getting? Look for the species she gets the most
SELECT species.name, COUNT(*) FROM visits JOIN animals ON visits.animal_id = animals.id JOIN species ON animals.species_id = species.id JOIN vets ON visits.vet_id = vets.id WHERE vets.name = 'Maisy Smith' GROUP BY species.name ORDER BY COUNT(*) DESC LIMIT 1;
