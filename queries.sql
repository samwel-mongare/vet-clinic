/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon"
SELECT * from animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.

SELECT * from animals WHERE date_of_birth <  '2019-01-01' AND date_of_birth > '2016-01-01';

-- List the name of all animals that are neutered and have less than 3 escape attempts.

SELECT * from animals WHERE neutered=true AND escape_attempts < 3;

-- List date of birth of all animals named either "Agumon" or "Pikachu".

SELECT date_of_birth from animals WHERE name = 'Agumon' OR name='Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg

SELECT name, escape_attempts from animals WHERE weight_kg > 10.00;

-- Find all animals that are neutered.

SELECT * from animals WHERE neutered=true;

-- Find all animals not named Gabumon.

SELECT * from animals WHERE name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg

SELECT * from animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- TRANSACTIONS
-- FIRST TRANSACTION

BEGIN TRANSACTION;

-- update the animals table by setting the species column to unspecified

UPDATE animals
 SET species = 'unspecified';

--  roll back the change and verify that species columns went back to the state before transaction

ROLLBACK TRANSACTION;

-- SECOND TRANSACTION

-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.

UPDATE animals 
SET 
    species = 'digimon'
WHERE
    name LIKE '%mon';

-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.

UPDATE animals 
SET 
    species = 'pokemon'
WHERE
    species IS NULL;

    -- Inside a transaction delete all records in the animals table, then roll back the transaction.

    TRUNCATE TABLE animals;

    ROLLBACK TRANSACTION;