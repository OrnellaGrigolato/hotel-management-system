package progweb3;

import jakarta.annotation.Resource;
import jakarta.annotation.sql.DataSourceDefinition;
import jakarta.enterprise.context.ApplicationScoped;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;

@DataSourceDefinition(
        name = "appDS",
        className = "org.postgresql.ds.PGSimpleDataSource",
        url = "jdbc:postgresql://localhost:5432/unidad5db?TimeZone=UTC",
        user = "pw3",
        password = "fichunl")
@ApplicationScoped
public class Repositorio {

    @Resource(name = "appDS")
    private DataSource dataSource;


    public Integer guardarHabitacion(Integer numero, String tipo, Integer precioPorNoche) throws SQLException {
        try (Connection conn = dataSource.getConnection()) {
            try (PreparedStatement pst = conn.prepareStatement(
                "INSERT INTO habitacion (numerodehabitacion, tipo, preciopornoche) VALUES (?, ?, ?)")) {
                pst.setInt(1, numero);
                pst.setString(2, tipo);
                pst.setInt(3, precioPorNoche);
                pst.execute();
                return numero;
            }
        }
    }

    public Habitacion getHabitacion(Integer numero) throws SQLException {
        try (Connection conn = dataSource.getConnection()) {
            try (PreparedStatement pst = conn.prepareStatement("SELECT * FROM habitacion WHERE numerodehabitacion = ?")) {
                pst.setInt(1, numero);
                try (ResultSet res = pst.executeQuery()) {
                    if (res.next()) {
                        Habitacion habitacion = completarHabitacion(res);
                        return habitacion;
                    } else {
                        return null;
                    }
                }
            }
        }
    }

      public Habitacion getHabitacionById(Integer id) throws SQLException {
        try (Connection conn = dataSource.getConnection()) {
            try (PreparedStatement pst = conn.prepareStatement("SELECT * FROM habitacion WHERE id = ?")) {
                pst.setInt(1, id);
                try (ResultSet res = pst.executeQuery()) {
                    if (res.next()) {
                        Habitacion habitacion = completarHabitacion(res);
                        return habitacion;
                    } else {
                        return null;
                    }
                }
            }
        }
    }

    public List<Habitacion> getHabitaciones() throws SQLException {
        List<Habitacion> habitaciones = new ArrayList<>();
        try (Connection conn = dataSource.getConnection();
             PreparedStatement pst = conn.prepareStatement("SELECT * FROM habitacion ORDER BY numerodehabitacion");
             ResultSet res = pst.executeQuery()) {            
            while (res.next()) {
                habitaciones.add(completarHabitacion(res));
            }
        }
        return habitaciones;
    }

    
    public List<Habitacion> getHabitacionesFiltradas(String tipo) throws SQLException {
        List<Habitacion> habitaciones = new ArrayList<>();
        try (Connection conn = dataSource.getConnection()) {
            try (PreparedStatement pst = conn.prepareStatement("SELECT * FROM habitacion WHERE tipo = ? ORDER BY numerodehabitacion")) {
                pst.setString(1, tipo);
                try (ResultSet res = pst.executeQuery()) {            
                    while (res.next()) {
                        habitaciones.add(completarHabitacion(res));
                    }
                }
            }
        }
        return habitaciones;
    }


    private Habitacion completarHabitacion(ResultSet rs) throws SQLException {
        Habitacion habitacion = new Habitacion();
        habitacion.setNumeroDeHabitacion(rs.getInt("numerodehabitacion"));
        habitacion.setTipo(rs.getString("tipo"));
        habitacion.setPrecioPorNoche(rs.getInt("preciopornoche"));
        habitacion.setId(rs.getInt("id"));
        
        // Calculate estado based on active reservations
        try (Connection conn = dataSource.getConnection();
             PreparedStatement pst = conn.prepareStatement(
             "SELECT COUNT(*) FROM reserva r " +
             "WHERE r.habitacion = ? " +
             "AND CURRENT_DATE >= r.fecha_de_ingreso " +
             "AND CURRENT_DATE < r.fecha_de_salida")) {
            pst.setInt(1, habitacion.getId());
            try (ResultSet estadoRs = pst.executeQuery()) {
                if (estadoRs.next() && estadoRs.getInt(1) > 0) {
                    habitacion.setEstado("Ocupada");
                } else {
                    habitacion.setEstado("Disponible");
                }
            }
        }
        
        return habitacion;
    }



    public void actualizarHabitacion(Integer id, Integer numero, String tipo, Integer precioPorNoche) throws SQLException {
        try (Connection conn = dataSource.getConnection()) {
            try (PreparedStatement pst = conn.prepareStatement(
                "UPDATE habitacion SET numerodehabitacion = ?, tipo = ?, preciopornoche = ? WHERE id = ?")) {
                pst.setInt(1, numero);
                pst.setString(2, tipo);
                pst.setInt(3, precioPorNoche);
                pst.setInt(4, id);
                pst.execute();
            }
        }
    }

    public void eliminarHabitacion(Integer id) throws SQLException {
        try (Connection conn = dataSource.getConnection()) {
            try (PreparedStatement pst = conn.prepareStatement("DELETE FROM habitacion WHERE id = ?")) {
                pst.setInt(1, id);
                pst.execute();
            }
        }
    }

    // private void completarLibrosAutor(Connection conn, Autor autor) throws SQLException {
    //     List<Libro> librosAutor = new ArrayList<>();
    //     //COMPLETAR ACÁ EL CÓDIGO NECESARIO PARA OBTENER LOS LIBROS DEL AUTOR DADO
    //     //...
    //     autor.setLibros(librosAutor);
    // }

    public void guardarLibro(Autor autor, String titulo, Integer lanzamiento) throws SQLException {
        //COMPLETAR ACÁ EL CÓDIGO NECESARIO PARA GUARDAR UN NUEVO LIBRO
        //...
    }

    public List<Huesped> getHuespedes() throws SQLException {
        List<Huesped> huespedes = new ArrayList<>();
        try (Connection conn = dataSource.getConnection();
             PreparedStatement pst = conn.prepareStatement("SELECT * FROM huesped ORDER BY id");
             ResultSet res = pst.executeQuery()) {            
            while (res.next()) {
                huespedes.add(completarHuesped(res));
            }
        }
        return huespedes;
    }

    private Huesped completarHuesped(ResultSet rs) throws SQLException {
        Huesped huesped = new Huesped();
        huesped.setNombre(rs.getString("nombre"));
        huesped.setTelefono(rs.getString("telefono"));
        huesped.setDocumento(rs.getString("documento"));
        huesped.setId(rs.getInt("id"));
        
        // Calculate estado based on active reservations
        try (Connection conn = dataSource.getConnection();
             PreparedStatement pst = conn.prepareStatement(
             "SELECT COUNT(*) FROM reserva r " +
             "WHERE r.huesped = ? " +
             "AND CURRENT_DATE >= r.fecha_de_ingreso " +
             "AND CURRENT_DATE < r.fecha_de_salida")) {
            pst.setInt(1, huesped.getId());
            try (ResultSet estadoRs = pst.executeQuery()) {
                if (estadoRs.next() && estadoRs.getInt(1) > 0) {
                    huesped.setEstado("Activo");
                } else {
                    huesped.setEstado("Registrado");
                }
            }
        }
        
        return huesped;
    }

    public Huesped getHuesped(Integer id) throws SQLException {
        try (Connection conn = dataSource.getConnection()) {
            try (PreparedStatement pst = conn.prepareStatement("SELECT * FROM huesped WHERE id = ?")) {
                pst.setInt(1, id);
                try (ResultSet res = pst.executeQuery()) {
                    if (res.next()) {
                        Huesped huesped = completarHuesped(res);
                        return huesped;
                    } else {
                        return null;
                    }
                }
            }
        }
    }

        public Integer guardarHuesped(String nombre, String telefono, String documento) throws SQLException {
        try (Connection conn = dataSource.getConnection()) {
            // Check if documento already exists
            try (PreparedStatement checkPst = conn.prepareStatement(
                    "SELECT COUNT(*) FROM huesped WHERE documento = ?")) {
                checkPst.setString(1, documento);
                try (ResultSet rs = checkPst.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        throw new SQLException("Ya existe un huésped con el documento: " + documento);
                    }
                }
            }
            
            // If documento doesn't exist, proceed with insertion
            try (PreparedStatement pst = conn.prepareStatement(
                    "INSERT INTO huesped (nombre, telefono, documento) VALUES (?, ?, ?)",
                    Statement.RETURN_GENERATED_KEYS)) {
                pst.setString(1, nombre);
                pst.setString(2, telefono);
                pst.setString(3, documento);
                pst.execute();
                try (ResultSet generated = pst.getGeneratedKeys()) {
                    if (generated.next()) {
                        return generated.getInt(1);
                    } else {
                        throw new SQLException("No se pudo obtener ningún ID.");
                    }
                }
            }
        }
    }

    public void eliminarHuesped(Integer id) throws SQLException {
        try (Connection conn = dataSource.getConnection()) {
            try (PreparedStatement pst = conn.prepareStatement("DELETE FROM huesped WHERE id = ?")) {
                pst.setInt(1, id);
                pst.execute();
            }
        }
    }

    public void editarHuesped(Integer id, String nombre, String telefono, String documento) throws SQLException {
        try (Connection conn = dataSource.getConnection()) {
            // Check if documento already exists for another huesped
            try (PreparedStatement checkPst = conn.prepareStatement(
                    "SELECT COUNT(*) FROM huesped WHERE documento = ? AND id != ?")) {
                checkPst.setString(1, documento);
                checkPst.setInt(2, id);
                try (ResultSet rs = checkPst.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        throw new SQLException("Ya existe otro huésped con el documento: " + documento);
                    }
                }
            }
            
            try (PreparedStatement pst = conn.prepareStatement(
                "UPDATE huesped SET nombre = ?, telefono = ?, documento = ? WHERE id = ?")) {
                pst.setString(1, nombre);
                pst.setString(2, telefono);
                pst.setString(3, documento);
                pst.setInt(4, id);
                pst.execute();
            }
        }
    }


 public List<Reserva> getReservas() throws SQLException {
        List<Reserva> reservas = new ArrayList<>();
        try (Connection conn = dataSource.getConnection();
             PreparedStatement pst = conn.prepareStatement("SELECT * FROM reserva ORDER BY id");
             ResultSet res = pst.executeQuery()) {            
            while (res.next()) {
                reservas.add(completarReserva(res));
            }
        }
        return reservas;
    }


    private Reserva completarReserva(ResultSet rs) throws SQLException {
        Reserva reserva = new Reserva();
        
        // Set the simple properties
        reserva.setPrecioTotal(rs.getInt("preciototal"));
        reserva.setId(rs.getInt("id"));
        
        // Handle dates - assuming they're stored as timestamps or dates in the database
        java.sql.Date fechaEntrada = rs.getDate("fecha_de_ingreso");
        if (fechaEntrada != null) {
            reserva.setFechaDeEntrada(new java.util.Date(fechaEntrada.getTime()));
        }
        
        java.sql.Date fechaSalida = rs.getDate("fecha_de_salida");
        if (fechaSalida != null) {
            reserva.setFechaDeSalida(new java.util.Date(fechaSalida.getTime()));
        }
        
        // Get the complete Huesped object
        int huespedId = rs.getInt("huesped");
        Huesped huesped = getHuesped(huespedId);
        if (huesped == null) {
            throw new SQLException("Huesped not found with ID: " + huespedId);
        }
        reserva.setHuesped(huesped);
        
        // Get the complete Habitacion object
        String habitacionId = rs.getString("habitacion");
        try {
            Integer idHabitacion = Integer.valueOf(habitacionId);
            Habitacion habitacion = getHabitacionById(idHabitacion);
            if (habitacion == null) {
                throw new SQLException("Habitacion not found with number: " + idHabitacion);
            }
            reserva.setHabitacion(habitacion);
        } catch (NumberFormatException e) {
            // Handle case where habitacion is not a valid number
            throw new SQLException("Invalid habitacion number: " + habitacionId, e);
        }
        
        return reserva;
    }


    public Integer guardarReserva(Integer idHuesped, Integer idHabitacion, String fechaDeEntrada, String fechaDeSalida) throws SQLException {
        try (Connection conn = dataSource.getConnection()) {
            // Get the room to calculate the total price
            Habitacion habitacion = getHabitacionById(idHabitacion);
            if (habitacion == null) {
                throw new SQLException("Habitacion not found with ID: " + idHabitacion);
            }
            
            // Check if guest exists
            Huesped huesped = getHuesped(idHuesped);
            if (huesped == null) {
                throw new SQLException("Huesped not found with ID: " + idHuesped);
            }
            
            // Calculate the number of nights
            java.sql.Date sqlFechaEntrada = java.sql.Date.valueOf(fechaDeEntrada);
            java.sql.Date sqlFechaSalida = java.sql.Date.valueOf(fechaDeSalida);
            
            // Validate that check-in date is in the future
            java.sql.Date today = new java.sql.Date(System.currentTimeMillis());
            if (sqlFechaEntrada.before(today)) {
                throw new SQLException("La fecha de entrada debe ser en el futuro");
            }
            
            long diffInMillies = sqlFechaSalida.getTime() - sqlFechaEntrada.getTime();
            long diffInDays = diffInMillies / (24 * 60 * 60 * 1000);
            
            if (diffInDays <= 0) {
                throw new SQLException("La fecha de salida debe ser posterior a la fecha de entrada");
            }
            
            // Check if the room is available for the selected dates
            if (!isHabitacionDisponible(idHabitacion, fechaDeEntrada, fechaDeSalida)) {
                throw new SQLException("La habitación no está disponible en las fechas seleccionadas");
            }
            
            // Check if the guest is available for the selected dates
            if (!isHuespedDisponible(idHuesped, fechaDeEntrada, fechaDeSalida)) {
                throw new SQLException("El huésped ya tiene una reserva en las fechas seleccionadas");
            }
            
            // Calculate total price
            Integer precioTotal = (int) (diffInDays * habitacion.getPrecioPorNoche());
            
            try (PreparedStatement pst = conn.prepareStatement(
                    "INSERT INTO reserva (huesped, habitacion, fecha_de_ingreso, fecha_de_salida, preciototal) VALUES (?, ?, ?::date, ?::date, ?)",
                    Statement.RETURN_GENERATED_KEYS)) {
                pst.setInt(1, idHuesped);
                pst.setInt(2, idHabitacion);
                pst.setString(3, fechaDeEntrada);
                pst.setString(4, fechaDeSalida);
                pst.setInt(5, precioTotal);
                pst.execute();
                try (ResultSet generated = pst.getGeneratedKeys()) {
                    if (generated.next()) {
                        return generated.getInt(1);
                    } else {
                        throw new SQLException("No se pudo obtener ningún ID.");
                    }
                }
            }
        }
    }

     public Reserva getReserva(Integer id) throws SQLException {
        try (Connection conn = dataSource.getConnection()) {
            try (PreparedStatement pst = conn.prepareStatement("SELECT * FROM reserva WHERE id = ?")) {
                pst.setInt(1, id);
                try (ResultSet res = pst.executeQuery()) {
                    if (res.next()) {
                        Reserva reserva = completarReserva(res);
                        return reserva;
                    } else {
                        return null;
                    }
                }
            }
        }
    }

      public void eliminarReserva(Integer id) throws SQLException {
        try (Connection conn = dataSource.getConnection()) {
            try (PreparedStatement pst = conn.prepareStatement("DELETE FROM reserva WHERE id = ?")) {
                pst.setInt(1, id);
                pst.execute();
            }
        }
    }

    public List<Reserva> getReservasFiltradas(String tipo) throws SQLException {
        List<Reserva> reservas = new ArrayList<>();
        try (Connection conn = dataSource.getConnection()) {
            try (PreparedStatement pst = conn.prepareStatement(
                "SELECT r.* FROM reserva r " +
                "JOIN habitacion h ON r.habitacion = h.id " +
                "WHERE h.tipo = ? ORDER BY r.id")) {
                pst.setString(1, tipo);
                try (ResultSet res = pst.executeQuery()) {            
                    while (res.next()) {
                        reservas.add(completarReserva(res));
                    }
                }
            }
        }
        return reservas;
    }

    public List<Reserva> getReservasPorFecha(String fechaInicio, String fechaFin) throws SQLException {
        List<Reserva> reservas = new ArrayList<>();
        try (Connection conn = dataSource.getConnection()) {
            // Convert string dates to java.sql.Date
            java.sql.Date sqlFechaInicio = java.sql.Date.valueOf(fechaInicio);
            java.sql.Date sqlFechaFin = java.sql.Date.valueOf(fechaFin);
            System.out.println("Buscando reservas entre: " + sqlFechaInicio + " y " + sqlFechaFin); // Debug print
            try (PreparedStatement pst = conn.prepareStatement(
                "SELECT * FROM reserva " +
                "WHERE fecha_de_ingreso <= ? AND fecha_de_salida >= ? " +
                "ORDER BY id")) {
                pst.setDate(1, sqlFechaFin);  // Check-in before search period ends
                pst.setDate(2, sqlFechaInicio);  // Check-out after search period starts
                try (ResultSet res = pst.executeQuery()) {            
                    while (res.next()) {
                        reservas.add(completarReserva(res));
                    }
                }
            }
        }
        return reservas;
    }


    public List<Huesped> getHuespedesNoActivos() throws SQLException {
        List<Huesped> huespedes = new ArrayList<>();
        try (Connection conn = dataSource.getConnection();
             PreparedStatement pst = conn.prepareStatement(
             "SELECT h.* FROM huesped h " +
             "WHERE h.id NOT IN ( " +
             "    SELECT DISTINCT r.huesped FROM reserva r " +
             "    WHERE CURRENT_DATE >= r.fecha_de_ingreso " +
             "    AND CURRENT_DATE < r.fecha_de_salida " +
             ") " +
             "ORDER BY h.id");
             ResultSet res = pst.executeQuery()) {            
            while (res.next()) {
                huespedes.add(completarHuesped(res));
            }
        }
        return huespedes;
    }

    public List<Huesped> getHuespedesDisponibles(String fechaInicio, String fechaFin) throws SQLException {
        List<Huesped> huespedes = new ArrayList<>();
        try (Connection conn = dataSource.getConnection();
             PreparedStatement pst = conn.prepareStatement(
             "SELECT h.* FROM huesped h " +
             "WHERE h.id NOT IN ( " +
             "    SELECT DISTINCT r.huesped FROM reserva r " +
             "    WHERE r.fecha_de_ingreso < ?::date " +
             "    AND r.fecha_de_salida > ?::date " +
             ") " +
             "ORDER BY h.id")) {
            pst.setString(1, fechaFin);
            pst.setString(2, fechaInicio);
            try (ResultSet res = pst.executeQuery()) {            
                while (res.next()) {
                    huespedes.add(completarHuesped(res));
                }
            }
        }
        return huespedes;
    }

    public boolean isHuespedDisponible(Integer idHuesped, String fechaInicio, String fechaFin) throws SQLException {
        try (Connection conn = dataSource.getConnection();
             PreparedStatement pst = conn.prepareStatement(
             "SELECT COUNT(*) FROM reserva r " +
             "WHERE r.huesped = ? " +
             "AND r.fecha_de_ingreso < ?::date " +
             "AND r.fecha_de_salida > ?::date")) {
            pst.setInt(1, idHuesped);
            pst.setString(2, fechaFin);
            pst.setString(3, fechaInicio);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) == 0;
                }
            }
        }
        return false;
    }

      public List<Habitacion> getHabitacionesLibres() throws SQLException {
        List<Habitacion> habitaciones = new ArrayList<>();
        try (Connection conn = dataSource.getConnection();
             PreparedStatement pst = conn.prepareStatement(
             "SELECT h.* FROM habitacion h " +
             "WHERE h.id NOT IN ( " +
             "    SELECT DISTINCT r.habitacion FROM reserva r " +
             "    WHERE CURRENT_DATE >= r.fecha_de_ingreso " +
             "    AND CURRENT_DATE < r.fecha_de_salida " +
             ") " +
             "ORDER BY h.id");
             ResultSet res = pst.executeQuery()) {            
            while (res.next()) {
                habitaciones.add(completarHabitacion(res));
            }
        }
        return habitaciones;
    }

    public List<Habitacion> getHabitacionesDisponibles(String fechaInicio, String fechaFin) throws SQLException {
        List<Habitacion> habitaciones = new ArrayList<>();
        try (Connection conn = dataSource.getConnection();
             PreparedStatement pst = conn.prepareStatement(
             "SELECT h.* FROM habitacion h " +
             "WHERE h.id NOT IN ( " +
             "    SELECT DISTINCT r.habitacion FROM reserva r " +
             "    WHERE r.fecha_de_ingreso < ?::date " +
             "    AND r.fecha_de_salida > ?::date " +
             ") " +
             "ORDER BY h.id")) {
            pst.setString(1, fechaFin);
            pst.setString(2, fechaInicio);
            try (ResultSet res = pst.executeQuery()) {            
                while (res.next()) {
                    habitaciones.add(completarHabitacion(res));
                }
            }
        }
        return habitaciones;
    }

    public boolean isHabitacionDisponible(Integer idHabitacion, String fechaInicio, String fechaFin) throws SQLException {
        try (Connection conn = dataSource.getConnection();
             PreparedStatement pst = conn.prepareStatement(
             "SELECT COUNT(*) FROM reserva r " +
             "WHERE r.habitacion = ? " +
             "AND r.fecha_de_ingreso < ?::date " +
             "AND r.fecha_de_salida > ?::date")) {
            pst.setInt(1, idHabitacion);
            pst.setString(2, fechaFin);
            pst.setString(3, fechaInicio);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) == 0;
                }
            }
        }
        return false;
    }

}
