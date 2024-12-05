const express = require('express');
const JobController = require('../controllers/jobController');
const validateJobInput = require('../middleware/validatJobInput');


const router = express.Router();

// Route to create a new job
router.post('/addjob', JobController.addJob);

module.exports = router;
