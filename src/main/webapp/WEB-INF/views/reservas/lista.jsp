<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@taglib prefix="c"
uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Gestión de Reservas - Hotel Management System</title>
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
        max-width: 1400px;
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

      .filters-container {
        display: grid;
        gap: 1.5rem;
        margin-bottom: 1.5rem;
      }

      .filter-group {
        display: flex;
        flex-direction: column;
        gap: 0.75rem;
      }

      .filter-label {
        font-weight: 600;
        color: #2d3748;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        font-size: 0.95rem;
      }

      .filter-label i {
        color: #4facfe;
      }

      .filter-select,
      .filter-input {
        padding: 0.75rem 1rem;
        border: 2px solid #e2e8f0;
        border-radius: 8px;
        font-size: 1rem;
        background: white;
        color: #2d3748;
        transition: all 0.3s ease;
        font-family: inherit;
      }

      .filter-select {
        cursor: pointer;
        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='m6 8 4 4 4-4'/%3e%3c/svg%3e");
        background-position: right 0.75rem center;
        background-repeat: no-repeat;
        background-size: 1.25rem;
        padding-right: 3rem;
        appearance: none;
      }

      .filter-select:focus,
      .filter-input:focus {
        outline: none;
        border-color: #4facfe;
        box-shadow: 0 0 0 3px rgba(79, 172, 254, 0.1);
      }

      .date-filter-row {
        display: grid;
        grid-template-columns: 1fr 1fr auto;
        gap: 1rem;
        align-items: end;
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

      .btn-clear {
        background: #fff5f5;
        color: #c53030;
        border: 2px solid #feb2b2;
      }

      .btn-clear:hover {
        background: #fed7d7;
        border-color: #fc8181;
      }

      .stats-section {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 1rem;
        margin-bottom: 2rem;
      }

      .stat-card {
        background: white;
        border-radius: 12px;
        padding: 1.5rem;
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
        display: flex;
        align-items: center;
        gap: 1rem;
      }

      .stat-icon {
        width: 50px;
        height: 50px;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.5rem;
        background: linear-gradient(
          135deg,
          rgba(79, 172, 254, 0.1),
          rgba(0, 242, 254, 0.1)
        );
        color: #4facfe;
      }

      .stat-info {
        flex: 1;
      }

      .stat-label {
        font-size: 0.8rem;
        color: #a0aec0;
        font-weight: 500;
        text-transform: uppercase;
        letter-spacing: 0.5px;
      }

      .stat-value {
        font-size: 1.75rem;
        font-weight: 700;
        color: #2d3748;
      }

      .reservations-grid {
        display: grid;
        gap: 1rem;
      }

      .reservation-card {
        background: white;
        border-radius: 16px;
        padding: 1.5rem;
        text-decoration: none;
        color: inherit;
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
        transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        position: relative;
        overflow: hidden;
        border-left: 4px solid transparent;
        display: grid;
        grid-template-columns: auto 1fr auto;
        gap: 1.5rem;
        align-items: center;
      }

      .reservation-card::before {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: linear-gradient(
          135deg,
          rgba(79, 172, 254, 0.05),
          rgba(0, 242, 254, 0.05)
        );
        opacity: 0;
        transition: opacity 0.3s ease;
        z-index: 1;
      }

      .reservation-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 12px 32px rgba(0, 0, 0, 0.12);
        border-left-color: #4facfe;
      }

      .reservation-card:hover::before {
        opacity: 1;
      }

      .reservation-card > * {
        position: relative;
        z-index: 2;
      }

      .reservation-icon {
        width: 60px;
        height: 60px;
        border-radius: 12px;
        background: linear-gradient(135deg, #4facfe, #00f2fe);
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 1.5rem;
        flex-shrink: 0;
      }

      .reservation-content {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
        gap: 1rem;
      }

      .reservation-info {
        display: flex;
        flex-direction: column;
        gap: 0.25rem;
      }

      .reservation-label {
        font-size: 0.75rem;
        color: #a0aec0;
        font-weight: 500;
        text-transform: uppercase;
        letter-spacing: 0.5px;
      }

      .reservation-value {
        font-size: 1rem;
        color: #2d3748;
        font-weight: 600;
      }

      .reservation-badge {
        padding: 0.25rem 0.75rem;
        border-radius: 20px;
        font-size: 0.8rem;
        font-weight: 500;
        text-transform: capitalize;
        display: inline-block;
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

      .reservation-actions {
        display: flex;
        flex-direction: column;
        align-items: flex-end;
        gap: 0.5rem;
      }

      .reservation-price {
        font-size: 1.5rem;
        font-weight: 700;
        background: linear-gradient(135deg, #4facfe, #00f2fe);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
      }

      .reservation-id {
        font-size: 0.75rem;
        color: #a0aec0;
      }

      .view-details {
        color: #4facfe;
        font-size: 0.9rem;
        font-weight: 500;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        transition: all 0.3s ease;
      }

      .view-details:hover {
        color: #00f2fe;
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
        font-size: 1.5rem;
      }

      .empty-state p {
        color: #a0aec0;
        margin-bottom: 1.5rem;
      }

      .loading-state {
        text-align: center;
        padding: 3rem;
        background: white;
        border-radius: 16px;
      }

      .loading-state i {
        font-size: 3rem;
        color: #4facfe;
        margin-bottom: 1rem;
      }

      @media (max-width: 1024px) {
        .reservation-card {
          grid-template-columns: 1fr;
          gap: 1rem;
        }

        .reservation-icon {
          width: 50px;
          height: 50px;
          font-size: 1.25rem;
        }

        .reservation-actions {
          flex-direction: row;
          justify-content: space-between;
          align-items: center;
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

        .controls-section {
          padding: 1.5rem;
        }

        .date-filter-row {
          grid-template-columns: 1fr;
        }

        .action-buttons {
          flex-direction: column;
        }

        .stats-section {
          grid-template-columns: 1fr;
        }

        .reservation-content {
          grid-template-columns: 1fr;
          gap: 0.75rem;
        }
      }
    </style>
  </head>
  <body>
    <div class="container">
      <div class="header">
        <h1>
          <i class="fas fa-calendar-check"></i>
          Gestión de Reservas
        </h1>
        <p>Administra las reservas de habitaciones y gestiona las estadías</p>
      </div>

      <div class="stats-section">
        <div class="stat-card">
          <div class="stat-icon">
            <i class="fas fa-calendar-check"></i>
          </div>
          <div class="stat-info">
            <div class="stat-label">Total Reservas</div>
            <div class="stat-value">${reservas.size()}</div>
          </div>
        </div>
        <div class="stat-card">
          <div class="stat-icon">
            <i class="fas fa-bed"></i>
          </div>
          <div class="stat-info">
            <div class="stat-label">Habitaciones</div>
            <div class="stat-value" id="uniqueRooms">-</div>
          </div>
        </div>
        <div class="stat-card">
          <div class="stat-icon">
            <i class="fas fa-users"></i>
          </div>
          <div class="stat-info">
            <div class="stat-label">Huéspedes</div>
            <div class="stat-value" id="uniqueGuests">-</div>
          </div>
        </div>
      </div>

      <div class="controls-section">
        <div class="filters-container">
          <div class="filter-group">
            <label class="filter-label">
              <i class="fas fa-filter"></i>
              Filtrar por tipo de habitación:
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

          <div class="filter-group">
            <label class="filter-label">
              <i class="fas fa-calendar-alt"></i>
              Filtrar por rango de fechas:
            </label>
            <div class="date-filter-row">
              <div class="filter-group">
                <label
                  for="fechaInicio"
                  style="font-size: 0.85rem; color: #718096"
                  >Fecha de inicio</label
                >
                <input
                  type="date"
                  id="fechaInicio"
                  name="fechaInicio"
                  class="filter-input"
                  onchange="onFechaChange()"
                />
              </div>
              <div class="filter-group">
                <label for="fechaFin" style="font-size: 0.85rem; color: #718096"
                  >Fecha de fin</label
                >
                <input
                  type="date"
                  id="fechaFin"
                  name="fechaFin"
                  class="filter-input"
                  onchange="onFechaChange()"
                />
              </div>
              <button
                type="button"
                onclick="clearDateFilter()"
                class="btn btn-clear"
              >
                <i class="fas fa-times"></i>
                Limpiar
              </button>
            </div>
          </div>
        </div>

        <div class="action-buttons">
          <a href="reserva/nuevo" class="btn btn-primary">
            <i class="fas fa-plus"></i>
            Nueva Reserva
          </a>
          <a href="home" class="btn btn-secondary">
            <i class="fas fa-home"></i>
            Volver al Inicio
          </a>
        </div>
      </div>

      <div class="reservations-grid">
        <c:choose>
          <c:when test="${not empty reservas}">
            <c:forEach var="reserva" items="${reservas}">
              <a href="reserva/${reserva.id}" class="reservation-card">
                <div class="reservation-icon">
                  <i class="fas fa-calendar-check"></i>
                </div>

                <div class="reservation-content">
                  <div class="reservation-info">
                    <span class="reservation-label">Habitación</span>
                    <span class="reservation-value">
                      <i
                        class="fas fa-door-open"
                        style="color: #4facfe; font-size: 0.9rem"
                      ></i>
                      ${reserva.habitacion.numeroDeHabitacion}
                    </span>
                  </div>

                  <div class="reservation-info">
                    <span class="reservation-label">Tipo</span>
                    <span
                      class="reservation-badge badge-${reserva.habitacion.tipo}"
                    >
                      ${reserva.habitacion.tipo}
                    </span>
                  </div>

                  <div class="reservation-info">
                    <span class="reservation-label">Huésped</span>
                    <span class="reservation-value">
                      <i
                        class="fas fa-user"
                        style="color: #4facfe; font-size: 0.8rem"
                      ></i>
                      ${reserva.huesped.nombre}
                    </span>
                  </div>

                  <div class="reservation-info">
                    <span class="reservation-label">Check-in</span>
                    <span class="reservation-value">
                      <i
                        class="fas fa-sign-in-alt"
                        style="color: #48bb78; font-size: 0.8rem"
                      ></i>
                      ${reserva.fechaDeEntrada}
                    </span>
                  </div>

                  <div class="reservation-info">
                    <span class="reservation-label">Check-out</span>
                    <span class="reservation-value">
                      <i
                        class="fas fa-sign-out-alt"
                        style="color: #f56565; font-size: 0.8rem"
                      ></i>
                      ${reserva.fechaDeSalida}
                    </span>
                  </div>
                </div>

                <div class="reservation-actions">
                  <div class="reservation-price">$${reserva.precioTotal}</div>
                  <div class="reservation-id">ID: ${reserva.id}</div>
                  <span class="view-details">
                    Ver detalles <i class="fas fa-arrow-right"></i>
                  </span>
                </div>
              </a>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <div class="empty-state">
              <i class="fas fa-calendar-times"></i>
              <h3>No hay reservas disponibles</h3>
              <p>
                No se encontraron reservas que coincidan con los criterios de
                búsqueda
              </p>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </div>

    <script>
      // Calculate statistics
      function calculateStats() {
        const reservations = document.querySelectorAll(".reservation-card");
        const rooms = new Set();
        const guests = new Set();

        reservations.forEach((card) => {
          const roomNum = card
            .querySelector(".reservation-info:first-child .reservation-value")
            .textContent.trim();
          const guestName = card
            .querySelectorAll(".reservation-info")[2]
            .querySelector(".reservation-value")
            .textContent.trim();

          rooms.add(roomNum);
          guests.add(guestName);
        });

        document.getElementById("uniqueRooms").textContent = rooms.size;
        document.getElementById("uniqueGuests").textContent = guests.size;
      }

      // Call on page load
      calculateStats();

      function onTipoChange() {
        const select = document.getElementsByName("tipo")[0];
        const selectedValue = select.value;

        // Add loading state
        const container = document.querySelector(".reservations-grid");
        container.innerHTML =
          '<div class="loading-state"><i class="fas fa-spinner fa-spin"></i><p style="margin-top: 1rem; color: #4a5568;">Cargando reservas...</p></div>';

        // Make AJAX call to servlet
        fetch("filtrarReservas/" + selectedValue, {
          method: "GET",
        })
          .then((response) => response.text())
          .then((data) => {
            // Replace the current page content with the response
            document.open();
            document.write(data);
            document.getElementById("select").value = selectedValue;
            document.close();
          })
          .catch((error) => {
            console.error("Error:", error);
            container.innerHTML =
              '<div class="empty-state"><i class="fas fa-exclamation-triangle" style="color: #f56565;"></i><h3>Error al cargar las reservas</h3><p>Por favor, intenta nuevamente</p></div>';
          });
      }

      function onFechaChange() {
        // Trim the values to remove any whitespace
        const fechaInicio = document.getElementById("fechaInicio").value.trim();
        const fechaFin = document.getElementById("fechaFin").value.trim();

        if (fechaInicio && fechaFin) {
          if (fechaInicio > fechaFin) {
            alert(
              "La fecha de inicio no puede ser posterior a la fecha de fin."
            );
            return;
          }

          // Add loading state
          const container = document.querySelector(".reservations-grid");
          container.innerHTML =
            '<div class="loading-state"><i class="fas fa-spinner fa-spin"></i><p style="margin-top: 1rem; color: #4a5568;">Filtrando reservas...</p></div>';

          // Use string concatenation to build the URL
          const url =
            "/unidad2/app/filtrarReservasPorFecha?fechaInicio=" +
            encodeURIComponent(fechaInicio) +
            "&fechaFin=" +
            encodeURIComponent(fechaFin);

          fetch(url, {
            method: "GET",
          })
            .then((response) => {
              if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
              }
              return response.text();
            })
            .then((data) => {
              document.open();
              document.write(data);
              // Restore the trimmed values after page reload
              document.getElementById("fechaInicio").value = fechaInicio;
              document.getElementById("fechaFin").value = fechaFin;
              document.close();
            })
            .catch((error) => {
              console.error("Error:", error);
              container.innerHTML =
                '<div class="empty-state"><i class="fas fa-exclamation-triangle" style="color: #f56565;"></i><h3>Error al filtrar por fechas</h3><p>Por favor, intenta nuevamente</p></div>';
            });
        }
      }

      function clearDateFilter() {
        document.getElementById("fechaInicio").value = "";
        document.getElementById("fechaFin").value = "";

        // Reload the page to show all reservations
        window.location.href = window.location.pathname;
      }
    </script>
  </body>
</html>
