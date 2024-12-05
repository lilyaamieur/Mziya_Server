const exports = require("express");
const router = express.Router();
const { addJob} = require("../controllers/jobController");

// route for adding a new job
router.post("/postJob", addJob);

module.exports = router;