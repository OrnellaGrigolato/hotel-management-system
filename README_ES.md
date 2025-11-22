# 🏨 Sistema de Gestión Hotelera

[![Java](https://img.shields.io/badge/Java-17+-orange?style=flat&logo=java)](https://www.oracle.com/java/)
[![Jakarta EE](https://img.shields.io/badge/Jakarta%20EE-10.0-blue?style=flat&logo=eclipse)](https://jakarta.ee/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15+-blue?style=flat&logo=postgresql)](https://www.postgresql.org/)
[![Payara](https://img.shields.io/badge/Payara-6-blue?style=flat)](https://www.payara.fish/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

> Un sistema moderno y completo de gestión hotelera construido con Jakarta EE, patrón MVC y base de datos PostgreSQL.

[🇬🇧 English Version](README.md)

---

## 📋 Tabla de Contenidos

- [Descripción General](#-descripción-general)
- [Características](#-características)
- [Tecnologías](#-tecnologías)
- [Requisitos Previos](#-requisitos-previos)
- [Instalación](#-instalación)
- [Configuración de la Base de Datos](#-configuración-de-la-base-de-datos)
- [Ejecutar la Aplicación](#️-ejecutar-la-aplicación)
- [Estructura del Proyecto](#-estructura-del-proyecto)
- [Guía de Uso](#-guía-de-uso)
- [Endpoints de la API](#-endpoints-de-la-api)

---

## 🌟 Descripción General

El **Sistema de Gestión Hotelera** es una aplicación web completa diseñada para optimizar las operaciones hoteleras. Proporciona una interfaz intuitiva para gestionar habitaciones, huéspedes y reservas con seguimiento de disponibilidad en tiempo real, cálculo automático de precios y prevención de conflictos.

### Aspectos Destacados

- ✅ **Operaciones CRUD Completas** para Habitaciones, Huéspedes y Reservas
- ✅ **Seguimiento de Disponibilidad en Tiempo Real** de habitaciones
- ✅ **Gestión de Estados de Huéspedes** (Activo/Registrado)
- ✅ **Cálculo Automático de Precios** basado en duración de estadía
- ✅ **Validación de Fechas** y prevención de conflictos
- ✅ **Diseño Responsivo** con UI/UX moderna
- ✅ **Capacidades de Filtrado y Búsqueda**
- ✅ **Integridad de Datos** con validación de restricciones únicas

### 🎥 Video Demostrativo

Mira una demostración completa del sistema en acción:

## [![Demo Sistema de Gestión Hotelera](https://img.shields.io/badge/▶️_Ver_Demo-Video-red?style=for-the-badge)](https://github.com/OrnellaGrigolato/hotel-management-system/blob/master/Hotel%20Management%20System%20Demo.mp4)

## ✨ Características

### 🛏️ Gestión de Habitaciones

- Agregar, editar y eliminar habitaciones del hotel
- Definir tipos de habitación (Simple, Doble, Suite, etc.)
- Establecer precios individuales por noche
- Seguimiento del estado de disponibilidad (Disponible/Ocupada)
- Filtrar habitaciones por tipo
- Detección de ocupación en tiempo real

### 👥 Gestión de Huéspedes

- Registro completo de huéspedes con información personal
- Validación de ID de documento único
- Gestión de información de contacto
- Seguimiento del estado del huésped (Activo/Registrado)
- Ver historial de reservas del huésped
- Prevenir registros duplicados

### 📅 Gestión de Reservas

- Crear nuevas reservas con selección de fechas
- Cálculo automático del precio total
- Gestión de fechas de check-in y check-out
- Detección de conflictos (reservas superpuestas)
- Filtrar reservas por:
  - Tipo de habitación
  - Rango de fechas
  - Estado
- Prevenir doble reserva de habitaciones e huéspedes
- Ver información detallada de reservas

---

## 🛠️ Tecnologías

### Backend

- **Java 17+** - Lenguaje de programación principal
- **Jakarta EE 10** - Plataforma Java empresarial
- **Jakarta MVC 2.1** - Framework Modelo-Vista-Controlador
- **Jakarta RESTful Web Services** - Implementación API REST
- **JDBC** - Conectividad con base de datos

### Frontend

- **JSP (JavaServer Pages)** - Páginas web dinámicas
- **HTML5 y CSS3** - Marcado y estilos modernos
- **Font Awesome** - Biblioteca de iconos
- **Diseño Responsivo** - Interfaz adaptable a móviles

### Base de Datos

- **PostgreSQL 15+** - Base de datos relacional
- **JDBC Driver** - Conector de PostgreSQL

### Servidor de Aplicaciones

- **Payara Server 6** - Servidor certificado Jakarta EE

### Construcción y Despliegue

- **Gradle** - Herramienta de automatización de construcción
- **Docker** - Orquestación de contenedores

---

## 📦 Requisitos Previos

Antes de comenzar, asegúrate de tener instalado lo siguiente:

- ☕ **JDK 17 o superior** - [Descargar aquí](https://www.oracle.com/java/technologies/downloads/)
- 🐋 **Docker** - [Descargar aquí](https://www.docker.com/)
- 🏗️ **Gradle** - [Descargar aquí](https://gradle.org/install/)
- 🌊 **Payara Server 6** - Incluido en el proyecto bajo el directorio `payara6/`

---

## 🚀 Instalación

### 1. Clonar el Repositorio

```bash
git clone https://github.com/tuusuario/hotel-management-system.git
cd hotel-management-system
```

### 2. Configurar Variables de Entorno

El proyecto utiliza la siguiente configuración de base de datos por defecto:

```properties
URL de Base de Datos: jdbc:postgresql://localhost:5432/hoteldb
Usuario: pw3
Contraseña: fichunl
```

Puedes modificar estos valores en `src/main/java/progweb3/Repositorio.java` si es necesario:

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

## 💾 Configuración de la Base de Datos

### Ejecutar Docker Compose

La forma más fácil de configurar la base de datos es usando Docker Compose:

```bash
# Iniciar contenedores de PostgreSQL y pgAdmin
docker-compose up -d

# Verificar que los contenedores estén ejecutándose
docker ps
```

Esto creará:

- 🐘 **PostgreSQL** en el puerto `5432`
- 🔧 **pgAdmin** en el puerto `80` (http://localhost)

**Credenciales de pgAdmin:**

- Email: `admin@admin.com`
- Contraseña: `admin`

### Esquema de la Base de Datos

Conéctate a la base de datos y crea las tablas requeridas:

```sql
-- Conectar a la base de datos
\c hoteldb

-- Crear tablas
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
```

### Datos de Ejemplo (Opcional)

```sql
-- Insertar habitaciones de ejemplo
INSERT INTO habitacion (numerodehabitacion, tipo, preciopornoche) VALUES
(101, 'Simple', 50),
(102, 'Simple', 50),
(201, 'Doble', 80),
(202, 'Doble', 80),
(301, 'Suite', 150);

-- Insertar huéspedes de ejemplo
INSERT INTO huesped (documento, nombre, telefono) VALUES
('12345678', 'Juan Pérez', '+54555350101'),
('87654321', 'María García', '+5434220102'),
('11223344', 'Carlos López', '+54115010352');

-- Insertar reservas de ejemplo
INSERT INTO reserva (fecha_de_ingreso, fecha_de_salida, preciototal, habitacion, huesped) VALUES
('2025-12-01', '2025-12-05', 200, 1, 1),
('2025-12-10', '2025-12-15', 400, 3, 2);
```

---

## ▶️ Ejecutar la Aplicación

### Paso 1: Iniciar la Base de Datos

```bash
docker-compose up -d
```

### Paso 2: Iniciar Payara Server

payara6\bin\asadmin start-domain

````

### Paso 4: Compilar y Desplegar

```bash
# Compilar el archivo WAR
gradle build

# Desplegar
payara6\bin\asadmin deploy --name hotel build\libs\FINAL.war
# La aplicación estará disponible en:
# http://localhost:8080/hotel/app/home
````

### Detener la Aplicación

```bash
# Desplegar la aplicación
payara6\bin\asadmin undeploy --name hotel

# Detener el servidor
payara6\bin\asadmin stop-domain

# Detener contenedores Docker (si se usaron)
docker-compose down
```

---

## 📁 Estructura del Proyecto

```
FINAL/
├── src/
│   └── main/
│       ├── java/
│       │   └── progweb3/
│       │       ├── App.java                 # Aplicación JAX-RS
│       │       ├── AppController.java       # Controlador MVC Principal
│       │       ├── Repositorio.java         # Capa de Acceso a Datos
│       │       ├── Habitacion.java          # Entidad Habitación
│       │       ├── Huesped.java             # Entidad Huésped
│       │       ├── Reserva.java             # Entidad Reserva
│       │       ├── Autor.java               # Entidad Autor (legacy)
│       │       └── Libro.java               # Entidad Libro (legacy)
│       └── webapp/
│           └── WEB-INF/
│               ├── beans.xml                # Configuración CDI
│               └── views/
│                   ├── home.jsp             # Página Principal
│                   ├── habitaciones/        # Vistas de Habitaciones
│                   │   ├── lista.jsp
│                   │   ├── habitacion.jsp
│                   │   ├── form.jsp
│                   │   └── form_de_edicion.jsp
│                   ├── huespedes/           # Vistas de Huéspedes
│                   │   ├── lista.jsp
│                   │   ├── huesped.jsp
│                   │   ├── form.jsp
│                   │   └── form_de_edicion.jsp
│                   └── reservas/            # Vistas de Reservas
│                       ├── lista.jsp
│                       ├── reserva.jsp
│                       └── form.jsp
├── payara6/                                 # Servidor Payara
├── build.gradle                             # Script de Compilación Gradle
├── compose.yaml                             # Configuración Docker Compose
└── README_ES.md                             # Este archivo
```

---

## 📖 Guía de Uso

### Acceder a la Aplicación

1. Abre tu navegador y navega a: `http://localhost:8080/hotel/app/home`
2. Verás el panel principal con tres módulos

### Gestionar Habitaciones

1. Haz clic en **"Gestionar Habitaciones"**
2. **Agregar una Habitación**: Haz clic en "Nueva Habitación"
   - Ingresa el número de habitación
   - Selecciona el tipo de habitación (Simple, Doble, Suite)
   - Establece el precio por noche
3. **Editar una Habitación**: Haz clic en el ícono de editar junto a cualquier habitación
4. **Eliminar una Habitación**: Haz clic en el ícono de eliminar (solo si no hay reservas activas)
5. **Filtrar Habitaciones**: Usa el menú desplegable para filtrar por tipo o mostrar todas

### Gestionar Huéspedes

1. Haz clic en **"Gestionar Huéspedes"**
2. **Agregar un Huésped**: Haz clic en "Nuevo Huésped"
   - Ingresa el nombre completo
   - Ingresa un ID de documento único
   - Ingresa el número de teléfono
3. **Editar un Huésped**: Haz clic en el ícono de editar
4. **Eliminar un Huésped**: Haz clic en el ícono de eliminar (solo si no hay reservas activas)
5. **Ver Estado**: Insignia verde = Activo, Insignia gris = Registrado

### Gestionar Reservas

1. Haz clic en **"Gestionar Reservas"**
2. **Crear una Reserva**: Haz clic en "Nueva Reserva"
   - Selecciona un huésped disponible (no activo)
   - Selecciona una habitación disponible
   - Elige la fecha de check-in (debe ser en el futuro)
   - Elige la fecha de check-out (debe ser después del check-in)
   - El precio total se calcula automáticamente
3. **Ver Reserva**: Haz clic en cualquier reserva para ver detalles
4. **Eliminar una Reserva**: Haz clic en el ícono de eliminar
5. **Filtrar Reservas**:
   - Por tipo de habitación: Usa el menú desplegable
   - Por rango de fechas: Usa el formulario de filtro de fechas

---

## 🔌 Endpoints de la API

### Habitaciones (`/app/habitaciones`)

| Método | Endpoint                          | Descripción                    |
| ------ | --------------------------------- | ------------------------------ |
| GET    | `/app/habitaciones`               | Listar todas las habitaciones  |
| GET    | `/app/habitacion/{numero}`        | Obtener detalles de habitación |
| GET    | `/app/habitacion/nuevo`           | Formulario nueva habitación    |
| POST   | `/app/habitacion`                 | Crear nueva habitación         |
| GET    | `/app/editarHabitacion`           | Formulario editar habitación   |
| POST   | `/app/editarHabitacion`           | Actualizar habitación          |
| GET    | `/app/eliminarHabitacion/{id}`    | Eliminar habitación            |
| GET    | `/app/filtrarHabitaciones/{tipo}` | Filtrar por tipo               |

### Huéspedes (`/app/huespedes`)

| Método | Endpoint                    | Descripción                 |
| ------ | --------------------------- | --------------------------- |
| GET    | `/app/huespedes`            | Listar todos los huéspedes  |
| GET    | `/app/huesped/{id}`         | Obtener detalles de huésped |
| GET    | `/app/huesped/nuevo`        | Formulario nuevo huésped    |
| POST   | `/app/huesped`              | Crear nuevo huésped         |
| GET    | `/app/editarHuesped`        | Formulario editar huésped   |
| POST   | `/app/editarHuesped`        | Actualizar huésped          |
| GET    | `/app/eliminarHuesped/{id}` | Eliminar huésped            |

### Reservas (`/app/reservas`)

| Método | Endpoint                       | Descripción                    |
| ------ | ------------------------------ | ------------------------------ |
| GET    | `/app/reservas`                | Listar todas las reservas      |
| GET    | `/app/reserva/{id}`            | Obtener detalles de reserva    |
| GET    | `/app/reserva/nuevo`           | Formulario nueva reserva       |
| POST   | `/app/reserva`                 | Crear nueva reserva            |
| GET    | `/app/eliminarReserva/{id}`    | Eliminar reserva               |
| GET    | `/app/filtrarReservas/{tipo}`  | Filtrar por tipo de habitación |
| GET    | `/app/filtrarReservasPorFecha` | Filtrar por rango de fechas    |

---

## 👨‍💻 Autor

Creado con ❤️ por Ornella Grigolato

<div align="center">

**[⬆ Volver Arriba](#-sistema-de-gestión-hotelera)**

Hecho con 🧉 y ❤️

</div>
