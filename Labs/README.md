# PostgreSQL User and Group Management Lab

## Objective
In this lab, students will:
- Establish a connection to PostgreSQL as the `postgres` superuser in **pgAdmin**.
- Create a new user and a group.
- Assign the user to the group.
- Create a database as the `postgres` user.
- Attempt to connect as the newly created user and observe the access error.
- Grant necessary permissions to the group.
- Verify the granted permissions.
- Delete the database as the user.
- Revoke permissions from the group.
- Delete the user and the group.

---

## **Steps**

### **1. Connect to PostgreSQL as the `postgres` User**
- Open **pgAdmin**.
- Connect to the PostgreSQL server as `postgres`.

### **2. Create a New Group and User**
#### **Create a group**
- Navigate to `Login/Group Roles` in the **pgAdmin Object Explorer**.
- Create a new role named `mygroup`.

#### **Create a user and assign them to the group**
- Create a new user named `myuser` with a password.
- Add `myuser` to `mygroup`.
- Verify the user-group assignment.

### **3. Create a Database as the `postgres` User**
- Navigate to `Databases` in **pgAdmin**.
- Create a new database named `mydb`.
- Verify that the database appears in the list.

### **4. Attempt to Connect as the New User**
- Log out of `postgres` in **pgAdmin**.
- Try connecting as `myuser` to `mydb`.
- Observe the error message when attempting to access the database.

### **5. Grant Permissions to the Group**
- Log back in as `postgres`.
- Grant the following permissions to `mygroup`:
  - `CONNECT` on the database
  - `USAGE` on schema `public`
  - `SELECT, INSERT, UPDATE, DELETE` on all tables in `public`
- Set default privileges for future objects.

### **6. Verify the Granted Permissions**
- Reconnect as `myuser` in **pgAdmin**.
- Check if `myuser` can now see the database and perform operations.

### **7. Delete the Database as the User**
- Try deleting `mydb` as `myuser`.
- Observe the error message.
- Reconnect as `postgres` and delete the database.

### **8. Revoke Permissions and Remove User/Group**
- Revoke all privileges from `mygroup`.
- Remove `myuser` from `mygroup`.
- Delete `myuser` and `mygroup`.

### **9. Verify Deletion**
- Check the list of users and groups to ensure removal.
