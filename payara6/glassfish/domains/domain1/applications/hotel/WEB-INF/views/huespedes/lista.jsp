<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@taglib prefix="c"
uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Gestión de Huéspedes - Hotel Management System</title>
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
        background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
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

      .search-container {
        display: flex;
        align-items: center;
        gap: 1rem;
        margin-bottom: 1.5rem;
      }

      .search-label {
        font-weight: 600;
        color: #2d3748;
        display: flex;
        align-items: center;
        gap: 0.5rem;
      }

      .search-input {
        flex: 1;
        padding: 0.75rem 1rem;
        border: 2px solid #e2e8f0;
        border-radius: 8px;
        font-size: 1rem;
        background: white;
        color: #2d3748;
        transition: all 0.3s ease;
      }

      .search-input:focus {
        outline: none;
        border-color: #f093fb;
        box-shadow: 0 0 0 3px rgba(240, 147, 251, 0.1);
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
        background: linear-gradient(135deg, #f093fb, #f5576c);
        color: white;
        box-shadow: 0 4px 15px rgba(240, 147, 251, 0.3);
      }

      .btn-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(240, 147, 251, 0.4);
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

      .guests-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
        gap: 1.5rem;
        margin-top: 2rem;
      }

      .guest-card {
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

      .guest-card::before {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: linear-gradient(
          135deg,
          rgba(240, 147, 251, 0.05),
          rgba(245, 87, 108, 0.05)
        );
        opacity: 0;
        transition: opacity 0.3s ease;
        z-index: 1;
      }

      .guest-card:hover {
        transform: translateY(-8px) scale(1.02);
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        border-left-color: #f093fb;
      }

      .guest-card:hover::before {
        opacity: 1;
      }

      .guest-card > * {
        position: relative;
        z-index: 2;
      }

      .guest-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 1rem;
      }

      .guest-avatar {
        width: 50px;
        height: 50px;
        background: linear-gradient(135deg, #f093fb, #f5576c);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 1.5rem;
        font-weight: 700;
        text-transform: uppercase;
      }

      .guest-name {
        flex: 1;
        margin-left: 1rem;
      }

      .guest-title {
        font-size: 1.25rem;
        font-weight: 700;
        color: #2d3748;
        margin-bottom: 0.25rem;
      }

      .guest-subtitle {
        font-size: 0.9rem;
        color: #a0aec0;
        display: flex;
        align-items: center;
        gap: 0.25rem;
      }

      .guest-status {
        background: linear-gradient(135deg, #f093fb, #f5576c);
        color: white;
        padding: 0.25rem 0.75rem;
        border-radius: 20px;
        font-size: 0.7rem;
        font-weight: 500;
        text-transform: uppercase;
      }

      .guest-details {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 1rem;
        margin-bottom: 1rem;
      }

      .guest-detail {
        display: flex;
        flex-direction: column;
        gap: 0.25rem;
      }

      .guest-detail-label {
        font-size: 0.8rem;
        color: #a0aec0;
        font-weight: 500;
        text-transform: uppercase;
        letter-spacing: 0.5px;
      }

      .guest-detail-value {
        font-size: 1rem;
        color: #2d3748;
        font-weight: 600;
      }

      .guest-contact {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        color: #f093fb;
        font-weight: 500;
      }

      .guest-actions {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-top: 1rem;
        padding-top: 1rem;
        border-top: 1px solid #e2e8f0;
      }

      .guest-id {
        font-size: 0.8rem;
        color: #a0aec0;
      }

      .view-details {
        color: #f093fb;
        font-size: 0.9rem;
        font-weight: 500;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        transition: all 0.3s ease;
      }

      .view-details:hover {
        color: #f5576c;
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
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
        border-left: 4px solid #f093fb;
      }

      .stat-header {
        display: flex;
        align-items: center;
        gap: 0.75rem;
        margin-bottom: 1rem;
      }

      .stat-icon {
        width: 40px;
        height: 40px;
        background: linear-gradient(135deg, #f093fb, #f5576c);
        color: white;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.1rem;
      }

      .stat-title {
        font-weight: 600;
        color: #2d3748;
        font-size: 0.9rem;
      }

      .stat-value {
        font-size: 2rem;
        font-weight: 700;
        background: linear-gradient(135deg, #f093fb, #f5576c);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
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

        .search-container {
          flex-direction: column;
          align-items: stretch;
        }

        .action-buttons {
          flex-direction: column;
        }

        .guests-grid {
          grid-template-columns: 1fr;
          gap: 1rem;
        }

        .guest-card {
          padding: 1rem;
        }

        .stats-section {
          grid-template-columns: 1fr;
        }
      }
    </style>
    <script>
      //TODO: mover esta logica a un get con java
      // Search functionality
      function searchGuests() {
        const searchTerm = document
          .getElementById("searchInput")
          .value.toLowerCase();
        const guestCards = document.querySelectorAll(".guest-card");

        guestCards.forEach((card) => {
          const guestName = card
            .querySelector(".guest-title")
            .textContent.toLowerCase();
          const guestDoc = card
            .querySelector(".guest-detail-value")
            .textContent.toLowerCase();

          if (guestName.includes(searchTerm) || guestDoc.includes(searchTerm)) {
            card.style.display = "block";
          } else {
            card.style.display = "none";
          }
        });
      }

      // Real-time search
      document.addEventListener("DOMContentLoaded", function () {
        const searchInput = document.getElementById("searchInput");
        if (searchInput) {
          searchInput.addEventListener("input", searchGuests);
        }
      });
    </script>
  </head>
  <body>
    <div class="container">
      <div class="header">
        <h1>
          <i class="fas fa-users"></i>
          Gestión de Huéspedes
        </h1>
        <p>Administra el registro de huéspedes y su información personal</p>
      </div>

      <div class="stats-section">
        <div class="stat-card">
          <div class="stat-header">
            <div class="stat-icon">
              <i class="fas fa-users"></i>
            </div>
            <div class="stat-title">Total de Huéspedes</div>
          </div>
          <div class="stat-value">${huespedes.size()}</div>
        </div>
        <div class="stat-card">
          <div class="stat-header">
            <div class="stat-icon">
              <i class="fas fa-user-check"></i>
            </div>
            <div class="stat-title">Huéspedes Activos</div>
          </div>
          <c:set var="activeCount" value="0" />
          <c:forEach var="h" items="${huespedes}">
            <c:if test="${h.estado == 'Activo'}">
              <c:set var="activeCount" value="${activeCount + 1}" />
            </c:if>
          </c:forEach>
          <div class="stat-value">${activeCount}</div>
        </div>
      </div>

      <div class="controls-section">
        <div class="search-container">
          <label class="search-label">
            <i class="fas fa-search"></i>
            Buscar huésped:
          </label>
          <input
            type="text"
            id="searchInput"
            class="search-input"
            placeholder="Buscar por nombre o documento..."
          />
        </div>

        <div class="action-buttons">
          <a href="huesped/nuevo" class="btn btn-primary">
            <i class="fas fa-plus"></i>
            Agregar Nuevo Huésped
          </a>
          <a href="home" class="btn btn-secondary">
            <i class="fas fa-home"></i>
            Volver al Inicio
          </a>
        </div>
      </div>

      <div class="guests-grid">
        <c:choose>
          <c:when test="${not empty huespedes}">
            <c:forEach var="huesped" items="${huespedes}">
              <a href="huesped/${huesped.id}" class="guest-card">
                <div class="guest-header">
                  <div class="guest-avatar">
                    ${huesped.nombre.substring(0, 1)}
                  </div>
                  <div class="guest-name">
                    <div class="guest-title">${huesped.nombre}</div>
                    <div class="guest-subtitle">
                      <i class="fas fa-id-card"></i>
                      Doc: ${huesped.documento}
                    </div>
                  </div>
                  <div class="guest-status">${huesped.estado}</div>
                </div>

                <div class="guest-details">
                  <div class="guest-detail">
                    <span class="guest-detail-label">Documento</span>
                    <span class="guest-detail-value">${huesped.documento}</span>
                  </div>
                  <div class="guest-detail">
                    <span class="guest-detail-label">Contacto</span>
                    <span class="guest-detail-value guest-contact">
                      <i class="fas fa-phone"></i>
                      ${huesped.telefono}
                    </span>
                  </div>
                </div>

                <div class="guest-actions">
                  <span class="guest-id">ID: ${huesped.id}</span>
                  <span class="view-details">
                    Ver perfil <i class="fas fa-arrow-right"></i>
                  </span>
                </div>
              </a>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <div class="empty-state" style="grid-column: 1 / -1">
              <i class="fas fa-users"></i>
              <h3>No hay huéspedes registrados</h3>
              <p>No se encontraron huéspedes en el sistema</p>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </body>
</html>
