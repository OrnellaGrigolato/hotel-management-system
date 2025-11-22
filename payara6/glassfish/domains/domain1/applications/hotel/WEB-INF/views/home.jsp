<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hotel Management System</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 2rem;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .header {
            text-align: center;
            margin-bottom: 3rem;
        }

        .header h1 {
            color: white;
            font-size: 3rem;
            margin-bottom: 0.5rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        .header p {
            color: rgba(255,255,255,0.9);
            font-size: 1.2rem;
            font-weight: 300;
        }

        .cards-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .card {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            text-decoration: none;
            color: inherit;
            box-shadow: 0 8px 32px rgba(0,0,0,0.1);
            transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
            overflow: hidden;
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            height: 100%;
            opacity: 0;
            transition: opacity 0.3s ease;
            z-index: 1;
        }

        .card.rooms::before {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.25), rgba(118, 75, 162, 0.25));
        }

        .card.guests::before {
            background: linear-gradient(135deg, rgba(240, 147, 251, 0.25), rgba(245, 87, 108, 0.25));
        }

        .card.reservations::before {
            background: linear-gradient(135deg, rgba(79, 172, 254, 0.25), rgba(0, 242, 254, 0.25));
        }

        .card {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            text-decoration: none;
            color: inherit;
            box-shadow: 0 8px 32px rgba(0,0,0,0.1);
            transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
            overflow: hidden;
            transform: translateY(0) scale(1);
        }

        .card > * {
            position: relative;
            z-index: 2;
        }

        .card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        }

        .card:hover::before {
            opacity: 1;
        }

        .card-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
            transition: transform 0.3s ease;
        }

        .card:hover .card-icon {
            transform: scale(1.1) rotate(5deg);
        }

        .card.rooms .card-icon {
            background: linear-gradient(135deg, #667eea, #764ba2);
        }

        .card.guests .card-icon {
            background: linear-gradient(135deg, #f093fb, #f5576c);
        }

        .card.reservations .card-icon {
            background: linear-gradient(135deg, #4facfe, #00f2fe);
        }

        .card-icon i {
            font-size: 2rem;
            color: white;
        }

        .card-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 0.8rem;
            color: #2d3748;
        }

        .card-description {
            color: #718096;
            font-size: 1rem;
            line-height: 1.5;
            margin-bottom: 1.5rem;
        }

        .card-arrow {
            display: flex;
            align-items: center;
            color: #a0aec0;
            font-size: 0.9rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .card:hover .card-arrow {
            color: #4a5568;
            transform: translateX(4px);
        }

        .card-arrow i {
            margin-left: 0.5rem;
            transition: transform 0.3s ease;
        }

        .card:hover .card-arrow i {
            transform: translateX(4px);
        }

        @media (max-width: 768px) {
            body {
                padding: 1rem;
            }
            
            .header h1 {
                font-size: 2rem;
            }
            
            .cards-container {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }
            
            .card {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><i class="fas fa-hotel"></i> Sistema de Gestión Hotelera</h1>
            <p>Administra tu hotel de manera eficiente y profesional</p>
        </div>
        
        <div class="cards-container">
            <a href="${pageContext.request.contextPath}/app/habitaciones" class="card rooms">
                <div class="card-icon">
                    <i class="fas fa-bed"></i>
                </div>
                <h2 class="card-title">Gestionar Habitaciones</h2>
                <p class="card-description">
                    Administra el inventario de habitaciones, disponibilidad, tipos de habitación y configuraciones de precios.
                </p>
                <div class="card-arrow">
                    Acceder al módulo <i class="fas fa-arrow-right"></i>
                </div>
            </a>
            
            <a href="${pageContext.request.contextPath}/app/huespedes" class="card guests">
                <div class="card-icon">
                    <i class="fas fa-users"></i>
                </div>
                <h2 class="card-title">Gestionar Huéspedes</h2>
                <p class="card-description">
                    Mantén un registro completo de huéspedes, sus datos personales, historial y preferencias.
                </p>
                <div class="card-arrow">
                    Acceder al módulo <i class="fas fa-arrow-right"></i>
                </div>
            </a>
            
            <a href="${pageContext.request.contextPath}/app/reservas" class="card reservations">
                <div class="card-icon">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <h2 class="card-title">Gestionar Reservas</h2>
                <p class="card-description">
                    Controla las reservaciones, check-in, check-out y la ocupación del hotel en tiempo real.
                </p>
                <div class="card-arrow">
                    Acceder al módulo <i class="fas fa-arrow-right"></i>
                </div>
            </a>
        </div>
    </div>
</body>
</html>