# 🏨 Hotel Management System

[![Java](https://img.shields.io/badge/Java-17+-orange?style=flat&logo=java)](https://www.oracle.com/java/)
[![Jakarta EE](https://img.shields.io/badge/Jakarta%20EE-10.0-blue?style=flat&logo=eclipse)](https://jakarta.ee/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15+-blue?style=flat&logo=postgresql)](https://www.postgresql.org/)
[![Payara](https://img.shields.io/badge/Payara-6-blue?style=flat)](https://www.payara.fish/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

> A modern, full-featured hotel management system built with Jakarta EE, MVC pattern, and PostgreSQL database.

[🇪🇸 Versión en Español](README_ES.md)

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Technologies](#-technologies)
- [Prerequisites](#-prerequisites)
- [Installation](#-installation)
- [Database Setup](#-database-setup)
- [Running the Application](#-running-the-application)
- [Project Structure](#-project-structure)
- [Usage Guide](#-usage-guide)
- [API Endpoints](#-api-endpoints)

---

## 🌟 Overview

The **Hotel Management System** is a comprehensive web application designed to streamline hotel operations. It provides an intuitive interface for managing rooms, guests, and reservations with real-time availability tracking, automatic pricing calculations, and conflict prevention.

### Key Highlights

- ✅ **Full CRUD Operations** for Rooms, Guests, and Reservations
- ✅ **Real-time Room Availability** tracking
- ✅ **Guest Status Management** (Active/Registered)
- ✅ **Automatic Price Calculation** based on stay duration
- ✅ **Date Validation** and conflict prevention
- ✅ **Responsive Design** with modern UI/UX
- ✅ **Filter and Search** capabilities
- ✅ **Data Integrity** with unique constraint validation

---

## ✨ Features

### 🛏️ Room Management

- Add, edit, and delete hotel rooms
- Define room types (Single, Double, Suite, etc.)
- Set individual pricing per night
- Track room availability status (Available/Occupied)
- Filter rooms by type
- Real-time occupancy detection

### 👥 Guest Management

- Complete guest registry with personal information
- Unique document ID validation
- Contact information management
- Guest status tracking (Active/Registered)
- View guest reservation history
- Prevent duplicate registrations

### 📅 Reservation Management

- Create new reservations with date selection
- Automatic total price calculation
- Check-in and check-out date management
- Conflict detection (overlapping reservations)
- Filter reservations by:
  - Room type
  - Date range
  - Status
- Prevent double-booking of rooms and guests
- View detailed reservation information

---

## 🛠️ Technologies

### Backend

- **Java 17+** - Core programming language
- **Jakarta EE 10** - Enterprise Java platform
- **Jakarta MVC 2.1** - Model-View-Controller framework
- **Jakarta RESTful Web Services** - REST API implementation
- **JDBC** - Database connectivity

### Frontend

- **JSP (JavaServer Pages)** - Dynamic web pages
- **HTML5 & CSS3** - Modern markup and styling
- **Font Awesome** - Icon library
- **Responsive Design** - Mobile-friendly interface

### Database

- **PostgreSQL 15+** - Relational database
- **JDBC Driver** - PostgreSQL connector

### Application Server

- **Payara Server 6** - Jakarta EE certified server

### Build & Deployment

- **Gradle** - Build automation tool
- **Docker** - Container orchestration

---

## 📦 Prerequisites

Before you begin, ensure you have the following installed:

- ☕ **JDK 17 or higher** - [Download here](https://www.oracle.com/java/technologies/downloads/)
- 🐋 **Docker** - [Download here](https://www.docker.com/)
- 🏗️ **Gradle** - [Download here](https://gradle.org/install/)
- 🌊 **Payara Server 6** - Included in the project under `payara6/` directory

---

## 🚀 Installation

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/hotel-management-system.git
cd hotel-management-system
```

### 2. Set Up Environment Variables

The project uses the following default database configuration:

```properties
Database URL: jdbc:postgresql://localhost:5432/hoteldb
Username: pw3
Password: fichunl
```

You can modify these values in `src/main/java/progweb3/Repositorio.java` if needed:

```java
@DataSourceDefinition(
    name = "appDS",
    className = "org.postgresql.ds.PGSimpleDataSource",
    url = "jdbc:postgresql://localhost:5432/hoteldb?TimeZone=UTC",
    user = "pw3",
    password = "fichunl"
)
```

---

## 💾 Database Setup

### Run Docker Compose

The easiest way to set up the database is using Docker Compose:

```bash
# Start PostgreSQL and pgAdmin containers
docker-compose up -d

# Verify containers are running
docker ps
```

This will create:

- 🐘 **PostgreSQL** on port `5432`
- 🔧 **pgAdmin** on port `80` (http://localhost)

**pgAdmin Credentials:**

- Email: `admin@admin.com`
- Password: `admin`

### Database Schema

Connect to the database and create the required tables:

`````sql
-- Connect to the database
\c hoteldb

-- Create tables
CREATE TABLE habitacion(
    id SERIAL PRIMARY KEY,
    numerodehabitacion INTEGER NOT NULL,
    preciopornoche INTEGER NOT NULL,
    tipo VARCHAR(15) NOT NULL
)

CREATE TABLE huesped (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    documento VARCHAR(15) NOT NULL
)

CREATE TABLE reserva (
    id SERIAL PRIMARY KEY,
    fecha_de_ingreso DATE NOT NULL,
    fecha_de_salida DATE NOT NULL,
    preciototal INTEGER NOT NULL,
    habitacion INTEGER REFERENCES habitacion(id) ON DELETE CASCADE,
    huesped INTEGER REFERENCES huesped(id)  ON DELETE CASCADE
);


### Sample Data (Optional)

````sql
-- Insert sample rooms
INSERT INTO habitacion (numerodehabitacion, tipo, preciopornoche) VALUES
(101, 'Simple', 50),
(102, 'Simple', 50),
(201, 'Doble', 80),
(202, 'Doble', 80),
(301, 'Suite', 150);

-- Insert sample guests
INSERT INTO huesped (documento, nombre, telefono) VALUES
('12345678', 'Juan Pérez', '+54555350101'),
('87654321', 'María García', '+5434220102'),
('11223344', 'Carlos López', '+54115010352');

-- Insert sample reservations
INSERT INTO reserva (fecha_de_ingreso, fecha_de_salida, preciototal, habitacion, huesped) VALUES
('2025-12-01', '2025-12-05', 200, 1, 1),
('2025-12-10', '2025-12-15', 400, 3, 2);
`````

---

## ▶️ Running the Application

### Step 1: Start the Database

```bash
docker-compose up -d
```

### Step 2: Start Payara Server

```bash
payara6\bin\asadmin start-domain
```

### Step 4: Build and Deploy

```bash
# Build the WAR file
gradle build

# Deploy
payara6\bin\asadmin deploy --name hotel build\libs\FINAL.war
# The application will be available at:
# http://localhost:8080/hotel/app/home
```

### Stopping the Application

```bash
# Undeploy the application
payara6\bin\asadmin undeploy --name hotel

# Stop the server
payara6\bin\asadmin stop-domain

# Stop Docker containers (if used)
docker-compose down
```

---

## 📁 Project Structure

```
FINAL/
├── src/
│   └── main/
│       ├── java/
│       │   └── progweb3/
│       │       ├── App.java                 # JAX-RS Application
│       │       ├── AppController.java       # Main MVC Controller
│       │       ├── Repositorio.java         # Data Access Layer
│       │       ├── Habitacion.java          # Room Entity
│       │       ├── Huesped.java             # Guest Entity
│       │       ├── Reserva.java             # Reservation Entity
│       │       ├── Autor.java               # Author Entity (legacy)
│       │       └── Libro.java               # Book Entity (legacy)
│       └── webapp/
│           └── WEB-INF/
│               ├── beans.xml                # CDI Configuration
│               └── views/
│                   ├── home.jsp             # Home Page
│                   ├── habitaciones/        # Room Views
│                   │   ├── lista.jsp
│                   │   ├── habitacion.jsp
│                   │   ├── form.jsp
│                   │   └── form_de_edicion.jsp
│                   ├── huespedes/           # Guest Views
│                   │   ├── lista.jsp
│                   │   ├── huesped.jsp
│                   │   ├── form.jsp
│                   │   └── form_de_edicion.jsp
│                   └── reservas/            # Reservation Views
│                       ├── lista.jsp
│                       ├── reserva.jsp
│                       └── form.jsp
├── payara6/                                 # Payara Server
├── build.gradle                             # Gradle Build Script
├── compose.yaml                             # Docker Compose Config
└── README.md                                # This file
```

---

## 📖 Usage Guide

### Accessing the Application

1. Open your browser and navigate to: `http://localhost:8080/hotel/app/home`
2. You'll see the main dashboard with three modules

### Managing Rooms

1. Click on **"Gestionar Habitaciones"** (Manage Rooms)
2. **Add a Room**: Click "Nueva Habitación" (New Room)
   - Enter room number
   - Select room type (Simple, Doble, Suite)
   - Set price per night
3. **Edit a Room**: Click the edit icon next to any room
4. **Delete a Room**: Click the delete icon (only if no active reservations)
5. **Filter Rooms**: Use the dropdown to filter by type or show all

### Managing Guests

1. Click on **"Gestionar Huéspedes"** (Manage Guests)
2. **Add a Guest**: Click "Nuevo Huésped" (New Guest)
   - Enter full name
   - Enter unique document ID
   - Enter phone number
3. **Edit a Guest**: Click the edit icon
4. **Delete a Guest**: Click the delete icon (only if no active reservations)
5. **View Status**: Green badge = Active, Gray badge = Registered

### Managing Reservations

1. Click on **"Gestionar Reservas"** (Manage Reservations)
2. **Create a Reservation**: Click "Nueva Reserva" (New Reservation)
   - Select an available guest (non-active)
   - Select an available room
   - Choose check-in date (must be in the future)
   - Choose check-out date (must be after check-in)
   - Total price is calculated automatically
3. **View Reservation**: Click on any reservation to see details
4. **Delete a Reservation**: Click the delete icon
5. **Filter Reservations**:
   - By room type: Use the dropdown menu
   - By date range: Use the date filter form

---

## 🔌 API Endpoints

### Rooms (`/app/habitaciones`)

| Method | Endpoint                          | Description      |
| ------ | --------------------------------- | ---------------- |
| GET    | `/app/habitaciones`               | List all rooms   |
| GET    | `/app/habitacion/{numero}`        | Get room details |
| GET    | `/app/habitacion/nuevo`           | New room form    |
| POST   | `/app/habitacion`                 | Create new room  |
| GET    | `/app/editarHabitacion`           | Edit room form   |
| POST   | `/app/editarHabitacion`           | Update room      |
| GET    | `/app/eliminarHabitacion/{id}`    | Delete room      |
| GET    | `/app/filtrarHabitaciones/{tipo}` | Filter by type   |

### Guests (`/app/huespedes`)

| Method | Endpoint                    | Description       |
| ------ | --------------------------- | ----------------- |
| GET    | `/app/huespedes`            | List all guests   |
| GET    | `/app/huesped/{id}`         | Get guest details |
| GET    | `/app/huesped/nuevo`        | New guest form    |
| POST   | `/app/huesped`              | Create new guest  |
| GET    | `/app/editarHuesped`        | Edit guest form   |
| POST   | `/app/editarHuesped`        | Update guest      |
| GET    | `/app/eliminarHuesped/{id}` | Delete guest      |

### Reservations (`/app/reservas`)

| Method | Endpoint                       | Description             |
| ------ | ------------------------------ | ----------------------- |
| GET    | `/app/reservas`                | List all reservations   |
| GET    | `/app/reserva/{id}`            | Get reservation details |
| GET    | `/app/reserva/nuevo`           | New reservation form    |
| POST   | `/app/reserva`                 | Create new reservation  |
| GET    | `/app/eliminarReserva/{id}`    | Delete reservation      |
| GET    | `/app/filtrarReservas/{tipo}`  | Filter by room type     |
| GET    | `/app/filtrarReservasPorFecha` | Filter by date range    |

---

## 👨‍💻 Author

Created with ❤️ by Ornella Grigolato

<div align="center">

**[⬆ Back to Top](#-hotel-management-system)**

Made with 🧉 and ❤️

</div>
