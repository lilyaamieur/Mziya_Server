// Middleware to validate job creation input
const validateJobInput = (req, res, next) => {
    const {
      home_owner_id,
      description,
      location,
      job_type,
      job_category,
      budget,
    } = req.body;
  
    // Validate required fields
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
  
    next(); // Proceed to the controller
  };
  
  module.exports = validateJobInput;
  