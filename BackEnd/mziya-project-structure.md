# Mziya Project Structure

## Project Overview
A full-stack web application for job posting and tracking, built with React.js (frontend), Node.js (backend), and PostgreSQL (database), focusing on professional services marketplace.

## Root Directory Structure
```
Mziya/
│
├── backend/                  # Node.js Backend
│   ├── src/
│   │   ├── config/           # Configuration files
│   │   │   ├── database.js   # Database connection configuration
│   │   │   ├── environment.js# Environment variables management
│   │   │   └── logger.js     # Logging configuration
│   │   │
│   │   ├── controllers/      # Business logic and request handling
│   │   │   ├── authController.js
│   │   │   ├── jobController.js
│   │   │   ├── profileController.js
│   │   │   └── reviewController.js
│   │   │
│   │   ├── models/           # Data models and database schemas
│   │   │   ├── User.js
│   │   │   ├── Job.js
│   │   │   ├── Review.js
│   │   │   └── Notification.js
│   │   │
│   │   ├── routes/           # API route definitions
│   │   │   ├── authRoutes.js
│   │   │   ├── jobRoutes.js
│   │   │   ├── profileRoutes.js
│   │   │   └── reviewRoutes.js
│   │   │
│   │   ├── middlewares/      # Express middlewares
│   │   │   ├── authMiddleware.js
│   │   │   ├── validationMiddleware.js
│   │   │   └── errorHandler.js
│   │   │
│   │   ├── services/         # Business logic services
│   │   │   ├── authService.js
│   │   │   ├── jobService.js
│   │   │   ├── notificationService.js
│   │   │   └── reviewService.js
│   │   │
│   │   ├── utils/            # Utility functions
│   │   │   ├── validation.js
│   │   │   ├── jwt.js
│   │   │   └── emailHelper.js
│   │   │
│   │   ├── database/         # Database-related scripts
│   │   │   ├── migrations/
│   │   │   └── seeders/
│   │   │
│   │   └── app.js            # Express application setup
│   │
│   ├── tests/                # Backend test suite
│   │   ├── unit/
│   │   ├── integration/
│   │   └── e2e/
│   │
│   ├── .env                  # Environment variables
│   ├── package.json
│   └── README.md
│
├── frontend/                 # React.js Frontend
│   ├── src/
│   │   ├── components/       # Reusable React components
│   │   │   ├── common/       # Shared components
│   │   │   │   ├── Button.js
│   │   │   │   ├── Input.js
│   │   │   │   └── Modal.js
│   │   │   │
│   │   │   ├── layout/       # Layout components
│   │   │   │   ├── Header.js
│   │   │   │   ├── Footer.js
│   │   │   │   └── Sidebar.js
│   │   │   │
│   │   │   └── pages/        # Page-specific components
│   │   │       ├── LandingPage/
│   │   │       ├── AuthPages/
│   │   │       ├── HomePage/
│   │   │       ├── JobPostPage/
│   │   │       ├── JobsPage/
│   │   │       └── ProfilePage/
│   │   │
│   │   ├── context/          # React context providers
│   │   │   ├── AuthContext.js
│   │   │   ├── JobContext.js
│   │   │   └── NotificationContext.js
│   │   │
│   │   ├── hooks/            # Custom React hooks
│   │   │   ├── useAuth.js
│   │   │   ├── useJob.js
│   │   │   └── useNotification.js
│   │   │
│   │   ├── services/         # API interaction services
│   │   │   ├── authService.js
│   │   │   ├── jobService.js
│   │   │   └── profileService.js
│   │   │
│   │   ├── utils/            # Frontend utilities
│   │   │   ├── validation.js
│   │   │   ├── formatters.js
│   │   │   └── constants.js
│   │   │
│   │   ├── styles/           # CSS and styling
│   │   │   ├── global.css
│   │   │   └── tailwind.css
│   │   │
│   │   ├── routes/           # React Router configuration
│   │   │   └── AppRoutes.js
│   │   │
│   │   ├── App.js
│   │   └── index.js
│   │
│   ├── tests/                # Frontend test suite
│   │   ├── unit/
│   │   └── integration/
│   │
│   ├── public/
│   ├── .env
│   ├── package.json
│   └── README.md
│
├── database/                 # Database scripts and migrations
│   ├── schema.sql
│   ├── seed.sql
│   └── README.md
│
├── docs/                     # Project documentation
│   ├── API_SPEC.md
│   ├── ARCHITECTURE.md
│   └── DEPLOYMENT.md
│
├── .gitignore
├── docker-compose.yml
├── README.md
└── LICENSE
```

## Detailed Page Descriptions

### 1. Landing Page
- Welcoming design showcasing platform value proposition
- Clear call-to-action for sign-up/sign-in
- Brief explanation of platform functionality
- Responsive and modern UI design

### 2. Authentication Pages
#### Sign In
- Email/username input
- Password input
- OAuth integration options
- Error handling and validation
- Remember me functionality

#### Sign Up
- Email registration
- Password creation with strength validation
- Optional additional profile information
- Terms of service agreement
- Email verification process

### 3. Home Page
- Personalized dashboard
- "Get Started" button leading to job posting/browsing
- Quick stats and notifications
- Recent activity summary
- Job offer process visualization

### 4. Job Offer Process Flow
- Waitlist status tracking
- Real-time updates on job offer stages
- Communication interface with homeowner
- Progress tracking with clear visual indicators
- Notification system for status changes

### 5. Post a Job Page
- Comprehensive job posting form
- Genre/category selection
- Detailed job description fields
- Pricing and requirements input
- Image/document upload capability
- Preview and submission functionality

### 6. Jobs Page
- Grid/list view of job postings
- Advanced filtering system (by genre, price, location)
- Search functionality
- Pagination
- Quick view and detailed view modes

### 7. Profile Page
- Personal information section
- Completed jobs showcase
- Jobs performed history
- Review and rating system
- Performance metrics
- Edit profile functionality

## Architectural Principles
1. Separation of Concerns
2. Modular Design
3. Clean Architecture
4. SOLID Principles
5. DRY (Don't Repeat Yourself)
6. KISS (Keep It Simple, Stupid)

## Technology Stack
- Frontend: React.js, React Router, Tailwind CSS
- Backend: Node.js, Express.js
- Database: PostgreSQL
- Authentication: JWT, OAuth
- State Management: React Context
- Testing: Jest, React Testing Library
- Deployment: Docker, Kubernetes (optional)

## Recommended Development Workflow
1. Start with database schema design
2. Develop backend models and controllers
3. Create frontend components
4. Implement authentication
5. Build page-specific functionality
6. Integrate backend and frontend
7. Extensive testing
8. Deployment and monitoring
