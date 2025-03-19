-- see all the roles in our psql server
SELECT *
FROM pg_roles;

-- 2 ways of creating a user

CREATE ROLE mihai WITH PASSWORD 'mihai1234' LOGIN CREATEDB CREATEROLE;

CREATE USER hasan WITH PASSWORD 'hasan123';

DROP ROLE mihai;

ALTER ROLE mihai WITH PASSWORD 'new1234';

CREATE ROLE java_devs CREATEDB CREATEROLE;

-- Add a user to a group
GRANT java_devs TO mihai;

-- Remove a user from a group
REVOKE java_devs FROM mihai;


-- See who is in what group
SELECT 
    grantee.rolname AS user_name, 
    granted.rolname AS group_name
FROM pg_roles AS grantee
JOIN pg_auth_members AS members ON grantee.oid = members.member
JOIN pg_roles AS granted ON members.roleid = granted.oid
ORDER BY group_name, user_name;


-- Who can edit a db
SELECT grantee, privilege_type, table_schema, table_name
FROM information_schema.role_table_grants
WHERE table_schema = 'public'
ORDER BY table_name, grantee;


-- Limit and Grant database connection and create read update and delete from table

GRANT USAGE ON SCHEMA PUBLIC TO java_devs;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO java_devs;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public to java_devs;

-- Granting all permissions to a user
GRANT ALL ON ALL TABLES IN SCHEMA public TO java_devs;

-- REVOKE all permissions for a user
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM java_devs;



-- See the owners of each DB
SELECT datname AS database_name, pg_catalog.pg_get_userbyid(datdba) AS OWNER
FROM pg_database;

ALTER DATABASE movies_db OWNER TO java_devs;

ALTER USER mihai WITH CONNECTION LIMIT -1;


DROP ROLE mihai;
DROP ROLE hasan;




