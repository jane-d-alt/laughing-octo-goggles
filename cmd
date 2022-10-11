codeally@645db364bad9:~/project$ psql --username=freecodecamp --dbname=periodic_table
psql (12.9 (Ubuntu 12.9-2.pgdg20.04+1))
Type "help" for help.

periodic_table=> \l
                                List of databases
      Name      |  Owner   | Encoding | Collate |  Ctype  |   Access privileges   
----------------+----------+----------+---------+---------+-----------------------
 periodic_table | postgres | UTF8     | C.UTF-8 | C.UTF-8 | 
 postgres       | postgres | UTF8     | C.UTF-8 | C.UTF-8 | 
 template0      | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
                |          |          |         |         | postgres=CTc/postgres
 template1      | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
                |          |          |         |         | postgres=CTc/postgres
(4 rows)

periodic_table=> \c periodic_table
You are now connected to database "periodic_table" as user "freecodecamp".
periodic_table=> \d
             List of relations
 Schema |    Name    | Type  |    Owner     
--------+------------+-------+--------------
 public | elements   | table | freecodecamp
 public | properties | table | freecodecamp
(2 rows)

periodic_table=> \d elements
                        Table "public.elements"
    Column     |         Type          | Collation | Nullable | Default 
---------------+-----------------------+-----------+----------+---------
 atomic_number | integer               |           | not null | 
 symbol        | character varying(2)  |           |          | 
 name          | character varying(40) |           |          | 
Indexes:
    "elements_pkey" PRIMARY KEY, btree (atomic_number)
    "elements_atomic_number_key" UNIQUE CONSTRAINT, btree (atomic_number)

periodic_table=> \d properties
                       Table "public.properties"
    Column     |         Type          | Collation | Nullable | Default 
---------------+-----------------------+-----------+----------+---------
 atomic_number | integer               |           | not null | 
 type          | character varying(30) |           |          | 
 weight        | numeric(9,6)          |           | not null | 
 melting_point | numeric               |           |          | 
 boiling_point | numeric               |           |          | 
Indexes:
    "properties_pkey" PRIMARY KEY, btree (atomic_number)
    "properties_atomic_number_key" UNIQUE CONSTRAINT, btree (atomic_number)

periodic_table=> ALTER TABLE properties RENAME COLUMN weight TO atomic_mass;
ALTER TABLE
periodic_table=> ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius;
ALTER TABLE
periodic_table=> ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius;
ALTER TABLE
periodic_table=> ALTER TABLE properties ALTER COLUMN melting_point NOT NULL;ERROR:  syntax error at or near "NOT"
LINE 1: ALTER TABLE properties ALTER COLUMN melting_point NOT NULL;
                                                          ^
periodic_table=> ALTER TABLE properties ALTER COLUMN melting_point SET NOT NULL;
ERROR:  column "melting_point" of relation "properties" does not exist
periodic_table=> ALTER TABLE properties ALTER COLUMN melting_point_celcius SET NOT NULL;
ERROR:  column "melting_point_celcius" of relation "properties" does not exist
periodic_table=> ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL;
ALTER TABLE
periodic_table=> ALTER TABLE properties ALTER COLUMN boiling_point_celsius SET NOT NULL;
ALTER TABLE
periodic_table=> ALTER TABLE elements ALTER COLUMN symbol SET UNIQUE;ERROR:  syntax error at or near "UNIQUE"
LINE 1: ALTER TABLE elements ALTER COLUMN symbol SET UNIQUE;
                                                     ^
periodic_table=> ALTER TABLE elements UNIQUE(symbol);
ERROR:  syntax error at or near "UNIQUE"
LINE 1: ALTER TABLE elements UNIQUE(symbol);
                             ^
periodic_table=> ALTER TABLE elements ADD CONSTRAINT unique_symbol UNIQUE(symbol);ALTER TABLE
periodic_table=> ALTER TABLE elements ADD CONSTRAINT unique_name UNIQUE(name);
ALTER TABLE
periodic_table=> ALTER TABLE elements ALTER COLUMN symbol NOT NULL;
ERROR:  syntax error at or near "NOT"
LINE 1: ALTER TABLE elements ALTER COLUMN symbol NOT NULL;
                                                 ^
periodic_table=> ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL;
ALTER TABLE
periodic_table=> ALTER TABLE elements ALTER COLUMN name SET NOT NULL;
ALTER TABLE
periodic_table=> ALTER TABLE properties ADD FOREIGN KEY(atomic_number) REFERENCES elements(atomic_number);
ALTER TABLE
periodic_table=> CREATE TABLE types;
ERROR:  syntax error at or near ";"
LINE 1: CREATE TABLE types;
                          ^
periodic_table=> CREATE TABLE types(type_id INT PRIMARY KEY, type VARCHAR NOT NULL OREIGN KEY REFERENCES properties(type));
ERROR:  syntax error at or near "FOREIGN"
LINE 1: ...es(type_id INT PRIMARY KEY, type VARCHAR NOT NULL FOREIGN KE...
                                                             ^
periodic_table=> CREATE TABLE types(type_id INT PRIMARY KEY, type VARCHAR NOT NULL FOREIGN KEY REFERENCES properties(type));
ERROR:  syntax error at or near "FOREIGN"
LINE 1: ...es(type_id INT PRIMARY KEY, type VARCHAR NOT NULL FOREIGN KE...
                                                             ^
periodic_table=> CREATE TABLE types(
periodic_table(> type_id INT PRIMARY KEY,
periodic_table(> type VARCHAR NOT NULL FOREIGN KEY(properties.type)
periodic_table(> );
ERROR:  syntax error at or near "FOREIGN"
LINE 3: type VARCHAR NOT NULL FOREIGN KEY(properties.type)
                              ^
periodic_table=> CREATE TABLE types(                                               type_id INT PRIMARY KEY,
type VARCHAR NOT NULL CONSTRAINT fk_type  FOREIGN KEY(properties.type)
);
ERROR:  syntax error at or near "FOREIGN"
LINE 3: type VARCHAR NOT NULL CONSTRAINT fk_type  FOREIGN KEY(proper...
                                                  ^
periodic_table=> CREATE TABLE types(
type_id INT PRIMARY KEY,
type VARCHAR NOT NULL CONSTRAINT fk_type FOREIGN KEY(properties.type)
);
ERROR:  syntax error at or near "FOREIGN"
LINE 3: type VARCHAR NOT NULL CONSTRAINT fk_type FOREIGN KEY(propert...
                                                 ^
periodic_table=> CREATE TABLE types(
type_id INT PRIMARY KEY,
type VARCHAR NOT NULL                                                
);
CREATE TABLE
periodic_table=> ALTER TABLE types ADD FOREIGN KEY(type) REFERENCES(properties.type);
ERROR:  syntax error at or near "("
LINE 1: ALTER TABLE types ADD FOREIGN KEY(type) REFERENCES(propertie...
                                                          ^
periodic_table=> ALTER TABLE types ADD FOREIGN KEY(type) REFERENCES properties(type);
ERROR:  there is no unique constraint matching given keys for referenced table "properties"
periodic_table=> ALTER TABLE types ADD FOREIGN KEYtype) REFERENC^CS ( e (lements(atomic_number);
periodic_table=> ALTER TABLE types ADD FOREIGN KEY ()
