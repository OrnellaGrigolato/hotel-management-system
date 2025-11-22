<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@taglib prefix="c"
uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Habitación ${h.numeroDeHabitacion} - Hotel Management System</title>
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
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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

      .room-profile {
        background: white;
        border-radius: 16px;
        overflow: hidden;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        margin-bottom: 2rem;
      }

      .room-header {
        background: linear-gradient(135deg, #667eea, #764ba2);
        color: white;
        padding: 2rem;
        text-align: center;
        position: relative;
      }

      .room-header::before {
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

      .room-header:hover::before {
        opacity: 1;
      }

      .room-number {
        font-size: 3rem;
        font-weight: 700;
        margin-bottom: 0.5rem;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
      }

      .room-type {
        font-size: 1.25rem;
        font-weight: 500;
        opacity: 0.9;
        text-transform: capitalize;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
      }

      .room-content {
        padding: 2.5rem;
      }

      .room-details {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 2rem;
        margin-bottom: 2rem;
      }

      .detail-card {
        background: #f7fafc;
        border-radius: 12px;
        padding: 1.5rem;
        border-left: 4px solid #667eea;
        transition: all 0.3s ease;
      }

      .detail-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        border-left-color: #764ba2;
      }

      .detail-header {
        display: flex;
        align-items: center;
        gap: 0.75rem;
        margin-bottom: 1rem;
      }

      .detail-icon {
        width: 40px;
        height: 40px;
        background: linear-gradient(135deg, #667eea, #764ba2);
        color: white;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.1rem;
      }

      .detail-title {
        font-weight: 600;
        color: #2d3748;
        font-size: 1rem;
      }

      .detail-value {
        font-size: 1.5rem;
        font-weight: 700;
        color: #2d3748;
      }

      .price-value {
        color: #667eea;
        background: linear-gradient(135deg, #667eea, #764ba2);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
      }

      .status-indicator {
        display: flex;
        align-items: center;
        gap: 0.5rem;
      }

      .status-dot {
        width: 12px;
        height: 12px;
        border-radius: 50%;
      }

      .status-dot.disponible {
        background: #48bb78;
        animation: pulse 2s infinite;
      }

      .status-dot.ocupada {
        background: #e53e3e;
      }

      @keyframes pulse {
        0% {
          box-shadow: 0 0 0 0 rgba(72, 187, 120, 0.7);
        }
        70% {
          box-shadow: 0 0 0 10px rgba(72, 187, 120, 0);
        }
        100% {
          box-shadow: 0 0 0 0 rgba(72, 187, 120, 0);
        }
      }

      .room-info {
        background: linear-gradient(
          135deg,
          rgba(102, 126, 234, 0.05),
          rgba(118, 75, 162, 0.05)
        );
        border-radius: 12px;
        padding: 1.5rem;
        margin-bottom: 2rem;
      }

      .room-info h3 {
        color: #2d3748;
        font-size: 1.25rem;
        font-weight: 600;
        margin-bottom: 1rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
      }

      .info-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 1rem;
      }

      .info-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0.75rem 0;
        border-bottom: 1px solid rgba(102, 126, 234, 0.1);
      }

      .info-item:last-child {
        border-bottom: none;
      }

      .info-label {
        font-weight: 500;
        color: #4a5568;
      }

      .info-value {
        font-weight: 600;
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
        background: linear-gradient(135deg, #667eea, #764ba2);
        color: white;
        box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
      }

      .btn-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
      }

      .btn-warning {
        background: linear-gradient(135deg, #ed8936, #dd6b20);
        color: white;
        box-shadow: 0 4px 15px rgba(237, 137, 54, 0.3);
      }

      .btn-warning:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(237, 137, 54, 0.4);
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
        max-width: 400px;
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

        .room-header {
          padding: 1.5rem;
        }

        .room-number {
          font-size: 2rem;
        }

        .room-content {
          padding: 1.5rem;
        }

        .room-details {
          grid-template-columns: 1fr;
          gap: 1rem;
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
          <i class="fas fa-door-open"></i>
          Habitación ${h.numeroDeHabitacion}
        </h1>
        <p>Información detallada y gestión de la habitación</p>
      </div>

      <div class="room-profile">
        <div class="room-header">
          <div class="room-number">
            <i class="fas fa-bed"></i> ${h.numeroDeHabitacion}
          </div>
          <div class="room-type">
            <i class="fas fa-tag"></i>
            ${h.tipo}
          </div>
        </div>

        <div class="room-content">
          <div class="room-details">
            <div class="detail-card">
              <div class="detail-header">
                <div class="detail-icon">
                  <i class="fas fa-hashtag"></i>
                </div>
                <div class="detail-title">ID del Sistema</div>
              </div>
              <div class="detail-value">#${h.id}</div>
            </div>

            <div class="detail-card">
              <div class="detail-header">
                <div class="detail-icon">
                  <i class="fas fa-dollar-sign"></i>
                </div>
                <div class="detail-title">Precio por Noche</div>
              </div>
              <div class="detail-value price-value">$${h.precioPorNoche}</div>
            </div>

            <div class="detail-card">
              <div class="detail-header">
                <div class="detail-icon">
                  <i class="fas fa-check-circle"></i>
                </div>
                <div class="detail-title">Estado Actual</div>
              </div>
              <div class="detail-value">
                <div class="status-indicator">
                  <div class="status-dot ${h.estado.toLowerCase()}"></div>
                  <span>${h.estado}</span>
                </div>
              </div>
            </div>
          </div>

          <div class="room-info">
            <h3>
              <i class="fas fa-info-circle"></i>
              Información Adicional
            </h3>
            <div class="info-grid">
              <div class="info-item">
                <span class="info-label">Número de Habitación:</span>
                <span class="info-value">${h.numeroDeHabitacion}</span>
              </div>
              <div class="info-item">
                <span class="info-label">Categoría:</span>
                <span class="info-value">${h.tipo}</span>
              </div>
              <div class="info-item">
                <span class="info-label">Tarifa Diaria:</span>
                <span class="info-value">$${h.precioPorNoche}</span>
              </div>
              <div class="info-item">
                <span class="info-label">Estado:</span>
                <span class="info-value">${h.estado}</span>
              </div>
            </div>
          </div>

          <div class="action-section">
            <div class="action-header">
              <h3>Gestión de Habitación</h3>
              <p>Realiza acciones sobre esta habitación</p>
            </div>

            <div class="action-buttons">
              <a
                href="${mvc.uri('editarHabitacion',{'id': h.id, 'tipo': h.tipo, 'precioPorNoche': h.precioPorNoche, 'numeroDeHabitacion': h.numeroDeHabitacion})}"
                class="btn btn-primary"
              >
                <i class="fas fa-edit"></i>
                Editar Habitación
              </a>

              <button onclick="showDeleteModal()" class="btn btn-danger">
                <i class="fas fa-trash-alt"></i>
                Eliminar Habitación
              </button>
            </div>
          </div>
        </div>
      </div>

      <div class="navigation-section">
        <a href="${mvc.uri('listadoHabitaciones')}" class="btn btn-secondary">
          <i class="fas fa-arrow-left"></i>
          Volver a la Lista
        </a>
        <a href="../home" class="btn btn-secondary">
          <i class="fas fa-home"></i>
          Ir al Inicio
        </a>
      </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal-overlay" id="deleteModal">
      <div class="modal">
        <i
          class="fas fa-exclamation-triangle"
          style="font-size: 3rem; color: #e53e3e; margin-bottom: 1rem"
        ></i>
        <h3>¿Eliminar Habitación?</h3>
        <p>
          Esta acción no se puede deshacer. La habitación
          ${h.numeroDeHabitacion} será eliminada permanentemente del sistema.
        </p>
        <div class="modal-actions">
          <button onclick="hideDeleteModal()" class="btn btn-secondary">
            <i class="fas fa-times"></i>
            Cancelar
          </button>
          <a
            href="${mvc.uri('AppController#eliminarHabitacion',{'id': h.id})}"
            class="btn btn-danger"
          >
            <i class="fas fa-trash-alt"></i>
            Sí, Eliminar
          </a>
        </div>
      </div>
    </div>

    <script>
      function showDeleteModal() {
        document.getElementById("deleteModal").style.display = "flex";
        document.body.style.overflow = "hidden";
      }

      function hideDeleteModal() {
        document.getElementById("deleteModal").style.display = "none";
        document.body.style.overflow = "auto";
      }

      // Close modal when clicking outside
      document
        .getElementById("deleteModal")
        .addEventListener("click", function (e) {
          if (e.target === this) {
            hideDeleteModal();
          }
        });

      // Close modal with Escape key
      document.addEventListener("keydown", function (e) {
        if (e.key === "Escape") {
          hideDeleteModal();
        }
      });
    </script>
  </body>
</html>
