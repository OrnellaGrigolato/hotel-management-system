package progweb3;

public class Habitacion {

    private Integer id;

    private Integer numero;

    private String tipo;

    private Integer precioPorNoche;

    private String estado = "disponible"; // "disponible" o "ocupada"


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getNumeroDeHabitacion() {
        return numero;
    }

    public void setNumeroDeHabitacion(Integer numero) {
        this.numero = numero;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public Integer getPrecioPorNoche() {
        return precioPorNoche;
    }

    public void setPrecioPorNoche(Integer precioPorNoche) {
        this.precioPorNoche = precioPorNoche;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
}
