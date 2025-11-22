package progweb3;

public class Libro {

    private Integer id;

    private String titulo;

    private Integer lanzamiento;

    private Autor autor;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public Integer getLanzamiento() {
        return lanzamiento;
    }

    public void setLanzamiento(Integer lanzamiento) {
        this.lanzamiento = lanzamiento;
    }

    public Autor getAutor() {
        return autor;
    }

    public void setAutor(Autor autor) {
        this.autor = autor;
    }

}
