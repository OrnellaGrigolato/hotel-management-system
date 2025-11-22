<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@taglib prefix="c"
uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Editar Huésped ${huesped.nombre} - Sistema de Gestión Hotelera</title>
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

      .form-card {
        background: white;
        border-radius: 16px;
        padding: 2.5rem;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        position: relative;
        overflow: hidden;
      }

      .form-card::before {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 4px;
        background: linear-gradient(135deg, #f093fb, #f5576c);
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
        background: linear-gradient(
          135deg,
          rgba(240, 147, 251, 0.05),
          rgba(245, 87, 108, 0.05)
        );
        border-radius: 12px;
        padding: 1.5rem;
        margin-bottom: 2rem;
        border-left: 4px solid #f093fb;
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

      .guest-current-header {
        display: flex;
        align-items: center;
        gap: 1rem;
        margin-bottom: 1rem;
      }

      .guest-current-avatar {
        width: 60px;
        height: 60px;
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

      .guest-current-name {
        flex: 1;
      }

      .guest-current-title {
        font-size: 1.25rem;
        font-weight: 700;
        color: #2d3748;
      }

      .guest-current-doc {
        font-size: 0.9rem;
        color: #a0aec0;
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

      .form-input {
        padding: 1rem 1.25rem;
        border: 2px solid #e2e8f0;
        border-radius: 8px;
        font-size: 1rem;
        background: white;
        color: #2d3748;
        transition: all 0.3s ease;
        font-family: inherit;
      }

      .form-input:focus {
        outline: none;
        border-color: #f093fb;
        box-shadow: 0 0 0 3px rgba(240, 147, 251, 0.1);
        transform: translateY(-1px);
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

      .form-icon {
        color: #f093fb;
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

        .guest-current-header {
          flex-direction: column;
          text-align: center;
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
        box-shadow: 0 4px 15px rgba(240, 147, 251, 0.3);
      }
    </style>
  </head>
  <body>
    <div class="container">
      <div class="header">
        <h1>
          <i class="fas fa-user-edit"></i>
          Editar Huésped
        </h1>
        <p>Modifica la información del huésped ${huesped.nombre}</p>
      </div>

      <div class="form-card">
        <div class="form-header">
          <h2>
            <i class="fas fa-users"></i>
            Actualizar Información Personal
          </h2>
          <p>Realiza los cambios necesarios y guarda las modificaciones</p>
        </div>

        <div class="current-info">
          <h3>
            <i class="fas fa-info-circle"></i>
            Información Actual
          </h3>
          <div class="guest-current-header">
            <div class="guest-current-avatar">
              ${huesped.nombre.substring(0, 1)}
            </div>
            <div class="guest-current-name">
              <div class="guest-current-title">${huesped.nombre}</div>
              <div class="guest-current-doc">Doc: ${huesped.documento}</div>
            </div>
          </div>
          <div class="info-grid">
            <div class="info-item">
              <div class="info-label">ID Sistema</div>
              <div class="info-value">#${huesped.id}</div>
            </div>
            <div class="info-item">
              <div class="info-label">Nombre</div>
              <div class="info-value">${huesped.nombre}</div>
            </div>
            <div class="info-item">
              <div class="info-label">Documento</div>
              <div class="info-value">${huesped.documento}</div>
            </div>
            <div class="info-item">
              <div class="info-label">Teléfono</div>
              <div class="info-value">${huesped.telefono}</div>
            </div>
          </div>
        </div>

        <c:if test="${not empty error}">
          <div class="error-message">
            <i class="fas fa-exclamation-triangle"></i>
            <span>${error}</span>
          </div>
        </c:if>

        <div class="changes-indicator" id="changesIndicator">
          <i class="fas fa-exclamation-triangle"></i>
          <span
            >Has realizado cambios. No olvides guardar las modificaciones.</span
          >
        </div>

        <form method="post" action="${mvc.uri('editarHuesped')}" id="editForm">
          <input type="hidden" name="id" value="${huesped.id}" />

          <div class="form-grid">
            <div class="form-group">
              <label for="nombre" class="form-label">
                <i class="fas fa-user form-icon"></i>
                Nombre Completo
                <span class="required">*</span>
              </label>
              <input
                type="text"
                id="nombre"
                name="nombre"
                class="form-input"
                value="${huesped.nombre}"
                required
                maxlength="100"
                placeholder="Ej: Juan Carlos Pérez"
              />
              <span class="input-hint"
                >Nombre y apellido completo del huésped</span
              >
            </div>

            <div class="form-row">
              <div class="form-group">
                <label for="documento" class="form-label">
                  <i class="fas fa-id-card form-icon"></i>
                  Documento de Identidad
                  <span class="required">*</span>
                </label>
                <input
                  type="text"
                  id="documento"
                  name="documento"
                  class="form-input"
                  value="${huesped.documento}"
                  required
                  maxlength="20"
                  placeholder="Ej: 12.345.678"
                />
                <span class="input-hint">DNI, CI o pasaporte</span>
              </div>

              <div class="form-group">
                <label for="telefono" class="form-label">
                  <i class="fas fa-phone form-icon"></i>
                  Teléfono de Contacto
                  <span class="required">*</span>
                </label>
                <input
                  type="tel"
                  id="telefono"
                  name="telefono"
                  class="form-input"
                  value="${huesped.telefono}"
                  required
                  maxlength="20"
                  placeholder="Ej: +54 11 1234-5678"
                />
                <span class="input-hint"
                  >Número de teléfono con código de área</span
                >
              </div>
            </div>
          </div>

          <div class="form-actions">
            <a href="huesped/${huesped.id}" class="btn btn-secondary">
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
        <a href="huesped/${huesped.id}" class="btn btn-secondary">
          <i class="fas fa-eye"></i>
          Ver Huésped
        </a>
        <a href="huespedes" class="btn btn-secondary">
          <i class="fas fa-list"></i>
          Lista de Huéspedes
        </a>
        <a href="home" class="btn btn-secondary">
          <i class="fas fa-home"></i>
          Volver al Inicio
        </a>
      </div>
    </div>

    <script>
      // Almacenar valores originales para detectar cambios
      const originalValues = {
        nombre: document.getElementById("nombre").value,
        documento: document.getElementById("documento").value,
        telefono: document.getElementById("telefono").value,
      };

      // Función para verificar si el formulario tiene cambios
      function checkForChanges() {
        const currentValues = {
          nombre: document.getElementById("nombre").value,
          documento: document.getElementById("documento").value,
          telefono: document.getElementById("telefono").value,
        };

        const hasChanges = Object.keys(originalValues).some(
          (key) => originalValues[key] !== currentValues[key]
        );

        const indicator = document.getElementById("changesIndicator");
        if (hasChanges) {
          indicator.classList.add("show");
        } else {
          indicator.classList.remove("show");
        }
      }

      // Agregar listeners de cambio a todos los campos del formulario
      document
        .getElementById("nombre")
        .addEventListener("input", checkForChanges);
      document
        .getElementById("documento")
        .addEventListener("input", checkForChanges);
      document
        .getElementById("telefono")
        .addEventListener("input", checkForChanges);

      // Manejo del envío del formulario
      document
        .getElementById("editForm")
        .addEventListener("submit", function (e) {
          const submitBtn = document.getElementById("submitBtn");
          const indicator = document.getElementById("changesIndicator");

          // Eliminar indicador de cambios para evitar advertencia beforeunload
          indicator.classList.remove("show");

          // Agregar estado de carga
          submitBtn.disabled = true;
          submitBtn.innerHTML =
            '<i class="fas fa-spinner fa-spin"></i> Guardando...';
        });

      // Autoenfoque en el primer campo de entrada
      document.getElementById("nombre").focus();

      // Advertencia antes de salir de la página si hay cambios no guardados
      window.addEventListener("beforeunload", function (e) {
        const indicator = document.getElementById("changesIndicator");
        if (indicator.classList.contains("show")) {
          e.preventDefault();
          e.returnValue = "";
          return "";
        }
      });

    </script>
  </body>
</html>
