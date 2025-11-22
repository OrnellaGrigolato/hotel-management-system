<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@taglib prefix="c"
uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Gestión de Habitaciones - Sistema de Gestión Hotelera</title>
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
        max-width: 1200px;
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

      .controls-section {
        background: white;
        border-radius: 16px;
        padding: 2rem;
        margin-bottom: 2rem;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
      }

      .filter-container {
        display: flex;
        align-items: center;
        gap: 1rem;
        margin-bottom: 1.5rem;
      }

      .filter-label {
        font-weight: 600;
        color: #2d3748;
        display: flex;
        align-items: center;
        gap: 0.5rem;
      }

      .filter-select {
        padding: 0.75rem 1rem;
        border: 2px solid #e2e8f0;
        border-radius: 8px;
        font-size: 1rem;
        background: white;
        color: #2d3748;
        transition: all 0.3s ease;
        cursor: pointer;
      }

      .filter-select:focus {
        outline: none;
        border-color: #667eea;
        box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
      }

      .action-buttons {
        display: flex;
        gap: 1rem;
        flex-wrap: wrap;
      }

      .btn {
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        padding: 0.75rem 1.5rem;
        border: none;
        border-radius: 8px;
        font-size: 0.95rem;
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

      .rooms-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
        gap: 1.5rem;
        margin-top: 2rem;
      }

      .room-card {
        background: white;
        border-radius: 16px;
        padding: 1.5rem;
        text-decoration: none;
        color: inherit;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        position: relative;
        overflow: hidden;
        border-left: 4px solid transparent;
      }

      .room-card::before {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: linear-gradient(
          135deg,
          rgba(102, 126, 234, 0.05),
          rgba(118, 75, 162, 0.05)
        );
        opacity: 0;
        transition: opacity 0.3s ease;
        z-index: 1;
      }

      .room-card:hover {
        transform: translateY(-8px) scale(1.02);
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        border-left-color: #667eea;
      }

      .room-card:hover::before {
        opacity: 1;
      }

      .room-card > * {
        position: relative;
        z-index: 2;
      }

      .room-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 1rem;
      }

      .room-number {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        font-size: 1.25rem;
        font-weight: 700;
        color: #2d3748;
      }

      .room-type {
        background: linear-gradient(135deg, #667eea, #764ba2);
        color: white;
        padding: 0.25rem 0.75rem;
        border-radius: 20px;
        font-size: 0.8rem;
        font-weight: 500;
        text-transform: capitalize;
      }

      .room-details {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 1rem;
        margin-bottom: 1rem;
      }

      .room-detail {
        display: flex;
        flex-direction: column;
        gap: 0.25rem;
      }

      .room-detail-label {
        font-size: 0.8rem;
        color: #a0aec0;
        font-weight: 500;
        text-transform: uppercase;
        letter-spacing: 0.5px;
      }

      .room-detail-value {
        font-size: 1rem;
        color: #2d3748;
        font-weight: 600;
      }

      .room-price {
        font-size: 1.5rem;
        font-weight: 700;
        background: linear-gradient(135deg, #667eea, #764ba2);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
      }

      .room-actions {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-top: 1rem;
        padding-top: 1rem;
        border-top: 1px solid #e2e8f0;
      }

      .room-id {
        font-size: 0.8rem;
        color: #a0aec0;
      }

      .view-details {
        color: #667eea;
        font-size: 0.9rem;
        font-weight: 500;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        transition: all 0.3s ease;
      }

      .view-details:hover {
        color: #764ba2;
        transform: translateX(2px);
      }

      .empty-state {
        text-align: center;
        padding: 4rem 2rem;
        background: white;
        border-radius: 16px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
      }

      .empty-state i {
        font-size: 4rem;
        color: #e2e8f0;
        margin-bottom: 1rem;
      }

      .empty-state h3 {
        color: #4a5568;
        margin-bottom: 0.5rem;
      }

      .empty-state p {
        color: #a0aec0;
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

        .controls-section {
          padding: 1.5rem;
        }

        .filter-container {
          flex-direction: column;
          align-items: stretch;
        }

        .action-buttons {
          flex-direction: column;
        }

        .rooms-grid {
          grid-template-columns: 1fr;
          gap: 1rem;
        }

        .room-card {
          padding: 1rem;
        }
      }
    </style>
    <script>
      function onTipoChange() {
        const select = document.getElementsByName("tipo")[0];
        const selectedValue = select.value;
        // Agregar estado de carga
        const container = document.querySelector(".rooms-grid");
        container.innerHTML =
          '<div style="text-align: center; padding: 2rem; grid-column: 1 / -1;"><i class="fas fa-spinner fa-spin" style="font-size: 2rem; color: #667eea;"></i><p style="margin-top: 1rem; color: #4a5568;">Cargando habitaciones...</p></div>';

        // Realizar llamada al servlet
        fetch("filtrarHabitaciones/" + selectedValue, {
          method: "GET",
        })
          .then((response) => response.text())
          .then((data) => {
            // Reemplazar el contenido actual de la página con la respuesta
            document.open();
            document.write(data);
            document.getElementById("select").value = selectedValue;
            document.close();
          })
          .catch((error) => {
            console.error("Error:", error);
            container.innerHTML =
              '<div style="text-align: center; padding: 2rem; grid-column: 1 / -1;"><i class="fas fa-exclamation-triangle" style="font-size: 2rem; color: #f56565;"></i><p style="margin-top: 1rem; color: #e53e3e;">Error al cargar las habitaciones</p></div>';
          });
      }
    </script>
  </head>
  <body>
    <div class="container">
      <div class="header">
        <h1>
          <i class="fas fa-bed"></i>
          Gestión de Habitaciones
        </h1>
        <p>Administra el inventario de habitaciones y su disponibilidad</p>
      </div>

      <div class="controls-section">
        <div class="filter-container">
          <label class="filter-label">
            <i class="fas fa-filter"></i>
            Filtrar por tipo:
          </label>
          <select
            name="tipo"
            onchange="onTipoChange()"
            id="select"
            class="filter-select"
          >
            <option value="todos">Todos los tipos</option>
            <option value="simple">Simple</option>
            <option value="doble">Doble</option>
            <option value="suite">Suite</option>
          </select>
        </div>

        <div class="action-buttons">
          <a href="habitacion/nuevo" class="btn btn-primary">
            <i class="fas fa-plus"></i>
            Agregar Nueva Habitación
          </a>
          <a href="home" class="btn btn-secondary">
            <i class="fas fa-home"></i>
            Volver al Inicio
          </a>
        </div>
      </div>

      <div class="rooms-grid">
        <c:choose>
          <c:when test="${not empty habitaciones}">
            <c:forEach var="habitacion" items="${habitaciones}">
              <a
                href="habitacion/${habitacion.numeroDeHabitacion}"
                class="room-card"
              >
                <div class="room-header">
                  <div class="room-number">
                    <i class="fas fa-door-open"></i>
                    Habitación ${habitacion.numeroDeHabitacion}
                  </div>
                  <div class="room-type">${habitacion.tipo}</div>
                </div>

                <div class="room-details">
                  <div class="room-detail">
                    <span class="room-detail-label">Precio por Noche</span>
                    <span class="room-price"
                      >$${habitacion.precioPorNoche}</span
                    >
                  </div>
                  <div class="room-detail">
                    <span class="room-detail-label">Estado</span>
                    <span class="room-detail-value">
                      <i
                        class="fas fa-circle"
                        style="color: ${habitacion.estado eq 'Ocupada' ? '#f56565' : '#48bb78'}; font-size: 0.5rem;"
                      ></i>
                      ${habitacion.estado}
                    </span>
                  </div>
                </div>

                <div class="room-actions">
                  <span class="room-id">ID: ${habitacion.id}</span>
                  <span class="view-details">
                    Ver detalles <i class="fas fa-arrow-right"></i>
                  </span>
                </div>
              </a>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <div class="empty-state" style="grid-column: 1 / -1">
              <i class="fas fa-bed"></i>
              <h3>No hay habitaciones disponibles</h3>
              <p>
                No se encontraron habitaciones que coincidan con los criterios
                de búsqueda
              </p>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </body>
</html>
