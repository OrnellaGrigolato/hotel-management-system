<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agregar Nueva Habitación - Sistema de Gestión Hotelera</title>
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
            max-width: 800px;
            margin: 0 auto;
        }

        .header {
            text-align: center;
            margin-bottom: 3rem;
        }

        .header h1 {
            color: white;
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 1rem;
        }

        .header p {
            color: rgba(255,255,255,0.9);
            font-size: 1.1rem;
            font-weight: 300;
        }

        .form-card {
            background: white;
            border-radius: 16px;
            padding: 2.5rem;
            box-shadow: 0 8px 32px rgba(0,0,0,0.1);
            position: relative;
            overflow: hidden;
        }

        .form-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(135deg, #667eea, #764ba2);
        }

        .form-header {
            text-align: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #e2e8f0;
        }

        .form-header h2 {
            color: #2d3748;
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .form-header p {
            color: #718096;
            font-size: 1rem;
        }

        .form-grid {
            display: grid;
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
        }

        .form-label {
            font-weight: 600;
            color: #2d3748;
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-label .required {
            color: #e53e3e;
            font-size: 1.1rem;
        }

        .form-input,
        .form-select {
            padding: 1rem 1.25rem;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1rem;
            background: white;
            color: #2d3748;
            transition: all 0.3s ease;
            font-family: inherit;
        }

        .form-input:focus,
        .form-select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            transform: translateY(-1px);
        }

        .form-select {
            cursor: pointer;
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='m6 8 4 4 4-4'/%3e%3c/svg%3e");
            background-position: right 0.75rem center;
            background-repeat: no-repeat;
            background-size: 1.25rem;
            padding-right: 3rem;
            appearance: none;
        }

        .input-hint {
            font-size: 0.85rem;
            color: #a0aec0;
            font-style: italic;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }

        .form-actions {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            padding-top: 2rem;
            border-top: 1px solid #e2e8f0;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.875rem 2rem;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 500;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
            font-family: inherit;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background: #f7fafc;
            color: #4a5568;
            border: 2px solid #e2e8f0;
        }

        .btn-secondary:hover {
            background: #edf2f7;
            border-color: #cbd5e0;
            transform: translateY(-1px);
        }

        .price-input-container {
            position: relative;
        }

        .price-input-container::before {
            content: '$';
            position: absolute;
            left: 1.25rem;
            top: 50%;
            transform: translateY(-50%);
            color: #4a5568;
            font-weight: 600;
            z-index: 1;
        }

        .price-input {
            padding-left: 2.5rem;
        }

        .form-icon {
            color: #667eea;
            font-size: 0.9rem;
        }

        .navigation-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
        }

        .success-animation {
            display: none;
            text-align: center;
            padding: 2rem;
        }

        .success-animation.show {
            display: block;
        }

        .success-animation i {
            font-size: 3rem;
            color: #48bb78;
            margin-bottom: 1rem;
            animation: bounce 1s ease-in-out;
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {
                transform: translateY(0);
            }
            40% {
                transform: translateY(-10px);
            }
            60% {
                transform: translateY(-5px);
            }
        }

        @media (max-width: 768px) {
            body {
                padding: 1rem;
            }
            
            .header h1 {
                font-size: 2rem;
                flex-direction: column;
                gap: 0.5rem;
            }
            
            .form-card {
                padding: 1.5rem;
            }
            
            .form-row {
                grid-template-columns: 1fr;
                gap: 1rem;
            }
            
            .form-actions {
                flex-direction: column;
            }
        }

        /* Loading state */
        .btn-primary:disabled {
            opacity: 0.7;
            cursor: not-allowed;
            transform: none;
        }

        .btn-primary:disabled:hover {
            transform: none;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>
                <i class="fas fa-plus-circle"></i>
                Nueva Habitación
            </h1>
            <p>Agrega una nueva habitación al inventario del hotel</p>
        </div>
        
        <div class="form-card">
            <div class="form-header">
                <h2>
                    <i class="fas fa-bed"></i>
                    Información de la Habitación
                </h2>
                <p>Completa todos los campos para registrar la nueva habitación</p>
            </div>

            <form method="post" action="${mvc.uri('guardarHabitacion')}" id="roomForm">
                <div class="form-grid">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="numero" class="form-label">
                                <i class="fas fa-door-open form-icon"></i>
                                Número de Habitación
                                <span class="required">*</span>
                            </label>
                            <input 
                                type="number" 
                                id="numero"
                                name="numero" 
                                class="form-input"
                                required
                                min="1"
                                max="9999"
                                placeholder="Ej: 101"
                            >
                            <span class="input-hint">Ingresa el número único de la habitación</span>
                        </div>

                        <div class="form-group">
                            <label for="tipo" class="form-label">
                                <i class="fas fa-tags form-icon"></i>
                                Tipo de Habitación
                                <span class="required">*</span>
                            </label>
                            <select id="tipo" name="tipo" class="form-select" required>
                                <option value="">Selecciona el tipo</option>
                                <option value="simple">Simple</option>
                                <option value="doble">Doble</option>
                                <option value="suite">Suite</option>
                            </select>
                            <span class="input-hint">Selecciona la categoría de la habitación</span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="precioPorNoche" class="form-label">
                            <i class="fas fa-dollar-sign form-icon"></i>
                            Precio por Noche
                            <span class="required">*</span>
                        </label>
                        <div class="price-input-container">
                            <input 
                                type="number" 
                                id="precioPorNoche"
                                name="precioPorNoche" 
                                class="form-input price-input"
                                required
                                min="0"
                                placeholder="0.00"
                            >
                        </div>
                        <span class="input-hint">Precio en ARS por noche de estadía</span>
                    </div>
                </div>

                <div class="form-actions">
                    <a href="../habitaciones" class="btn btn-secondary">
                        <i class="fas fa-times"></i>
                        Cancelar
                    </a>
                    <button type="submit" class="btn btn-primary" id="submitBtn">
                        <i class="fas fa-save"></i>
                        Guardar Habitación
                    </button>
                </div>
            </form>

            <div class="success-animation" id="successAnimation">
                <i class="fas fa-check-circle"></i>
                <h3>¡Habitación guardada exitosamente!</h3>
                <p>La habitación ha sido agregada al inventario</p>
            </div>
        </div>

        <div class="navigation-buttons">
            <a href="../habitaciones" class="btn btn-secondary">
                <i class="fas fa-list"></i>
                Ver Todas las Habitaciones
            </a>
            <a href="../home" class="btn btn-secondary">
                <i class="fas fa-home"></i>
                Volver al Inicio
            </a>
        </div>
    </div>

    <script>
        // Validación y manejo de envío del formulario
        document.getElementById('roomForm').addEventListener('submit', function(e) {
            const submitBtn = document.getElementById('submitBtn');
            
            // Agregar estado de carga
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Guardando...';
            
        });

        // Auto-focus en el primer input
        document.getElementById('numero').focus();
    </script>
</body>
</html>
