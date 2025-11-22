<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@taglib prefix="c"
uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Reserva #${r.id} - Sistema de Gestión Hotelera</title>
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
      rel="stylesheet"
    />
    <style>
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      body {
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        min-height: 100vh;
        padding: 2rem;
      }

      .container {
        max-width: 1000px;
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
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 1rem;
      }

      .header p {
        color: rgba(255, 255, 255, 0.9);
        font-size: 1.1rem;
        font-weight: 300;
      }

      .reservation-profile {
        background: white;
        border-radius: 16px;
        overflow: hidden;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        margin-bottom: 2rem;
      }

      .reservation-header {
        background: linear-gradient(135deg, #4facfe, #00f2fe);
        color: white;
        padding: 2.5rem;
        text-align: center;
        position: relative;
      }

      .reservation-header::before {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: rgba(255, 255, 255, 0.1);
        opacity: 0;
        transition: opacity 0.3s ease;
      }

      .reservation-header:hover::before {
        opacity: 1;
      }

      .reservation-id {
        font-size: 3rem;
        font-weight: 700;
        margin-bottom: 0.5rem;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
      }

      .reservation-subtitle {
        font-size: 1.25rem;
        font-weight: 500;
        opacity: 0.9;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
      }

      .reservation-content {
        padding: 2.5rem;
      }

      .main-info-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        gap: 1.5rem;
        margin-bottom: 2rem;
      }

      .info-card {
        background: #f7fafc;
        border-radius: 12px;
        padding: 1.5rem;
        border-left: 4px solid #4facfe;
        transition: all 0.3s ease;
      }

      .info-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        border-left-color: #00f2fe;
      }

      .info-card-header {
        display: flex;
        align-items: center;
        gap: 0.75rem;
        margin-bottom: 1rem;
      }

      .info-icon {
        width: 45px;
        height: 45px;
        background: linear-gradient(135deg, #4facfe, #00f2fe);
        color: white;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.2rem;
      }

      .info-title {
        font-weight: 600;
        color: #2d3748;
        font-size: 1rem;
      }

      .info-value {
        font-size: 1.5rem;
        font-weight: 700;
        color: #2d3748;
      }

      .info-subtitle {
        font-size: 0.9rem;
        color: #718096;
        margin-top: 0.25rem;
      }

      .price-value {
        color: #4facfe;
        background: linear-gradient(135deg, #4facfe, #00f2fe);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        font-size: 2rem;
      }

      .room-type-badge {
        display: inline-block;
        padding: 0.5rem 1rem;
        border-radius: 20px;
        font-size: 0.9rem;
        font-weight: 600;
        text-transform: capitalize;
        margin-top: 0.5rem;
      }

      .badge-simple {
        background: linear-gradient(
          135deg,
          rgba(79, 172, 254, 0.15),
          rgba(0, 242, 254, 0.15)
        );
        color: #0891b2;
      }

      .badge-doble {
        background: linear-gradient(
          135deg,
          rgba(79, 172, 254, 0.2),
          rgba(0, 242, 254, 0.2)
        );
        color: #0e7490;
      }

      .badge-suite {
        background: linear-gradient(135deg, #4facfe, #00f2fe);
        color: white;
      }

      .dates-section {
        background: linear-gradient(
          135deg,
          rgba(79, 172, 254, 0.05),
          rgba(0, 242, 254, 0.05)
        );
        border-radius: 12px;
        padding: 2rem;
        margin-bottom: 2rem;
      }

      .dates-header {
        text-align: center;
        margin-bottom: 1.5rem;
      }

      .dates-header h3 {
        color: #2d3748;
        font-size: 1.25rem;
        font-weight: 600;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
      }

      .dates-timeline {
        display: grid;
        grid-template-columns: 1fr auto 1fr;
        gap: 1.5rem;
        align-items: center;
      }

      .date-box {
        background: white;
        border-radius: 12px;
        padding: 1.5rem;
        text-align: center;
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
        transition: all 0.3s ease;
      }

      .date-box:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
      }

      .date-label {
        font-size: 0.8rem;
        color: #a0aec0;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        margin-bottom: 0.5rem;
      }

      .date-value {
        font-size: 1.5rem;
        font-weight: 700;
        color: #2d3748;
        margin-bottom: 0.25rem;
      }

      .date-icon {
        font-size: 2rem;
        margin-bottom: 0.5rem;
      }

      .check-in-icon {
        color: #48bb78;
      }

      .check-out-icon {
        color: #f56565;
      }

      .timeline-separator {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 0.5rem;
      }

      .timeline-line {
        width: 2px;
        height: 40px;
        background: linear-gradient(180deg, #4facfe, #00f2fe);
      }

      .timeline-arrow {
        font-size: 1.5rem;
        color: #4facfe;
      }

      .details-section {
        background: #f7fafc;
        border-radius: 12px;
        padding: 2rem;
        margin-bottom: 2rem;
      }

      .details-header {
        margin-bottom: 1.5rem;
      }

      .details-header h3 {
        color: #2d3748;
        font-size: 1.25rem;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 0.5rem;
      }

      .details-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 1rem;
      }

      .detail-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 1rem;
        background: white;
        border-radius: 8px;
        border-left: 3px solid #4facfe;
      }

      .detail-label {
        font-weight: 500;
        color: #4a5568;
        display: flex;
        align-items: center;
        gap: 0.5rem;
      }

      .detail-label i {
        color: #4facfe;
        font-size: 0.9rem;
      }

      .detail-value {
        font-weight: 700;
        color: #2d3748;
      }

      .action-section {
        background: #f7fafc;
        border-radius: 12px;
        padding: 2rem;
        margin-top: 2rem;
      }

      .action-header {
        text-align: center;
        margin-bottom: 2rem;
      }

      .action-header h3 {
        color: #2d3748;
        font-size: 1.25rem;
        font-weight: 600;
        margin-bottom: 0.5rem;
      }

      .action-header p {
        color: #718096;
        font-size: 1rem;
      }

      .action-buttons {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 1rem;
      }

      .btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 0.75rem;
        padding: 1rem 1.5rem;
        border: none;
        border-radius: 8px;
        font-size: 1rem;
        font-weight: 500;
        text-decoration: none;
        cursor: pointer;
        transition: all 0.3s ease;
        text-align: center;
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

      .btn-danger {
        background: linear-gradient(135deg, #e53e3e, #c53030);
        color: white;
        box-shadow: 0 4px 15px rgba(229, 62, 62, 0.3);
      }

      .btn-danger:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(229, 62, 62, 0.4);
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

      .navigation-section {
        display: flex;
        justify-content: center;
        gap: 1rem;
        margin-top: 2rem;
        flex-wrap: wrap;
      }

      .modal-overlay {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: rgba(0, 0, 0, 0.5);
        z-index: 1000;
        align-items: center;
        justify-content: center;
        backdrop-filter: blur(4px);
      }

      .modal {
        background: white;
        border-radius: 16px;
        padding: 2rem;
        max-width: 450px;
        width: 90%;
        text-align: center;
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
      }

      .modal h3 {
        color: #2d3748;
        font-size: 1.5rem;
        margin-bottom: 1rem;
      }

      .modal p {
        color: #718096;
        margin-bottom: 2rem;
        line-height: 1.5;
      }

      .modal-actions {
        display: flex;
        gap: 1rem;
        justify-content: center;
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

        .reservation-header {
          padding: 1.5rem;
        }

        .reservation-id {
          font-size: 2rem;
        }

        .reservation-content {
          padding: 1.5rem;
        }

        .main-info-grid {
          grid-template-columns: 1fr;
        }

        .dates-timeline {
          grid-template-columns: 1fr;
          gap: 1rem;
        }

        .timeline-separator {
          flex-direction: row;
          justify-content: center;
        }

        .timeline-line {
          width: 40px;
          height: 2px;
        }

        .timeline-arrow {
          transform: rotate(90deg);
        }

        .action-buttons {
          grid-template-columns: 1fr;
        }

        .navigation-section {
          flex-direction: column;
        }
      }
    </style>
  </head>
  <body>
    <div class="container">
      <div class="header">
        <h1>
          <i class="fas fa-calendar-check"></i>
          Reserva #${r.id}
        </h1>
        <p>Información detallada de la reserva y gestión</p>
      </div>

      <div class="reservation-profile">
        <div class="reservation-header">
          <div class="reservation-id">
            <i class="fas fa-ticket-alt"></i> #${r.id}
          </div>
          <div class="reservation-subtitle">
            <i class="fas fa-calendar"></i>
            Reserva Confirmada
          </div>
        </div>

        <div class="reservation-content">
          <div class="main-info-grid">
            <div class="info-card">
              <div class="info-card-header">
                <div class="info-icon">
                  <i class="fas fa-door-open"></i>
                </div>
                <div class="info-title">Habitación</div>
              </div>
              <div class="info-value">${r.habitacion.numeroDeHabitacion}</div>
              <div class="room-type-badge badge-${r.habitacion.tipo}">
                ${r.habitacion.tipo}
              </div>
            </div>

            <div class="info-card">
              <div class="info-card-header">
                <div class="info-icon">
                  <i class="fas fa-user"></i>
                </div>
                <div class="info-title">Huésped</div>
              </div>
              <div class="info-value">${r.huesped.nombre}</div>
              <div class="info-subtitle">
                <i class="fas fa-id-card"></i> Doc: ${r.huesped.documento}
              </div>
            </div>

            <div class="info-card">
              <div class="info-card-header">
                <div class="info-icon">
                  <i class="fas fa-dollar-sign"></i>
                </div>
                <div class="info-title">Precio Total</div>
              </div>
              <div class="price-value">$${r.precioTotal}</div>
              <div class="info-subtitle">Precio completo de la estadía</div>
            </div>
          </div>

          <div class="dates-section">
            <div class="dates-header">
              <h3>
                <i class="fas fa-calendar-alt"></i>
                Período de Estadía
              </h3>
            </div>
            <div class="dates-timeline">
              <div class="date-box">
                <div class="date-icon check-in-icon">
                  <i class="fas fa-sign-in-alt"></i>
                </div>
                <div class="date-label">Check-in</div>
                <div class="date-value">${r.fechaDeEntrada}</div>
              </div>

              <div class="timeline-separator">
                <div class="timeline-line"></div>
                <div class="timeline-arrow">
                  <i class="fas fa-arrow-right"></i>
                </div>
                <div class="timeline-line"></div>
              </div>

              <div class="date-box">
                <div class="date-icon check-out-icon">
                  <i class="fas fa-sign-out-alt"></i>
                </div>
                <div class="date-label">Check-out</div>
                <div class="date-value">${r.fechaDeSalida}</div>
              </div>
            </div>
          </div>

          <div class="details-section">
            <div class="details-header">
              <h3>
                <i class="fas fa-info-circle"></i>
                Detalles de la Reserva
              </h3>
            </div>
            <div class="details-grid">
              <div class="detail-item">
                <span class="detail-label">
                  <i class="fas fa-hashtag"></i>
                  ID de Reserva
                </span>
                <span class="detail-value">#${r.id}</span>
              </div>
              <div class="detail-item">
                <span class="detail-label">
                  <i class="fas fa-bed"></i>
                  Número de Habitación
                </span>
                <span class="detail-value"
                  >${r.habitacion.numeroDeHabitacion}</span
                >
              </div>
              <div class="detail-item">
                <span class="detail-label">
                  <i class="fas fa-tag"></i>
                  Tipo de Habitación
                </span>
                <span class="detail-value">${r.habitacion.tipo}</span>
              </div>
              <div class="detail-item">
                <span class="detail-label">
                  <i class="fas fa-user-circle"></i>
                  Huésped
                </span>
                <span class="detail-value">${r.huesped.nombre}</span>
              </div>
              <div class="detail-item">
                <span class="detail-label">
                  <i class="fas fa-calendar-plus"></i>
                  Fecha de Entrada
                </span>
                <span class="detail-value">${r.fechaDeEntrada}</span>
              </div>
              <div class="detail-item">
                <span class="detail-label">
                  <i class="fas fa-calendar-minus"></i>
                  Fecha de Salida
                </span>
                <span class="detail-value">${r.fechaDeSalida}</span>
              </div>
            </div>
          </div>

          <div class="action-section">
            <div class="action-header">
              <h3>Gestión de Reserva</h3>
              <p>Realiza acciones sobre esta reserva</p>
            </div>

            <div class="action-buttons">
              <button onclick="showCancelModal()" class="btn btn-danger">
                <i class="fas fa-times-circle"></i>
                Cancelar Reserva
              </button>
            </div>
          </div>
        </div>
      </div>

      <div class="navigation-section">
        <a href="${mvc.uri('listadoReservas')}" class="btn btn-secondary">
          <i class="fas fa-arrow-left"></i>
          Volver a la Lista
        </a>
        <a
          href="../habitacion/${r.habitacion.numeroDeHabitacion}"
          class="btn btn-secondary"
        >
          <i class="fas fa-door-open"></i>
          Ver Habitación
        </a>
        <a href="../huesped/${r.huesped.id}" class="btn btn-secondary">
          <i class="fas fa-user"></i>
          Ver Huésped
        </a>
        <a href="../home" class="btn btn-secondary">
          <i class="fas fa-home"></i>
          Ir al Inicio
        </a>
      </div>
    </div>

    <!-- Cancel Modal -->
    <div class="modal-overlay" id="cancelModal">
      <div class="modal">
        <i
          class="fas fa-exclamation-triangle"
          style="font-size: 3rem; color: #e53e3e; margin-bottom: 1rem"
        ></i>
        <h3>¿Cancelar Reserva?</h3>
        <p>
          Esta acción no se puede deshacer. La reserva #${r.id} será cancelada
          permanentemente y la habitación ${r.habitacion.numeroDeHabitacion}
          quedará disponible nuevamente.
        </p>
        <div class="modal-actions">
          <button onclick="hideCancelModal()" class="btn btn-secondary">
            <i class="fas fa-times"></i>
            No, Mantener
          </button>
          <a
            href="${mvc.uri('eliminarReserva',{'id': r.id})}"
            class="btn btn-danger"
          >
            <i class="fas fa-times-circle"></i>
            Sí, Cancelar Reserva
          </a>
        </div>
      </div>
    </div>

    <script>
      function showCancelModal() {
        document.getElementById("cancelModal").style.display = "flex";
        document.body.style.overflow = "hidden";
      }

      function hideCancelModal() {
        document.getElementById("cancelModal").style.display = "none";
        document.body.style.overflow = "auto";
      }

      // Cerrar el modal al hacer clic fuera del modal
      document
        .getElementById("cancelModal")
        .addEventListener("click", function (e) {
          if (e.target === this) {
            hideCancelModal();
          }
        });

      // Cerrar el modal con la tecla Escape
      document.addEventListener("keydown", function (e) {
        if (e.key === "Escape") {
          hideCancelModal();
        }
      });
    </script>
  </body>
</html>
