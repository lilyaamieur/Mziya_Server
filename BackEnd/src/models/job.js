const { DataTypes } = require("sequelize");
const db = require("../condig/database");

// the define function is used to define the model that represents the database
// the model is mapped to to job table in postgreSQL database
// Job is the name of the model
const Job = db.define(
  "Job",
  {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    home_owner_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    description: {
      type: DataTypes.TEXT,
      allowNull: true,
    },
    location: {
      type: DataTypes.STRING(255),
      allowNull: true,
    },
    job_type: {
      type: DataTypes.ENUM("small", "large"),
      allowNull: false,
    },
    job_category: {
      type: DataTypes.ENUM("plumbing", "electrical", "carpentry", "other"),
      allowNull: false,
    },
    budget: {
      type: DataTypes.INTEGER,
      allowNull: true,
    },
    status: {
      type: DataTypes.ENUM("pending", "approved", "completed"),
      defaultValue: "pending",
    },
    created_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW,
    },
    updated_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW,
    },
  },
  {
    tableName: "jobs",
    timestamps: false, // If using manual timestamps
  }
);

module.exports = Job;

