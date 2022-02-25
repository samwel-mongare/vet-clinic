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

 SELECT species from animals;

--  roll back the change and verify that species columns went back to the state before transaction

ROLLBACK TRANSACTION;

SELECT species from animals;

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

    COMMIT;

    SELECT species from animals;

    -- Inside a transaction delete all records in the animals table, then roll back the transaction.

    TRUNCATE TABLE animals;

    SELECT * from animals;

    ROLLBACK TRANSACTION;

    SELECT * from animals;

    -- Delete all animals born after Jan 1st, 2022.

    DELETE
        FROM
            animals
        WHERE
            date_of_birth > '2022-01-01';

    -- Update all animals' weight to be their weight multiplied by -1.

    UPDATE animals 
    SET 
        weight_kg = weight_kg * -1;

        -- queries to answer the following questions:

    -- How many animals are there?

    SELECT COUNT(name) FROM animals;

    -- How many animals have never tried to escape?

    SELECT
    COUNT(escape_attempts)
    FROM
    animals
    WHERE
    escape_attempts = 0;

    -- What is the average weight of animals?

    SELECT
    AVG(weight_kg)
    FROM
    animals;

    -- Who escapes the most, neutered or not neutered animals?

    SELECT
    neutered,
    SUM(escape_attempts) as mostEscapes,
    FROM
        animals
    GROUP BY neutered;

    -- What is the minimum and maximum weight of each type of animal?

    SELECT
    species,
    MIN(weight_kg) as MinWeight,
    MAX(weight_kg) as MaxWeight
    FROM
        animals
    GROUP BY species;

    -- What is the average number of escape attempts per animal type of those born between 1990 and 2000?

     SELECT
    species,
    AVG(escape_attempts)
    FROM
        animals
    WHERE
        date_of_birth <  '2000-01-01' AND date_of_birth > '1990-01-01'
    GROUP BY species;

    -- What animals belong to Melody Pond?
    SELECT  name as animal, full_name as owner
    FROM animals
    INNER JOIN owners
    ON owners.id = animals.owner_id
    WHERE full_name = 'Melody Pond';

    -- List of all animals that are pokemon (their type is Pokemon).
       SELECT  a.name as animal
    FROM animals a
    INNER JOIN species s
    ON s.id = a.species_id
    WHERE s.name = 'Pokemon';

    -- List all owners and their animals, remember to include those that don't own any animal.
     SELECT full_name as owner, name as animal
    FROM animals
    RIGHT JOIN owners
    ON owners.id = animals.owner_id;

    -- How many animals are there per species?
      SELECT  s.name as species, COUNT(a.name) as AnimalsperSpecies
    FROM animals a
    INNER JOIN species s
    ON s.id = a.species_id
    GROUP BY s.name;

    -- List all Digimon owned by Jennifer Orwell.
     SELECT  name as animal, full_name as owner
    FROM animals
    INNER JOIN owners
    ON owners.id = animals.owner_id
    WHERE full_name = 'Jennifer Orwell' AND animals.species_id=2;

    -- List all animals owned by Dean Winchester that haven't tried to escape.
    SELECT  name as animals
    FROM animals
    INNER JOIN owners
    ON owners.id = animals.owner_id
    WHERE full_name = 'Dean Winchester' AND animals.escape_attempts=0;

    -- Who owns the most animals?
     SELECT owners.full_name, COUNT(animals.name) AS total 
     FROM owners 
     LEFT JOIN animals ON 
     animals.owner_id=owners.id 
    GROUP BY owners.full_name 
    ORDER BY total DESC LIMIT 1;

    -- Who was the last animal seen by William Tatcher?
    SELECT a.name, date_of_visit 
    FROM vets v
    JOIN visits vv ON v.id = vv.vets_id
    JOIN animals a ON a.id = vv.animal_id 
    WHERE v.name ='William Tatcher' 
    ORDER BY vv.date_of_visit 
    DESC LIMIT 1;

    -- How many different animals did Stephanie Mendez see?
    SELECT COUNT(a.name) AS Animals_Seen
    FROM vets v
    JOIN visits vv ON v.id = vv.vets_id
    JOIN animals a ON a.id = vv.animal_id 
    WHERE v.name ='Stephanie Mendez';

    -- List all vets and their specialties, including vets with no specialties.
    SELECT v.name AS Vets, ss.name as specialties
    FROM vets v
    LEFT JOIN specializations s ON v.id = s.vet_id
    LEFT JOIN species ss ON ss.id = s.species_id; 

    -- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
     SELECT v.name, a.name, date_of_visit 
    FROM vets v
    JOIN visits vv ON v.id = vv.vets_id
    JOIN animals a ON a.id = vv.animal_id 
    WHERE v.name ='Stephanie Mendez' AND date_of_visit > '2020-04-01' AND date_of_visit < '2020-08-30'
    ORDER BY vv.date_of_visit;

    -- What animal has the most visits to vets?
    SELECT a.name, COUNT(date_of_visit) AS No_of_Visits
    FROM vets v
    JOIN visits vv ON v.id = vv.vets_id
    JOIN animals a ON a.id = vv.animal_id
    GROUP BY a.name 
    ORDER BY No_of_Visits
    DESC LIMIT 1;

    -- Who was Maisy Smith's first visit?
    SELECT a.name, date_of_visit 
    FROM vets v
    JOIN visits vv ON v.id = vv.vets_id
    JOIN animals a ON a.id = vv.animal_id 
    WHERE v.name ='Maisy Smith' 
    ORDER BY vv.date_of_visit 
    ASC LIMIT 1;

    -- Details for most recent visit: animal information, vet information, and date of visit.
    SELECT v.*, a.*, date_of_visit 
    FROM vets v
    JOIN visits vv ON v.id = vv.vets_id
    JOIN animals a ON a.id = vv.animal_id  
    ORDER BY vv.date_of_visit 
    DESC LIMIT 1;

    -- How many visits were with a vet that did not specialize in that animal's species?
    SELECT COUNT(*)
    FROM visits v
    JOIN animals a ON a.id = v.animal_id
    JOIN vets vv ON vv.id = v.vets_id
    JOIN specializations s ON s.vet_id = v.vets_id
    WHERE a.species_id != s.species_id;

    -- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
    SELECT ss.name, COUNT(vv.animal_id) as speciesId
    FROM animals a
    JOIN visits vv ON a.id = vv.animal_id
    JOIN vets v ON v.id = vv.vets_id 
    JOIN species ss ON ss.id = a.species_id 
    WHERE v.name ='Maisy Smith' 
    GROUP BY ss.name
    ORDER BY speciesId
    DESC LIMIT 1;

    -- Queries to be optimized

    SELECT COUNT(*) FROM visits where animal_id = 4;

    SELECT animal_id,vets_id, date_of_visit FROM visits where vets_id = 2 LIMIT 100;

    SELECT * FROM owners where email = 'owner_18327@mail.com';
