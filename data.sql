-- Previous INSERT statements
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (1, 'Agumon', '2020-02-03', 0, true, 10.23);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (2, 'Gabumon', '2018-11-15', 2, true, 8);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (3, 'Pikachu', '2021-01-07', 1, false, 15.04);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (4, 'Devimon', '2017-05-12', 5, true, 11);

-- Add new column species
ALTER TABLE animals ADD COLUMN species CHAR(40);

-- New INSERT statements
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species) VALUES ('Charmander', '2020-02-08', 0, false, -11, NULL);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species) VALUES ('Plantmon', '2021-11-15', 2, true, -5.7, NULL);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species) VALUES ('Squirtle', '1993-04-02', 3, false, -12.13, NULL);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species) VALUES ('Angemon', '2005-06-12', 1, true, -45, NULL);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species) VALUES ('Boarmon', '2005-06-07', 7, true, 20.4, NULL);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species) VALUES ('Blossom', '1998-10-13', 3, true, 17, NULL);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species) VALUES ('Ditto', '2022-05-14', 4, true, 22, NULL);
