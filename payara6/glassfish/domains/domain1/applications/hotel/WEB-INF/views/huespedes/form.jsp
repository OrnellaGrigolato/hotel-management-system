<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@taglib prefix="c"
uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Agregar Nuevo Huésped - Sistema de Gestión Hotelera</title>
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

      @keyframes bounce {
        0%,
        20%,
        50%,
        80%,
        100% {
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
        box-shadow: 0 4px 15px rgba(240, 147, 251, 0.3);
      }

      /* Preview section */
      .preview-section {
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

      .preview-section h3 {
        color: #2d3748;
        font-size: 1.1rem;
        font-weight: 600;
        margin-bottom: 1rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
      }

      .guest-preview {
        display: flex;
        align-items: center;
        gap: 1rem;
      }

      .guest-preview-avatar {
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

      .guest-preview-info {
        flex: 1;
      }

      .guest-preview-name {
        font-size: 1.1rem;
        font-weight: 700;
        color: #2d3748;
        margin-bottom: 0.25rem;
      }

      .guest-preview-details {
        font-size: 0.9rem;
        color: #a0aec0;
      }

      .preview-empty {
        text-align: center;
        color: #a0aec0;
        font-style: italic;
        padding: 1rem;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <div class="header">
        <h1>
          <i class="fas fa-user-plus"></i>
          Nuevo Huésped
        </h1>
        <p>Registra un nuevo huésped en el sistema del hotel</p>
      </div>

      <div class="form-card">
        <div class="form-header">
          <h2>
            <i class="fas fa-users"></i>
            Información del Huésped
          </h2>
          <p>Completa todos los campos para registrar al nuevo huésped</p>
        </div>

        <div class="preview-section" id="previewSection">
          <h3>
            <i class="fas fa-eye"></i>
            Vista Previa
          </h3>
          <div class="guest-preview" id="guestPreview">
            <div class="guest-preview-avatar" id="previewAvatar">?</div>
            <div class="guest-preview-info">
              <div class="guest-preview-name" id="previewName">
                Nombre del huésped
              </div>
              <div class="guest-preview-details">
                <span id="previewDoc">Documento</span> •
                <span id="previewPhone">Teléfono</span>
              </div>
            </div>
          </div>
          <div class="preview-empty" id="previewEmpty">
            Completa el formulario para ver la vista previa
          </div>
        </div>

        <c:if test="${not empty error}">
          <div class="error-message">
            <i class="fas fa-exclamation-triangle"></i>
            <span>${error}</span>
          </div>
        </c:if>

        <form
          method="post"
          action="${mvc.uri('guardarHuesped')}"
          id="guestForm"
        >
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
                value="${nombre}"
                required
                maxlength="100"
                placeholder="Ej: María Fernanda González"
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
                  value="${documento}"
                  required
                  maxlength="8"
                  placeholder="Ej: 12345678"
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
                  value="${telefono}"
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
            <a href="${mvc.uri('listadoHuespedes')}" class="btn btn-secondary">
              <i class="fas fa-times"></i>
              Cancelar
            </a>
            <button type="submit" class="btn btn-primary" id="submitBtn">
              <i class="fas fa-save"></i>
              Guardar Huésped
            </button>
          </div>
        </form>

        <div class="success-animation" id="successAnimation">
          <i class="fas fa-check-circle"></i>
          <h3>¡Huésped registrado exitosamente!</h3>
          <p>El huésped ha sido agregado al sistema</p>
        </div>
      </div>

      <div class="navigation-buttons">
        <a href="${mvc.uri('listadoHuespedes')}" class="btn btn-secondary">
          <i class="fas fa-list"></i>
          Ver Todos los Huéspedes
        </a>
        <a href="../home" class="btn btn-secondary">
          <i class="fas fa-home"></i>
          Volver al Inicio
        </a>
      </div>
    </div>

    <script>
      // Funcion para actualizar la vista previa
      function updatePreview() {
        const nombre = document.getElementById("nombre").value.trim();
        const documento = document.getElementById("documento").value.trim();
        const telefono = document.getElementById("telefono").value.trim();

        const preview = document.getElementById("guestPreview");
        const previewEmpty = document.getElementById("previewEmpty");
        const previewAvatar = document.getElementById("previewAvatar");
        const previewName = document.getElementById("previewName");
        const previewDoc = document.getElementById("previewDoc");
        const previewPhone = document.getElementById("previewPhone");

        if (nombre || documento || telefono) {
          preview.style.display = "flex";
          previewEmpty.style.display = "none";

          // Actualizar avatar
          if (nombre) {
            previewAvatar.textContent = nombre.charAt(0).toUpperCase();
          } else {
            previewAvatar.textContent = "?";
          }

          // Actualizar nombre
          previewName.textContent = nombre || "Nombre del huésped";

          // Actualizar documento
          previewDoc.textContent = documento || "Documento";

          // Actualizar teléfono
          previewPhone.textContent = telefono || "Teléfono";
        } else {
          preview.style.display = "none";
          previewEmpty.style.display = "block";
        }
      }

      // Agregar listeners de entrada
      document
        .getElementById("nombre")
        .addEventListener("input", updatePreview);
      document
        .getElementById("documento")
        .addEventListener("input", updatePreview);
      document
        .getElementById("telefono")
        .addEventListener("input", updatePreview);

      // Validación del formulario y manejo de envío
      document
        .getElementById("guestForm")
        .addEventListener("submit", function (e) {
          const documento = document.getElementById("documento").value.trim();
          const submitBtn = document.getElementById("submitBtn");

          // Validar longitud del documento
          if (documento.length > 8) {
            e.preventDefault();
            alert("El documento no puede tener más de 8 caracteres");
            document.getElementById("documento").focus();
            return false;
          }

          // Agregar estado de carga
          submitBtn.disabled = true;
          submitBtn.innerHTML =
            '<i class="fas fa-spinner fa-spin"></i> Guardando...';
        });

      // Autoenfoque en el primer campo de entrada
      document.getElementById("nombre").focus();

      // Actualización inicial de la vista previa si hay valores (de errores de validación)
      updatePreview();
    </script>
  </body>
</html>
