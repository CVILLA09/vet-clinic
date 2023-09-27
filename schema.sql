-- Create the vet_clinic database
CREATE DATABASE vet_clinic;

-- Create the animals table
CREATE TABLE animals (
  id SERIAL PRIMARY KEY, 
  name CHAR(40), 
  date_of_birth DATE, 
  escape_attempts INT, 
  neutered BOOLEAN, 
  weight_kg DECIMAL
);

-- Create the owners table
CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(50),
  age INT
);

-- Create the species table
CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50)
);

-- Modify the animals table to add foreign key references
ALTER TABLE animals ADD COLUMN species_id INT REFERENCES species(id);
ALTER TABLE animals ADD COLUMN owner_id INT REFERENCES owners(id);
