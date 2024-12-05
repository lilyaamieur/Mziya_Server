How to Run the Project
Clone or Pull the Code from GitHub:

Clone (if you don’t already have the project locally):
bash
Copier le code
git clone https://github.com/3Y-ENSIA-SoftwareEngineering/Mziya_Server.git
Pull Updates (if the project is already cloned):
bash
Copier le code
git pull origin back_end
Install Dependencies: Navigate to the project directory and run:

bash
Copier le code
npm install
Run in Development Mode: Start the server in development mode:

bash
Copier le code
npm run dev
Verify the Server: The server will run on http://localhost:3000.

Using Postman
Base URL:
http://localhost:3000/api/jobs
Endpoints:
Create a Job (POST):
URL: http://localhost:3000/api/jobs/postjob
Headers:
plaintext
Copier le code
Content-Type: application/json
Body (raw, JSON):
json
Copier le code
{
  "home_owner_id": 1,
  "description": "Fix the leaking pipe.",
  "location": "123 Main Street",
  "job_type": "small",
  "job_category": "plumbing",
  "budget": 200
}
Expected Response:
Success: 201 with job details.
Error: 400 if required fields are missing.