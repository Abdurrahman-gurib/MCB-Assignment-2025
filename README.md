# MCB-Assignment-2025
Abdurrahman Noor-Ul-Haqq Gurib

# MCB Software Engineering Assignment

# Overview of the MCB Group Assignment Software Engineer
The assignment consists of several key tasks, including creating the “BCM_ORDER_MGT” table, developing a normalized database schema, and implementing various stored procedures for data migration and reporting. I ensured that the code followed best practices regarding clean code, unit tests, error handling, reusability, and performance optimization.

# Extra Work
In addition to the required tasks, I developed a full-stack web application designed for managing suppliers, orders, and invoices. Here are some key highlights:

- **Backend**: Built using ASP.NET Core Web API, with JWT-based authentication, SQL scripts for data migration, and Swagger UI for API documentation.
- **Frontend**: Developed with Angular 18, featuring user authentication, a dashboard for suppliers, orders, and invoices, and dynamic data fetching.
- **Database**: Utilized Microsoft SQL Server with a properly normalized schema, implementing stored procedures for report generation and financial analysis.

- # Additional Features
- Included role-based access control (RBAC), improved UI design using Material UI, and unit tests for both frontend (using JEST & Jasmine) and backend.

I have focused on delivering a comprehensive solution that not only meets the assignment requirements but also demonstrates my ability to build a full-stack application.

Thank you for considering my submission. Please let me know if you have any questions or require further information.


## Overview
This project is a full-stack web application designed for managing suppliers, orders, and invoices. It includes:
- A **backend** built with ASP.NET Core.
- A **frontend** developed using Angular 18.
- A **database** running on **MSSQL Server**.
- Implemented authentication, data visualization, reporting, and migration features.

---
## Technologies Used
### Backend (MCBBackend)
- **Framework**: ASP.NET Core Web API
- **Database**: MSSQL Server
- **Authentication Security**: JWT-based authentication
- **Data Migration**: SQL scripts
- **Reporting**: API endpoints
- **API Documentation**: Swagger UI
- **Unit Test**: NUnit
- ![image](https://github.com/user-attachments/assets/dc289880-ad01-4e25-b63c-aca62b10fb72)


### Frontend (MCBFrontend)
- **Framework**: Angular
- **UI Components**: HTML, CSS, TypeScript
- **Services**: API integration with backend
- **Unit Test**: Jasmine and JEST NPX
- **JWT Token Security**: HMAC-SHA256 with a secret key, the JWT has a short expiration time (15 minutes) to limit its validity period
- **Refresh Token Generation**: A GUID is used as a refresh token.
- ![image](https://github.com/user-attachments/assets/43a99061-f5b0-4ff9-a7dc-69b0dab43615)



### Database
- **Database Engine**: Microsoft SQL Server (MSSQL)
- **Normalization**: Properly structured schema
- **Data Migration**: SQL scripts for moving data from legacy tables xls format
- ![image](https://github.com/user-attachments/assets/b4344926-a6b4-4e63-a228-a94a6ab860b2)

- 

---
## Backend Features

### Authentication (`/api/Auth`)
- **POST** `/api/Auth/register` - Register a new user
- **POST** `/api/Auth/login` - Authenticate and generate JWT token

### Data Migration (`/api/Migration`)
- **GET** `/api/Migration/suppliers` - Fetch migrated supplier data
- **GET** `/api/Migration/orders` - Retrieve migrated orders
- **GET** `/api/Migration/invoices` - Retrieve migrated invoices

### Order Management (`/api/OrderManagement`)
- **GET** `/api/OrderManagement` - Fetch order data

### Reports (`/api/Report`)
- **GET** `/api/Report/orders` - Fetch order reports

### Supplier Orders (`/api/SupplierOrders`)
- **GET** `/api/SupplierOrders/summary` - Fetch supplier order summary

---
## Frontend Features

### Authentication Pages
- **Login** (User authentication via JWT)
- **Register** (New user registration)

### Dashboard Pages
- **Dashboard** (Displays suppliers, orders, and invoices)
- **Dashboard Two** (Includes median orders, order management, order reports, and supplier order summary)

### API Integration
- Uses `api.service.ts` to communicate with backend
- Data is fetched and displayed dynamically

---
## Database Implementation (MSSQL)

### Schema Design
- Normalized database schema
- Primary and foreign keys enforced

### Exercises Done (MSSQL Queries)
- **Data Migration Queries** (Transforming and importing data from `BCM_ORDER_MGT`)
- **Stored Procedures** (For report generation and financial analysis)
- **SQL Functions** (Used for business logic processing)
- **Indexing & Optimization** (Performance improvements on queries)

---
## Installation & Setup

### Backend Setup
1. Clone the repository:
   ```sh
   git clone https://github.com/MCB-Assignment-2025
   cd MCBBackend
   ```
2. Install dependencies:
   ```sh
   dotnet restore
   ```
3. Run the application:
   ```sh
   dotnet run
   ```
4. Open Swagger UI at: `http://localhost:5085/swagger`

### Frontend Setup
1. Navigate to frontend folder:
   ```sh
   cd MCBFrontend
   ```
2. Install dependencies:
   ```sh
   npm install
   ```
3. Run the application:
   ```sh
   ng serve --open
   ```



### Database Setup
1. Import the provided MSSQL script
2. Configure connection string in `appsettings.json`

---
## Highlights
- Implement role-based access control (RBAC)
- Improve UI design with Material UI
- Add unit tests for frontend (JEST & Jasmine) & backend
- Enhance security with OAuth2

---
## Author
Abdurrahman Noor-Ul-Haqq Gurib - Software Engineer Candidate

