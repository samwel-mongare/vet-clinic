/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id integer,
    name varchar(100),
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg decimal,
    species varchar(255)
);

ALTER TABLE animals
 ADD species varchar(255);

 CREATE TABLE owners (
    id integer GENERATED ALWAYS AS IDENTITY,
    full_name varchar(100),
    age integer,
    PRIMARY KEY(id)
);

 CREATE TABLE species (
    id integer GENERATED ALWAYS AS IDENTITY,
    name varchar(100),
    PRIMARY KEY(id)
);

-- Modify animals table:

    -- Making id set as autoincremented PRIMARY KEY
   
    ALTER TABLE animals 
    DROP COLUMN id;

    ALTER TABLE animals 
    ADD COLUMN id integer GENERATED ALWAYS AS IDENTITY;

    ALTER TABLE animals 
    ADD PRIMARY KEY (id);

    -- Remove column species

    ALTER TABLE animals 
    DROP COLUMN species;

    -- Add column species_id which is a foreign key referencing species table

     ALTER TABLE animals 
    ADD COLUMN species_id integer;

    ALTER TABLE animals 
    ADD FOREIGN KEY (species_id) REFERENCES species;

    -- Add column owner_id which is a foreign key referencing the owners table
    ALTER TABLE animals 
    ADD COLUMN owner_id integer;

    ALTER TABLE animals 
    ADD FOREIGN KEY (owner_id) REFERENCES owners;
