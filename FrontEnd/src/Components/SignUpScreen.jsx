import React, { useState, useEffect } from 'react';
import './style.css';

export const SignUp = () => {
  const [formData, setFormData] = useState({
    firstName: '',
    lastName: '',
    phoneNumber: '',
    email: '',
    password: '',
    confirmPassword: '',
    I_d: '',
    gender: '',
    dob: { month: '', day: '', year: '' },
  });

  const [errors, setErrors] = useState({});
  const [daysInMonth, setDaysInMonth] = useState([]);

  const lastYear = 2006;

  // Function to calculate the number of days in a month
  const getDaysInMonth = (month, year) => {
    const daysInMonth = {
      January: 31,
      February: year % 4 === 0 && (year % 100 !== 0 || year % 400 === 0) ? 29 : 28, // Leap year check for February
      March: 31,
      April: 30,
      May: 31,
      June: 30,
      July: 31,
      August: 31,
      September: 30,
      October: 31,
      November: 30,
      December: 31,
    };
    return daysInMonth[month] || 0;
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    if (name === 'month') {
      setFormData({ ...formData, dob: { ...formData.dob, month: value, day: '' } });
      const days = getDaysInMonth(value, formData.dob.year);
      setDaysInMonth([...Array(days).keys()].map(i => i + 1));
    } else if (name === 'year') {
      setFormData({ ...formData, dob: { ...formData.dob, year: value, day: '' } });
      if (formData.dob.month) {
        const days = getDaysInMonth(formData.dob.month, value);
        setDaysInMonth([...Array(days).keys()].map(i => i + 1));
      }
    } else if (name === 'day') {
      setFormData({ ...formData, dob: { ...formData.dob, day: value } });
    } else if (e.target.type === 'radio') {
      setFormData({ ...formData, gender: value });
    } else {
      setFormData({ ...formData, [name]: value });
    }
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    const validationErrors = {};
    if (!formData.firstName.trim()) validationErrors.firstName = 'First name is required.';
    if (!formData.lastName.trim()) validationErrors.lastName = 'Last name is required.';
    if (!formData.phoneNumber.trim()) {
      validationErrors.phoneNumber = 'Phone number is required.';
    } else if (!/^0(5|6|7)[0-9]{8}$/.test(formData.phoneNumber)) {
      validationErrors.phoneNumber = "Incorrect phone number.";
    }
    if (!formData.I_d.trim()) validationErrors.I_d = "Id is required";
    else if (formData.I_d.length !== 18) validationErrors.I_d = 'Invalid ID.';
    if (!formData.gender) validationErrors.gender = 'Gender is required.';
    if (!formData.password.trim()) validationErrors.password = 'Password is required.';
    else if (formData.password.length < 6) validationErrors.password = 'Password should be at least 6 characters.';
    if (!formData.confirmPassword.trim()) validationErrors.confirmPassword = 'Confirmation password is required.';
    else if (formData.confirmPassword !== formData.password) validationErrors.confirmPassword = 'Passwords do not match.';
    if (!formData.email.trim()) validationErrors.email = 'Email is required.';
    else if (!/^[a-zA-Z0-9._%+-]+@(gmail\.com|yahoo\.com|outlook\.com|hotmail\.com|icloud\.com|protonmail\.com|([a-zA-Z0-9._%+-]+\.)?edu\.dz|([a-zA-Z0-9._%+-]+\.)?gov\.dz|([a-zA-Z0-9._%+-]+\.)?djaweb\.dz|([a-zA-Z0-9._%+-]+\.)?algeriepost\.dz)$/.test(formData.email)) {
      validationErrors.email = 'Invalid email format.';
    }
    setErrors(validationErrors);
    if (Object.keys(validationErrors).length === 0) {
      alert('Form submitted successfully!');
    }
  };

  useEffect(() => {
    if (formData.dob.month && formData.dob.year) {
      const days = getDaysInMonth(formData.dob.month, formData.dob.year);
      setDaysInMonth([...Array(days).keys()].map(i => i + 1));
    }
  }, [formData.dob.month, formData.dob.year]);

  return (
    <div className="SignUpContainer">
      <div className="header ">
        <h1>Welcome to Mzya.DARI</h1>
        <p>Thank you for choosing to be part of the Mzya.DARI community! Please fill in your information to create your account and start your journey with us.</p>
      </div>

      <div className="row">
        {/* Left Hand Side */}
        <div className="col-md-6">
          <h3>Sign Up</h3>
          <div className="form-container">
            
            <form onSubmit={handleSubmit}>
              <label>
                <input
                  type="text"
                  name="firstName"
                  placeholder="First Name"
                  value={formData.firstName}
                  onChange={handleChange}
                  className="form-control mb-3"
                />
                {errors.firstName && <span className="ERRR">{errors.firstName}</span>}
              </label>
              <label>
                <input
                  type="text"
                  name="lastName"
                  placeholder="Last Name"
                  value={formData.lastName}
                  onChange={handleChange}
                  className="form-control mb-3"
                />
                {errors.lastName && <span className="ERRR">{errors.lastName}</span>}
              </label>

              <div className="genderClass">
  <h5>What is your gender?</h5>
  <div className="gender-options">
    <label>
    <span>Female</span>
      <input
        type="radio"
        name="gender"
        value="Female"
        onChange={handleChange}
      />
     
    </label>

    <label>
    <span>Male</span>
      <input
        type="radio"
        name="gender"
        value="Male"
        onChange={handleChange}
      />
     
    </label>
  </div>
  {errors.gender && <span className="ErGender">{errors.gender}</span>}
</div>

              <div className="dob-options mb-3">
                <h5>Date of Birth</h5>
                <select name="month" onChange={handleChange} value={formData.dob.month} className="form-control mb-2">
                  <option value="">Month</option>
                  <option value="January">January</option>
                  <option value="February">February</option>
                  <option value="March">March</option>
                  <option value="April">April</option>
                  <option value="May">May</option>
                  <option value="June">June</option>
                  <option value="July">July</option>
                  <option value="Auguest">Auguest</option>
                  <option value="September">September</option>
                  <option value="October">October</option>
                  <option value="November">November</option>
                  <option value="December">December</option>
                </select>
                <select name="day" onChange={handleChange} value={formData.dob.day} className="form-control mb-2">
                  <option value="">Day</option>
                  {daysInMonth.map(day => (
                    <option key={day} value={day}>{day}</option>
                  ))}
                </select>
                <select name="year" onChange={handleChange} value={formData.dob.year} className="form-control mb-3">
                  <option value="">Year</option>
                  {[...Array(57)].map((_, index) => (
                    <option key={lastYear - index} value={lastYear - index}>{lastYear - index}</option>
                  ))}
                </select>
              </div>

              <label>
                <input
                  type="email"
                  name="email"
                  placeholder="Email"
                  value={formData.email}
                  onChange={handleChange}
                  className="form-control mb-3"
                />
                {errors.email && <span className="ERRR">{errors.email}</span>}
              </label>

              <label>
                <input
                  type="tel"
                  name="phoneNumber"
                  placeholder="Phone Number"
                  value={formData.phoneNumber}
                  onChange={handleChange}
                  className="form-control mb-3"
                />
                {errors.phoneNumber && <span className="ERRR">{errors.phoneNumber}</span>}
              </label>

              <label>
                <input
                  type="password"
                  name="password"
                  placeholder="Password"
                  value={formData.password}
                  onChange={handleChange}
                  className="form-control mb-3"
                />
                {errors.password && <span className="ERRR">{errors.password}</span>}
              </label>

              <label>
                <input
                  type="password"
                  name="confirmPassword"
                  placeholder="Confirm Password"
                  value={formData.confirmPassword}
                  onChange={handleChange

}
                  className="form-control mb-3"
                />
                {errors.confirmPassword && <span className="ERRR">{errors.confirmPassword}</span>}
              </label>

              <label>
                <input
                  type="text"
                  name="I_d"
                  placeholder="ID Number"
                  value={formData.I_d}
                  onChange={handleChange}
                  className="form-control mb-3"
                />
                {errors.I_d && <span className="ERRR">{errors.I_d}</span>}
              </label>

              <button type="submit" className="btn btn-primary btn-block">Sign Up</button>
            </form>
           

          </div>
          <h6>I already have an account <a href="">Login</a></h6>

        </div>

        {/* Right Hand Side */}
        <div className="col-md-6">
          <img src="path_to_your_image.jpg" alt="Sign Up" className="img-fluid" />
        </div>
      </div>
    </div>
  );
};