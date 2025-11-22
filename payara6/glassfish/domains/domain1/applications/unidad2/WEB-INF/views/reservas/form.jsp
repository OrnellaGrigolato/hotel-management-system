<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nueva Reserva - Hotel Management System</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            min-height: 100vh;
            padding: 2rem;
        }

        .container {
            max-width: 900px;
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
            background: linear-gradient(135deg, #4facfe, #00f2fe);
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
            border-color: #4facfe;
            box-shadow: 0 0 0 3px rgba(79, 172, 254, 0.1);
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

        .form-icon {
            color: #4facfe;
            font-size: 0.9rem;
        }

        .preview-section {
            background: linear-gradient(135deg, rgba(79, 172, 254, 0.05), rgba(0, 242, 254, 0.05));
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            border-left: 4px solid #4facfe;
        }

        .preview-section h3 {
            color: #2d3748;
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .preview-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }

        .preview-item {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }

        .preview-label {
            font-size: 0.75rem;
            color: #a0aec0;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .preview-value {
            font-size: 1rem;
            font-weight: 600;
            color: #2d3748;
        }

        .preview-value.placeholder {
            color: #cbd5e0;
            font-style: italic;
        }

        .preview-price {
            font-size: 1.75rem;
            font-weight: 700;
            background: linear-gradient(135deg, #4facfe, #00f2fe);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .preview-empty {
            text-align: center;
            color: #a0aec0;
            font-style: italic;
            padding: 1rem;
        }

        .date-info {
            background: white;
            border-radius: 8px;
            padding: 1rem;
            margin-top: 1rem;
            display: none;
        }

        .date-info.show {
            display: block;
        }

        .date-info-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1rem;
            text-align: center;
        }

        .date-info-item {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }

        .date-info-label {
            font-size: 0.75rem;
            color: #a0aec0;
            font-weight: 500;
            text-transform: uppercase;
        }

        .date-info-value {
            font-size: 1.25rem;
            font-weight: 700;
            color: #4facfe;
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
            background: linear-gradient(135deg, #4facfe, #00f2fe);
            color: white;
            box-shadow: 0 4px 15px rgba(79, 172, 254, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(79, 172, 254, 0.4);
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

        .navigation-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
        }

        .error-message {
            background: #fed7d7;
            color: #c53030;
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            border: 1px solid #feb2b2;
        }

        .error-message i {
            font-size: 1.1rem;
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

            .preview-grid {
                grid-template-columns: 1fr;
            }

            .date-info-grid {
                grid-template-columns: 1fr;
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
            box-shadow: 0 4px 15px rgba(79, 172, 254, 0.3);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>
                <i class="fas fa-calendar-plus"></i>
                Nueva Reserva
            </h1>
            <p>Crea una nueva reserva para el hotel</p>
        </div>

        <div class="form-card">
            <div class="form-header">
                <h2>
                    <i class="fas fa-ticket-alt"></i>
                    Información de la Reserva
                </h2>
                <p>Completa todos los campos para registrar la nueva reserva</p>
            </div>

            <div class="preview-section" id="previewSection">
                <h3>
                    <i class="fas fa-eye"></i>
                    Vista Previa de la Reserva
                </h3>
                <div class="preview-grid">
                    <div class="preview-item">
                        <span class="preview-label">Habitación</span>
                        <span class="preview-value placeholder" id="previewRoom">No seleccionada</span>
                    </div>
                    <div class="preview-item">
                        <span class="preview-label">Huésped</span>
                        <span class="preview-value placeholder" id="previewGuest">No seleccionado</span>
                    </div>
                    <div class="preview-item">
                        <span class="preview-label">Check-in</span>
                        <span class="preview-value placeholder" id="previewCheckIn">No definido</span>
                    </div>
                    <div class="preview-item">
                        <span class="preview-label">Check-out</span>
                        <span class="preview-value placeholder" id="previewCheckOut">No definido</span>
                    </div>
                </div>
                <div class="date-info" id="dateInfo">
                    <div class="date-info-grid">
                        <div class="date-info-item">
                            <span class="date-info-label">Noches</span>
                            <span class="date-info-value" id="totalNights">0</span>
                        </div>
                        <div class="date-info-item">
                            <span class="date-info-label">Precio/Noche</span>
                            <span class="date-info-value" id="pricePerNight">$0</span>
                        </div>
                        <div class="date-info-item">
                            <span class="date-info-label">Total</span>
                            <span class="preview-price" id="totalPrice">$0</span>
                        </div>
                    </div>
                </div>
            </div>

            <c:if test="${not empty error}">
                <div class="error-message">
                    <i class="fas fa-exclamation-triangle"></i>
                    <span>${error}</span>
                </div>
            </c:if>

            <form method="post" action="${mvc.uri('guardarReserva')}" id="reservationForm">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="idHabitacion" class="form-label">
                            <i class="fas fa-door-open form-icon"></i>
                            Habitación
                            <span class="required">*</span>
                        </label>
                        <select id="idHabitacion" name="idHabitacion" class="form-select" required onchange="updatePreview()">
                            <option value="">Seleccione una habitación</option>
                            <c:forEach var="habitacion" items="${habitaciones}">
                                <option value="${habitacion.id}" 
                                        data-number="${habitacion.numeroDeHabitacion}"
                                        data-type="${habitacion.tipo}"
                                        data-price="${habitacion.precioPorNoche}"
                                        ${idHabitacion == habitacion.id ? 'selected' : ''}>
                                    Habitación ${habitacion.numeroDeHabitacion} - ${habitacion.tipo} ($${habitacion.precioPorNoche}/noche)
                                </option>
                            </c:forEach>
                        </select>
                        <span class="input-hint">Selecciona la habitación a reservar</span>
                    </div>

                    <div class="form-group">
                        <label for="idHuesped" class="form-label">
                            <i class="fas fa-user form-icon"></i>
                            Huésped
                            <span class="required">*</span>
                        </label>
                        <select id="idHuesped" name="idHuesped" class="form-select" required onchange="updatePreview()">
                            <option value="">Seleccione un huésped</option>
                            <c:forEach var="huesped" items="${huespedes}">
                                <option value="${huesped.id}"
                                        data-name="${huesped.nombre}"
                                        data-doc="${huesped.documento}"
                                        ${idHuesped == huesped.id ? 'selected' : ''}>
                                    ${huesped.nombre} - Doc: ${huesped.documento}
                                </option>
                            </c:forEach>
                        </select>
                        <span class="input-hint">Selecciona el huésped que realizará la reserva</span>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="fechaDeEntrada" class="form-label">
                                <i class="fas fa-sign-in-alt form-icon"></i>
                                Fecha de Entrada (Check-in)
                                <span class="required">*</span>
                            </label>
                            <input 
                                type="date" 
                                id="fechaDeEntrada"
                                name="fechaDeEntrada" 
                                class="form-input"
                                value="${fechaDeEntrada}"
                                required
                                onchange="updatePreview()"
                            >
                            <span class="input-hint">Fecha de llegada al hotel</span>
                        </div>

                        <div class="form-group">
                            <label for="fechaDeSalida" class="form-label">
                                <i class="fas fa-sign-out-alt form-icon"></i>
                                Fecha de Salida (Check-out)
                                <span class="required">*</span>
                            </label>
                            <input 
                                type="date" 
                                id="fechaDeSalida"
                                name="fechaDeSalida" 
                                class="form-input"
                                value="${fechaDeSalida}"
                                required
                                onchange="updatePreview()"
                            >
                            <span class="input-hint">Fecha de salida del hotel</span>
                        </div>
                    </div>
                </div>

                <div class="form-actions">
                    <a href="${mvc.uri('listadoReservas')}" class="btn btn-secondary">
                        <i class="fas fa-times"></i>
                        Cancelar
                    </a>
                    <button type="submit" class="btn btn-primary" id="submitBtn">
                        <i class="fas fa-save"></i>
                        Guardar Reserva
                    </button>
                </div>
            </form>
        </div>

        <div class="navigation-buttons">
            <a href="${mvc.uri('listadoReservas')}" class="btn btn-secondary">
                <i class="fas fa-list"></i>
                Ver Todas las Reservas
            </a>
            <a href="../home" class="btn btn-secondary">
                <i class="fas fa-home"></i>
                Volver al Inicio
            </a>
        </div>
    </div>

    <script>
        // Set minimum dates
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('fechaDeEntrada').min = today;
        document.getElementById('fechaDeSalida').min = today;

        // Update minimum checkout date when check-in changes
        document.getElementById('fechaDeEntrada').addEventListener('change', function() {
            const checkInDate = this.value;
            const checkOutInput = document.getElementById('fechaDeSalida');
            
            if (checkInDate) {
                // Set minimum checkout date to the day after check-in
                const nextDay = new Date(checkInDate);
                nextDay.setDate(nextDay.getDate() + 1);
                checkOutInput.min = nextDay.toISOString().split('T')[0];
                
                // If checkout is before new minimum, clear it
                if (checkOutInput.value && checkOutInput.value <= checkInDate) {
                    checkOutInput.value = '';
                }
            }
        });

        // Calculate nights between dates
        function calculateNights(checkIn, checkOut) {
            if (!checkIn || !checkOut) return 0;
            
            const date1 = new Date(checkIn);
            const date2 = new Date(checkOut);
            const diffTime = Math.abs(date2 - date1);
            const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
            
            return diffDays;
        }

        // Update preview with selected values
        function updatePreview() {
            // Get room info
            const roomSelect = document.getElementById('idHabitacion');
            const roomOption = roomSelect.options[roomSelect.selectedIndex];
            const roomNumber = roomOption.dataset.number || '';
            const roomType = roomOption.dataset.type || '';
            const roomPrice = parseFloat(roomOption.dataset.price) || 0;
            console.log(roomNumber);
            
            // Get guest info
            const guestSelect = document.getElementById('idHuesped');
            const guestOption = guestSelect.options[guestSelect.selectedIndex];
            const guestName = guestOption.dataset.name || '';

            // Get dates
            const checkIn = document.getElementById('fechaDeEntrada').value;
            const checkOut = document.getElementById('fechaDeSalida').value;

            // Update preview room
            const previewRoom = document.getElementById('previewRoom');
            if (roomNumber) {
                previewRoom.textContent = "Hab. " + roomNumber + " (" + roomType + ")";
                previewRoom.classList.remove('placeholder');
            } else {
                previewRoom.textContent = 'No seleccionada';
                previewRoom.classList.add('placeholder');
            }

            // Update preview guest
            const previewGuest = document.getElementById('previewGuest');
            if (guestName) {
                previewGuest.textContent = guestName;
                previewGuest.classList.remove('placeholder');
            } else {
                previewGuest.textContent = 'No seleccionado';
                previewGuest.classList.add('placeholder');
            }

            // Update preview check-in
            const previewCheckIn = document.getElementById('previewCheckIn');
            if (checkIn) {
                previewCheckIn.textContent = checkIn;
                previewCheckIn.classList.remove('placeholder');
            } else {
                previewCheckIn.textContent = 'No definido';
                previewCheckIn.classList.add('placeholder');
            }

            // Update preview check-out
            const previewCheckOut = document.getElementById('previewCheckOut');
            if (checkOut) {
                previewCheckOut.textContent = checkOut;
                previewCheckOut.classList.remove('placeholder');
            } else {
                previewCheckOut.textContent = 'No definido';
                previewCheckOut.classList.add('placeholder');
            }

            // Calculate and show pricing
            if (checkIn && checkOut && roomPrice > 0) {
                const nights = calculateNights(checkIn, checkOut);
                const total = nights * roomPrice;

                document.getElementById('totalNights').textContent = nights;
                document.getElementById('pricePerNight').textContent = '$' + roomPrice.toFixed(2);
                document.getElementById('totalPrice').textContent = '$' + total.toFixed(2);
                document.getElementById('dateInfo').classList.add('show');
            } else {
                document.getElementById('dateInfo').classList.remove('show');
            }
        }

        // Form submission handling
        document.getElementById('reservationForm').addEventListener('submit', function(e) {
            const checkIn = document.getElementById('fechaDeEntrada').value;
            const checkOut = document.getElementById('fechaDeSalida').value;

            // Validate dates
            if (checkIn && checkOut && checkIn >= checkOut) {
                e.preventDefault();
                alert('La fecha de salida debe ser posterior a la fecha de entrada.');
                return;
            }

            const submitBtn = document.getElementById('submitBtn');
            
            // Add loading state
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Guardando...';
        });

        // Auto-focus on first select
        document.getElementById('idHabitacion').focus();

        // Initial preview update if there are pre-selected values
        updatePreview();
    </script>
</body>
</html>
