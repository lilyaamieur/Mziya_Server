const Job = require("../models/Job");

// function to handle the post job form submotion
// it is responsible for inserting data into the database
exports.addJob = async (req, res) => {
  try {
    // extract the data from the request
    // !! this needs to be updated when the DB table is updated
    const {
      home_owner_id,
      description,
      location,
      job_type,
      job_category,
      budget,
    } = req.body;

    // validate the required fields
    // !! check what fields are actually required and update this
    if (
      !home_owner_id ||
      !description ||
      !location ||
      !job_type ||
      !job_category ||
      !budget
    ) {
      return res
        .status(400)
        .json({ message: "Please fill in all the required fields" });
    }

    // insert job post in the database
    // !! shis should be updated when the DB table is updated
    const newJob = await Job.create({
      home_owner_id,
      description,
      location,
      job_type,
      job_category,
      budget,
    });

    return res.status(200).json({message: "New job created successfully", job: newJob});

  } catch (error) {
    console.error("Failed to add job", error.message);
    res.status(500).json({ error: "Internal server error" });
  }
};
