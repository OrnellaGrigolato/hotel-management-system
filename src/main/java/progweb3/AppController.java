package progweb3;

import jakarta.inject.Inject;
import jakarta.mvc.Controller;
import jakarta.mvc.Models;
import jakarta.mvc.UriRef;
import jakarta.ws.rs.DELETE;
import jakarta.ws.rs.FormParam;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.QueryParam;
import java.sql.SQLException;
import java.util.List;

@Path("")
public class AppController {

    @Inject
    private Repositorio repositorio;

    @Inject
    private Models models;

    /**
     * Devuelve la home.
     * 
     * @return
     * @throws Exception 
     */
    @GET
    @Path("home")
    @Controller
    @UriRef("home")
    public String home() throws Exception {
        return "home.jsp";
    }
    /**
     * Devuelve el listado de habitaciones.
     * 
     * @return
     * @throws Exception 
     */
    @GET
    @Path("habitaciones")
    @Controller
    @UriRef("listadoHabitaciones")
    public String getHabitaciones() throws Exception {
        List<Habitacion> habitaciones = repositorio.getHabitaciones();
        models.put("habitaciones", habitaciones);
        return "habitaciones/lista.jsp";
    }

    
    /**
     * Devuelve el listado de habitaciones filtradas.
     * 
     * @return
     * @throws Exception 
     */
    @GET
    @Path("filtrarHabitaciones/{tipo}")
    @Controller
    @UriRef("filtrarHabitaciones")
    public String filtrarHabitaciones(@PathParam("tipo") String tipo) throws Exception {
        List<Habitacion> habitaciones;
        if ("todos".equals(tipo)) {
            habitaciones = repositorio.getHabitaciones();
        } else {
            habitaciones = repositorio.getHabitacionesFiltradas(tipo);
        }
        models.put("habitaciones", habitaciones);
        return "habitaciones/lista.jsp";
    }

    /**
     * Devuelve el formulario para agregar una nueva habitación.
     * 
     * @return
     * @throws Exception 
     */
    @GET
    @Path("habitacion/nuevo")
    @Controller
    @UriRef("habitacionForm")
    public String getNuevoHabitacionForm() throws Exception {
        return "habitaciones/form.jsp";
    }

    /**
     * Guarda una nueva habitacion con los datos recibidos.
     * 
     * @param numero
     * @param tipo
     * @param precioPorNoche
     * @return
     * @throws Exception 
     */
    @POST
    @Path("habitacion")
    @Controller
    @UriRef("guardarHabitacion")
    public String guardarHabitacion(@FormParam("numero") Integer numero, @FormParam("tipo") String tipo,  @FormParam("precioPorNoche") Integer precioPorNoche) throws Exception {
        Integer numerodehabitacion = repositorio.guardarHabitacion(numero, tipo, precioPorNoche);
       return "redirect:habitacion/" + numerodehabitacion;
    }

    /**
     * Devuelve la información de un habitacion.
     * 
     * @param id
     * @return
     * @throws Exception 
     */
    @GET
    @Path("habitacion/{numero}")
    @Controller
    public String getHabitacion(@PathParam("numero") Integer numero) throws Exception {
        Habitacion habitacion = repositorio.getHabitacion(numero);
        models.put("h", habitacion);
        return "habitaciones/habitacion.jsp";
    }



    /**
     * Devuelve el formulario para editar una habitación con los datos cargados.
     * 
     * @param id
     * @param tipo
     * @param precioPorNoche
     * @param numeroDeHabitacion
     * @return
     * @throws Exception 
     */
    @GET
    @Path("editarHabitacion")
    @Controller
    @UriRef("editarHabitacion")
    public String getEditarHabitacionForm(@QueryParam("id") Integer id, 
                                         @QueryParam("tipo") String tipo, 
                                         @QueryParam("precioPorNoche") Integer precioPorNoche, 
                                         @QueryParam("numeroDeHabitacion") Integer numeroDeHabitacion) throws Exception {
        // Crear un objeto habitación con los datos recibidos para mostrar en el formulario
        Habitacion habitacion = new Habitacion();
        habitacion.setId(id);
        habitacion.setTipo(tipo);
        habitacion.setPrecioPorNoche(precioPorNoche);
        habitacion.setNumeroDeHabitacion(numeroDeHabitacion);
        
        models.put("habitacion", habitacion);
        return "habitaciones/form_de_edicion.jsp";
    }

    /**
     * Actualiza una habitación con los datos recibidos.
     * 
     * @param id
     * @param numero
     * @param tipo
     * @param precioPorNoche
     * @return
     * @throws Exception 
     */
    @POST
    @Path("editarHabitacion")
    @Controller
    public String actualizarHabitacion(@FormParam("id") Integer id, 
                                      @FormParam("numero") Integer numero, 
                                      @FormParam("tipo") String tipo, 
                                      @FormParam("precioPorNoche") Integer precioPorNoche) throws Exception {
        repositorio.actualizarHabitacion(id, numero, tipo, precioPorNoche);
        return "redirect:habitacion/" + numero;
    }

    /**
     * Elimina una habitacion.
     * 
     *  @param id
     * @throws Exception 
     */
    @GET
    @Path("eliminarHabitacion/{id}")
    @Controller
    @UriRef("eliminarHabitacion")
    public String eliminarHabitacion(@PathParam("id") Integer id) throws Exception {
      repositorio.eliminarHabitacion(id);
       return "redirect:habitaciones";
    }

    /**
     * Devuelve el listado de huespedes.
     * 
     * @return
     * @throws Exception 
     */
    @GET
    @Path("huespedes")
    @Controller
    @UriRef("listadoHuespedes")
    public String getHuespedes() throws Exception {
        List<Huesped> huespedes = repositorio.getHuespedes();
        models.put("huespedes", huespedes);
        return "huespedes/lista.jsp";
    }

    /**
     * Devuelve la información de un huesped.
     * 
     * @param id
     * @return
     * @throws Exception 
     */
    @GET
    @Path("huesped/{id}")
    @Controller
    public String getHuesped(@PathParam("id") Integer id) throws Exception {
        Huesped huesped = repositorio.getHuesped(id);
        models.put("h", huesped);
        return "huespedes/huesped.jsp";
    }

    /**
     * Elimina un huesped.
     * 
     *  @param id
     * @throws Exception 
     */
    @GET
    @Path("eliminarHuesped/{id}")
    @Controller
    @UriRef("eliminarHuesped")
    public String eliminarHuesped(@PathParam("id") Integer id) throws Exception {
      repositorio.eliminarHuesped(id);
       return "redirect:huespedes";
    }

     /**
     * Devuelve el formulario para agregar un nuevo huesped.
     * 
     * @return
     * @throws Exception 
     */
    @GET
    @Path("huesped/nuevo")
    @Controller
    @UriRef("huespedForm")
    public String getNuevoHuespedForm() throws Exception {
        return "huespedes/form.jsp";
    }

    /**
     * Guarda un nuevo huesped con los datos recibidos.
     * 
     * @param nombre
     * @param documento
     * @param telefono
     * @return
     * @throws Exception 
     */
    @POST
    @Path("huesped")
    @Controller
    @UriRef("guardarHuesped")
    public String guardarHuesped(@FormParam("nombre") String nombre, @FormParam("telefono") String telefono,  @FormParam("documento") String documento) throws Exception {
        try {
            Integer idHuesped = repositorio.guardarHuesped(nombre, telefono, documento);
            return "redirect:huesped/" + idHuesped;
        } catch (SQLException e) {
            // Verificar si es un error de documento duplicado
            if (e.getMessage().contains("Ya existe un huésped con el documento")) {
                // Agregar mensaje de error al modelo y regresar al formulario
                models.put("error", e.getMessage());
                models.put("nombre", nombre);
                models.put("telefono", telefono);
                models.put("documento", documento);
                return "huespedes/form.jsp";
            } else {
                // Volver a lanzar otras excepciones SQL
                throw e;
            }
        }
    }
    /**
     * Actualiza un huésped con los datos recibidos.
     * 
     * @param id
     * @param nombre
     * @param telefono
     * @param documento
     * @return
     * @throws Exception 
     */
    @POST
    @Path("editarHuesped")
    @Controller
    public String actualizarHuesped(@FormParam("id") Integer id, 
                                      @FormParam("nombre") String nombre, 
                                      @FormParam("telefono") String telefono, 
                                      @FormParam("documento") String documento) throws Exception {
        try {
            repositorio.editarHuesped(id, nombre, telefono, documento);
            return "redirect:huesped/" + id;
        } catch (SQLException e) {
            // Verificar si es un error de documento duplicado
            if (e.getMessage().contains("Ya existe otro huésped con el documento")) {
                // Agregar mensaje de error al modelo y regresar al formulario de edición
                models.put("error", e.getMessage());
                Huesped huesped = new Huesped();
                huesped.setId(id);
                huesped.setNombre(nombre);
                huesped.setTelefono(telefono);
                huesped.setDocumento(documento);
                models.put("huesped", huesped);
                return "huespedes/form_de_edicion.jsp";
            } else {
                // Volver a lanzar otras excepciones SQL
                throw e;
            }
        }
    }

    /**
     * Devuelve el formulario para editar un huésped con los datos cargados.
     * 
     * @param id
     * @param tipo
     * @param precioPorNoche
     * @param numeroDeHabitacion
     * @return
     * @throws Exception 
     */
    @GET
    @Path("editarHuesped")
    @Controller
    @UriRef("editarHuesped")
    public String getEditarHuespedForm(@QueryParam("id") Integer id, 
                                         @QueryParam("nombre") String nombre, 
                                         @QueryParam("telefono") String telefono, 
                                         @QueryParam("documento") String documento) throws Exception {
        // Crear un objeto habitación con los datos recibidos para mostrar en el formulario
        Huesped huesped = new Huesped();
        huesped.setId(id);
        huesped.setNombre(nombre);
        huesped.setDocumento(documento);
        huesped.setTelefono(telefono);
        
        models.put("huesped", huesped);
        return "huespedes/form_de_edicion.jsp";
    }


   /**
     * Devuelve el listado de reservas.
     * 
     * @return
     * @throws Exception 
     */
    @GET
    @Path("reservas")
    @Controller
    @UriRef("listadoReservas")
    public String getReservas() throws Exception {
        List<Reserva> reservas = repositorio.getReservas();
        models.put("reservas", reservas);
        return "reservas/lista.jsp";
    }


    /**
     * Devuelve el formulario para agregar un nueva reserva.
     * 
     * @return
     * @throws Exception 
     */
    @GET
    @Path("reserva/nuevo")
    @Controller
    @UriRef("reservaForm")
    public String getNuevoReservaForm() throws Exception {
        // Obtener listas de habitaciones y huéspedes para los select
        List<Habitacion> habitaciones = repositorio.getHabitacionesLibres();
        List<Huesped> huespedes = repositorio.getHuespedesNoActivos();
        
        // Agregar al modelo para que estén disponibles en el JSP
        models.put("habitaciones", habitaciones);
        models.put("huespedes", huespedes);
        
        return "reservas/form.jsp";
    }    
    
    
    /**
     * Guarda una nueva reserva con los datos recibidos.
     * 
     * @param idHabitacion
     * @param idHuesped
     * @param fechaDeEntrada
     * @param fechaDeSalida
     * @return
     * @throws Exception 
     */
    @POST
    @Path("reserva")
    @Controller
    @UriRef("guardarReserva")
    public String guardarReserva(@FormParam("idHabitacion") Integer idHabitacion, 
                                @FormParam("idHuesped") Integer idHuesped,  
                                @FormParam("fechaDeEntrada") String fechaDeEntrada, 
                                @FormParam("fechaDeSalida") String fechaDeSalida) throws Exception {
        try {
            Integer idReserva = repositorio.guardarReserva(idHuesped, idHabitacion, fechaDeEntrada, fechaDeSalida);
            return "redirect:reserva/" + idReserva;
        } catch (SQLException e) {
            // Si hay error, volver al formulario con los datos y el mensaje de error
            models.put("error", e.getMessage());
            models.put("idHabitacion", idHabitacion);
            models.put("idHuesped", idHuesped);
            models.put("fechaDeEntrada", fechaDeEntrada);
            models.put("fechaDeSalida", fechaDeSalida);
            
            // Recargar las listas para los select
            List<Habitacion> habitaciones = repositorio.getHabitaciones();
            List<Huesped> huespedes = repositorio.getHuespedes();
            models.put("habitaciones", habitaciones);
            models.put("huespedes", huespedes);
            
            return "reservas/form.jsp";
        }
    }

    /**
     * Devuelve la información de una reserva.
     * 
     * @param id
     * @return
     * @throws Exception 
     */
    @GET
    @Path("reserva/{id}")
    @Controller
    public String getReserva(@PathParam("id") Integer id) throws Exception {
        Reserva reserva = repositorio.getReserva(id);
        models.put("r", reserva);
        return "reservas/reserva.jsp";
    }


    
    /**
     * Elimina una reserva.
     * 
     *  @param id
     * @throws Exception 
     */
    @GET
    @Path("eliminarReserva/{id}")
    @Controller
    @UriRef("eliminarReserva")
    public String eliminarReserva(@PathParam("id") Integer id) throws Exception {
      repositorio.eliminarReserva(id);
       return "redirect:reservas";
    }

/**
     * Devuelve el listado de reservas filtradas por tipo.
     * 
     * @param tipo
     * @return
     * @throws Exception 
     */
    @GET
    @Path("filtrarReservas/{tipo}")
    @Controller
    @UriRef("filtrarReservas")
    public String filtrarReservas(@PathParam("tipo") String tipo) throws Exception {
        List<Reserva> reservas;
        if ("todos".equals(tipo)) {
            reservas = repositorio.getReservas();
        } else {
            reservas = repositorio.getReservasFiltradas(tipo);
        }
        models.put("reservas", reservas);
        return "reservas/lista.jsp";
    }

    /**
     * Devuelve el listado de reservas filtradas por rango de fechas.
     * 
     * @param fechaInicio
     * @param fechaFin
     * @return
     * @throws Exception 
     */
    @GET
    @Path("filtrarReservasPorFecha")
    @Controller
    @UriRef("filtrarReservasPorFecha")
    public String filtrarReservasPorFecha(@QueryParam("fechaInicio") String fechaInicio, 
                                         @QueryParam("fechaFin") String fechaFin) throws Exception {
 
        List<Reserva> reservas;
        if (fechaInicio != null && fechaFin != null && !fechaInicio.isEmpty() && !fechaFin.isEmpty()) {
            System.out.println("Llamando a getReservasPorFecha con fechas: " + fechaInicio + " - " + fechaFin);
            reservas = repositorio.getReservasPorFecha(fechaInicio, fechaFin);
            System.out.println("Reservas encontradas: " + reservas.size());
        } else {
            System.out.println("Parámetros inválidos, devolviendo todas las reservas");
            reservas = repositorio.getReservas();
        }
        models.put("reservas", reservas);
        return "reservas/lista.jsp";
    }


}