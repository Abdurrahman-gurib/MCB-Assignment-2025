# MCB-Assignment-2025
Abdurrahman Noor-Ul-Haqq Gurib

# MCB Software Engineering Assignment

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
- **Authentication**: JWT-based authentication
- **Data Migration**: SQL scripts
- **Reporting**: API endpoints
- **API Documentation**: Swagger UI

### Frontend (MCBFrontend)
- **Framework**: Angular
- **UI Components**: HTML, CSS, TypeScript
- **Services**: API integration with backend

### Database
- **Database Engine**: Microsoft SQL Server (MSSQL)
- **Normalization**: Properly structured schema
- **Data Migration**: SQL scripts for moving data from legacy tables xls format

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
## Future Improvements
- Implement role-based access control (RBAC)
- Improve UI design with Material UI
- Add unit tests for frontend (JEST & Jasmine) & backend
- Enhance security with OAuth2

---
## Author
Abdurrahman Noor-Ul-Haqq Gurib - Software Engineer Candidate

