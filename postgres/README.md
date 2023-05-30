# Postgres

```bash
psql -U postgres


\l
\c db
\dt show tables
\d show structures of tables
\di show index information of table
\d show databases
drop database dbname
\d table name
```

## Roles and privileges

```sql
-- create a user
create role liwei with login password 'ReservationMotivation';

-- This still works as of PostgreSQL 15. Same as above, 
-- but implicitly adds LOGIN
CREATE USER liwei WITH PASSWORD ‘ReservationMotivation’;

-- create a role
create role rustgrp;

-- Using flags, you will be prompted for a password as 
-- there is no specific “password” flag
psql -h localhost -U liwei -d postgres
 
-- Alternate using PostgreSQL connection URI
psql postgres://liwei:ReservationMotivation@localhost:5432/postgres
```

## Granting privileges to Roles

```sql
-- As a superuser or role that has the ability to grant 
-- this privilege to others
GRANT CREATE ON SCHEMA public TO devgrp;
 
GRANT SELECT, INSERT, UPDATE, DELETE 
            ON ALL TABLES IN SCHEMA public TO rustgrp;

-- And now, any role that we grant membership to will inherit these permissions by default.
grant rustgrp to liwei;


-- temporarily set role in the current session to a different 
--role. Only superusers or members of the role can do this.
SET ROLE rustgrp;
 
-- Create the table as rustgrp given the new permissions
CREATE TABLE user_social (
   user_id INT NOT NULL,
   twitter_handle TEXT NULL,
   facebook_handle TEXT NULL );
 
-- set the role back to the session initiated role
SET ROLE NONE;

-- This will create the role and automatically add it as 
-- a member of the devgrp role
CREATE ROLE dev2 WITH LOGIN PASSWORD ‘supersecretpw2’ 
                                            IN ROLE rustgrp;
```

## grant all privileges on database

```sql
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO new_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO your_user;
```

## search path

```sql
show search_path;
set serach_path="$user", public, sport, art;
```

if search the sample table will return first table.
