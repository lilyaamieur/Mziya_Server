const JobService = require('../services/jobService'); // Service layer for Job operations

class JobController {
  // Add Job Controller
  static async addJob(req, res) {
    try {
      const {
        home_owner_id,
        description,
        location,
        job_type,
        job_category,
        budget,
      } = req.body;
 
      // Ensure all required fields are present
      if (
        !home_owner_id ||
        !description ||
        !location ||
        !job_type ||
        !job_category ||
        !budget
      ) {
        return res.status(400).json({
          message: 'Please fill in all the required fields',
        });
      }

      // Call the JobService to create a new job
      const newJob = await JobService.create({
        home_owner_id,
        description,
        location,
        job_type,
        job_category,
        budget,
      });

      return res.status(201).json({
        message: 'New job created successfully',
        job: newJob,
      });
    } catch (error) {
      console.error('Failed to add job:', error.message);
      res.status(500).json({ message: 'Internal server error' });
    }
  }

  // Additional methods for handling other job-related tasks can go here
}

module.exports = JobController;
