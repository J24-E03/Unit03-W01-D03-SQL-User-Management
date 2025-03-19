-- 2. Create a New Group and User
-- Create a group
CREATE ROLE mygroup;

-- Create a user and assign them to the group
CREATE USER myuser WITH PASSWORD 'user1234';

GRANT mygroup TO myuser;

SELECT 
    grantee.rolname AS user_name, 
    granted.rolname AS group_name
FROM pg_roles AS grantee
JOIN pg_auth_members AS members ON grantee.oid = members.member
JOIN pg_roles AS granted ON members.roleid = granted.oid
ORDER BY group_name, user_name;

-- 3. Create a Database as the postgres User
CREATE DATABASE mydb;

--  5. Grant Permissions to the Group
GRANT CONNECT ON DATABASE mydb TO mygroup; 
GRANT USAGE ON SCHEMA public TO mygroup;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO mygroup;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO mygroup;

-- 7. Delete the Database as the User
DROP DATABASE mydb;


-- 8. Revoke Permissions and Remove User/Group
REVOKE ALL PRIVILEGES ON DATABASE mydb FROM mygroup;
REVOKE ALL PRIVILEGES ON SCHEMA public FROM mygroup;
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM mygroup;
REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public FROM mygroup;

REVOKE mygroup FROM myuser;

DROP USER myuser;

REVOKE ALL ON SCHEMA public FROM mygroup;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public REVOKE ALL ON TABLES FROM mygroup;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public REVOKE ALL ON SEQUENCES FROM mygroup;


REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM mygroup;
REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public FROM mygroup;
REVOKE ALL PRIVILEGES ON DATABASE mydb FROM mygroup;

DROP ROLE mygroup;

-- 9. Verify Deletion
SELECT rolname FROM pg_roles;

