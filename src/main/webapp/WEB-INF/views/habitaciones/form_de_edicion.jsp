<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Habitación ${habitacion.numeroDeHabitacion} - Hotel Management System</title>
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

        .current-info {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.05), rgba(118, 75, 162, 0.05));
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            border-left: 4px solid #667eea;
        }

        .current-info h3 {
            color: #2d3748;
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 1rem;
        }

        .info-item {
            text-align: center;
        }

        .info-label {
            font-size: 0.8rem;
            color: #a0aec0;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.25rem;
        }

        .info-value {
            font-size: 1.1rem;
            font-weight: 600;
            color: #2d3748;
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

        .changes-indicator {
            background: #fff5f5;
            border: 1px solid #fed7d7;
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 1.5rem;
            display: none;
        }

        .changes-indicator.show {
            display: block;
        }

        .changes-indicator i {
            color: #e53e3e;
            margin-right: 0.5rem;
        }

        .changes-indicator span {
            color: #742a2a;
            font-size: 0.9rem;
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
            
            .info-grid {
                grid-template-columns: 1fr;
                gap: 0.5rem;
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
                <i class="fas fa-edit"></i>
                Editar Habitación
            </h1>
            <p>Modifica la información de la habitación ${habitacion.numeroDeHabitacion}</p>
        </div>
        
        <div class="form-card">
            <div class="form-header">
                <h2>
                    <i class="fas fa-bed"></i>
                    Actualizar Información
                </h2>
                <p>Realiza los cambios necesarios y guarda las modificaciones</p>
            </div>

            <div class="current-info">
                <h3>
                    <i class="fas fa-info-circle"></i>
                    Información Actual
                </h3>
                <div class="info-grid">
                    <div class="info-item">
                        <div class="info-label">ID Sistema</div>
                        <div class="info-value">#${habitacion.id}</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Número</div>
                        <div class="info-value">${habitacion.numeroDeHabitacion}</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Tipo</div>
                        <div class="info-value">${habitacion.tipo}</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Precio</div>
                        <div class="info-value">$${habitacion.precioPorNoche}</div>
                    </div>
                </div>
            </div>

            <div class="changes-indicator" id="changesIndicator">
                <i class="fas fa-exclamation-triangle"></i>
                <span>Has realizado cambios. No olvides guardar las modificaciones.</span>
            </div>

            <form method="post" action="${mvc.uri('editarHabitacion')}" id="editForm">
                <input type="hidden" name="id" value="${habitacion.id}">
                
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
                                value="${habitacion.numeroDeHabitacion}"
                                required
                                min="1"
                                max="9999"
                                placeholder="Ej: 101"
                            >
                            <span class="input-hint">Número único de identificación de la habitación</span>
                        </div>

                        <div class="form-group">
                            <label for="tipo" class="form-label">
                                <i class="fas fa-tags form-icon"></i>
                                Tipo de Habitación
                                <span class="required">*</span>
                            </label>
                            <select id="tipo" name="tipo" class="form-select" required>
                                <option value="simple" ${habitacion.tipo == 'simple' ? 'selected' : ''}>Simple</option>
                                <option value="doble" ${habitacion.tipo == 'doble' ? 'selected' : ''}>Doble</option>
                                <option value="suite" ${habitacion.tipo == 'suite' ? 'selected' : ''}>Suite</option>
                            </select>
                            <span class="input-hint">Categoría de la habitación</span>
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
                                value="${habitacion.precioPorNoche}"
                                required
                                min="0"
                                placeholder="0.00"
                            >
                        </div>
                        <span class="input-hint">Precio en dólares por noche de estadía</span>
                    </div>
                </div>

                <div class="form-actions">
                    <a href="/habitacion/${habitacion.numeroDeHabitacion}" class="btn btn-secondary">
                        <i class="fas fa-times"></i>
                        Cancelar
                    </a>
                    <button type="submit" class="btn btn-primary" id="submitBtn">
                        <i class="fas fa-save"></i>
                        Guardar Cambios
                    </button>
                </div>
            </form>
        </div>

        <div class="navigation-buttons">
            <a href="habitacion/${habitacion.numeroDeHabitacion}" class="btn btn-secondary">
                <i class="fas fa-eye"></i>
                Ver Habitación
            </a>
            <a href="habitaciones" class="btn btn-secondary">
                <i class="fas fa-list"></i>
                Lista de Habitaciones
            </a>
            <a href="home" class="btn btn-secondary">
                <i class="fas fa-home"></i>
                Volver al Inicio
            </a>
        </div>
    </div>

    <script>
        // Store original values to detect changes
        const originalValues = {
            numero: document.getElementById('numero').value,
            tipo: document.getElementById('tipo').value,
            precioPorNoche: document.getElementById('precioPorNoche').value
        };

        // Function to check if form has changes
        function checkForChanges() {
            const currentValues = {
                numero: document.getElementById('numero').value,
                tipo: document.getElementById('tipo').value,
                precioPorNoche: document.getElementById('precioPorNoche').value
            };

            const hasChanges = Object.keys(originalValues).some(key => 
                originalValues[key] !== currentValues[key]
            );

            const indicator = document.getElementById('changesIndicator');
            if (hasChanges) {
                indicator.classList.add('show');
            } else {
                indicator.classList.remove('show');
            }
        }

        // Add change listeners to all form inputs
        document.getElementById('numero').addEventListener('input', checkForChanges);
        document.getElementById('tipo').addEventListener('change', checkForChanges);
        document.getElementById('precioPorNoche').addEventListener('input', checkForChanges);

        // Form submission handling
        document.getElementById('editForm').addEventListener('submit', function(e) {
            const submitBtn = document.getElementById('submitBtn');
            
            // Add loading state
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Guardando...';
        });

    
        // Auto-focus on first input
        document.getElementById('numero').focus();

        // Warn before leaving page if there are unsaved changes
        window.addEventListener('beforeunload', function(e) {
            const indicator = document.getElementById('changesIndicator');
            if (indicator.classList.contains('show')) {
                e.preventDefault();
                e.returnValue = '';
                return '';
            }
        });
    </script>
</body>
</html>
