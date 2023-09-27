CREATE DATABASE vet_clinic;

CREATE TABLE animals (
  id INT, 
  name CHAR(40), 
  date_of_birth DATE, 
  escape_attempts INT, 
  neutered BOOLEAN, 
  weight_kg DECIMAL
);

-- Add new column species
ALTER TABLE animals ADD COLUMN species CHAR(40);
