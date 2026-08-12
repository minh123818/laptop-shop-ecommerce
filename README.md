# Laptop Shop E-commerce System

A laptop e-commerce web application built with Java and Spring Boot.

## Overview

This project is a full-stack e-commerce application for managing and purchasing laptops online. It uses Spring Boot with a layered architecture to separate web controllers, business logic, and data access.

## Features

- User registration and login
- Role-based authentication and authorization
- Product management
- Product search, filtering, and pagination
- Shopping cart
- Order processing
- Admin dashboard
- Product image upload and management
- Database persistence with Spring Data JPA
- API functionality for selected application features
- Docker configuration for application and database deployment

## Tech Stack

- **Language:** Java
- **Backend:** Spring Boot, Spring MVC, Spring Security
- **Persistence:** Spring Data JPA, Hibernate
- **Database:** MySQL
- **Frontend:** Thymeleaf, HTML, CSS, JavaScript
- **Build Tool:** Maven
- **Containerization:** Docker
- **Version Control:** Git, GitHub

## Architecture

The application follows a layered architecture:

```text
Controller
    ↓
Service
    ↓
Repository
    ↓
MySQL Database
```

Spring MVC and Thymeleaf are used for server-side web pages, while API endpoints are provided for selected application features.

## Project Structure

```text
src/main/java/laptopshop/
├── controller/
├── service/
├── repository/
├── entity/
├── dto/
└── config/
```

## Database

The application uses MySQL for relational data storage and Spring Data JPA / Hibernate for persistence.

Database configuration is provided through environment variables. Sensitive credentials are not stored directly in the repository.

Example environment variables:

```text
MYSQL_USERNAME=root
MYSQL_PASSWORD=your_password
```

## Running the Project

### Prerequisites

Make sure the following are installed:

- JDK 17+
- Maven
- MySQL
- Docker (optional)

### Configuration

Create a `.env` file locally and configure your database credentials:

```text
MYSQL_USERNAME=root
MYSQL_PASSWORD=your_password
```

Do not commit the `.env` file to GitHub.

### Run with Maven

```bash
mvn spring-boot:run
```

Or run the main Spring Boot application class from your IDE.

### Run with Docker

If Docker is configured on your system:

```bash
docker compose up --build
```

## API

The project contains API endpoints for selected application functionality.

Example:

```text
POST /api/add-product-to-cart
```

RESTful API design and additional API endpoints can be extended as the project evolves.

## Security

Spring Security is used to implement authentication and role-based authorization.

Sensitive configuration such as database passwords is supplied through environment variables and excluded from version control.

## Future Improvements

- Expand the RESTful API layer
- Improve API documentation
- Add automated tests
- Add DTO-based request/response handling across APIs
- Improve error handling and validation
- Add payment integration
- Improve deployment configuration

## Author

**Doan Duc Minh**

Information Technology Graduate  
Java Backend Fresher Candidate
