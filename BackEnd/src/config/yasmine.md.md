# PostgreSQL and Supabase Database Setup Guide

This comprehensive guide will walk you through installing PostgreSQL, configuring your environment, accessing your Supabase-hosted database via the command line, and testing it through Postman.

## Table of Contents
1. [Installing PostgreSQL](#1-installing-postgresql)
2. [Setting Up Environment Variables](#2-setting-up-environment-variables)
3. [Accessing Supabase Database via Command Line](#3-accessing-supabase-database-via-command-line)
4. [Testing the Database with Postman](#4-testing-the-database-with-postman)
5. [Debugging Common Issues](#5-debugging-common-issues)

## 1. Installing PostgreSQL

### Step 1: Download PostgreSQL
- Visit the official PostgreSQL download page
- Select the installer appropriate for your operating system (Windows, macOS, or Linux)

### Step 2: Install PostgreSQL
Run the installer and follow these steps:
- Choose the installation directory
- Set a password for the postgres user (remember this for later)
- Leave other options as default
- Install pgAdmin (optional but recommended for GUI-based database management)

### Step 3: Verify Installation
Open your terminal or command prompt and follow these steps:
- Navigate to the PostgreSQL binary directory. For example:
  ```sh
  cd "C:\Program Files\PostgreSQL\12\bin"
  ```
- Run the PostgreSQL CLI:
  ```sh
  .\psql -U postgres
  ```
- Enter the password you set during installation
- You should see the PostgreSQL CLI interface

## 2. Setting Up Environment Variables

### Step 1: Add PostgreSQL Binary Path to PATH
- Open the Start menu and search for "Environment Variables"
- Under "System Properties," click the Environment Variables button
- In the "System Variables" section:
  - Select the Path variable and click Edit
  - Add the PostgreSQL bin directory (e.g., `C:\Program Files\PostgreSQL\12\bin`)

### Step 2: Verify the Configuration
- Open a new terminal or command prompt
- Run the following command:
  ```sh
  psql -U postgres
  ```
- If it prompts for a password and logs you in, the environment variable is correctly set

## 3. Accessing Supabase Database via Command Line

### Step 1: Supabase Database Credentials
- **Host:** `aws-0-eu-west-3.pooler.supabase.com`
- **Port:** 5432
- **Database Name:** postgres
- **User:** `postgres.yuujovwhtqsufnwcoizj`
- **Password:** (Retrieve this from the Supabase dashboard or project owner)

### Step 2: Connect to the Database
Run the following command:
```sh
psql -h aws-0-eu-west-3.pooler.supabase.com -U postgres.yuujovwhtqsufnwcoizj -d postgres -p 5432
```
- Enter the password when prompted

### Step 3: Verify the Connection
- Once connected, you should see the PostgreSQL prompt: `postgres=#`
- List all tables to confirm connection:
  ```sql
  \dt
  ```

## 4. Testing the Database with Postman

### Step 1: Retrieve the Supabase API Key
- Go to the Supabase dashboard
- Navigate to Settings > API
- Copy the anon key under "Project API Keys"

### Step 2: Determine the Endpoint
The base URL for your Supabase API is:
```
https://<project-ref>.supabase.co/rest/v1
```
Replace `<project-ref>` with your Supabase project reference

Example users table endpoint:
```
https://<project-ref>.supabase.co/rest/v1/users
```

### Step 3: Set Up Postman
1. Open Postman and create a new POST request
2. Set the URL to your table endpoint
3. Add the required Headers:
   - `apikey`: Your anon key
   - `Authorization`: Bearer `<anon-key>`
   - `Content-Type`: application/json
4. Add the Body (raw JSON):
   ```json
   {
     "name": "John Doe",
     "email": "john.doe@example.com",
     "password": "securepassword",
     "phone": "123456789",
     "address": "123 Main St",
     "profile_picture": "profile.jpg",
     "national_id": "123456789",
     "verified": true
   }
   ```
5. Send the request - you should get a 201 Created response

## 5. Debugging Common Issues

### 401 Unauthorized
- Ensure the apikey and Authorization headers are correctly set
- Confirm that the Supabase table has the correct permissions for the anon role

### 404 Not Found
- Check if the table exists and is spelled correctly
- Verify the endpoint URL in the Supabase dashboard

### psql Command Not Found
- Confirm that PostgreSQL is installed
- Verify that the bin directory is added to your PATH environment variable

### SSL Error in psql
Add the sslmode parameter to your connection command:
```sh
psql "host=aws-0-eu-west-3.pooler.supabase.com port=5432 dbname=postgres user=postgres.yuujovwhtqsufnwcoizj password=<your-password> sslmode=require"
```

## Additional Resources
- [PostgreSQL Official Documentation](https://www.postgresql.org/docs/)
- [Supabase Documentation](https://supabase.com/docs)
- [Postman Documentation](https://learning.postman.com/docs/getting-started/introduction/)

**By following this guide, you can successfully install PostgreSQL, connect to your Supabase database, and test it with Postman. Let me know if you encounter any specific issues!**
