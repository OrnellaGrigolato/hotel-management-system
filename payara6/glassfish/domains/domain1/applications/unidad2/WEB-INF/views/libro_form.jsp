<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Agregar libro</title>
    </head>
    <body>
        <h1>Nuevo libro de ${a.apellido}, ${a.nombre}:</h1>
        <form method="post" action="${mvc.uri('guardarLibro', {'id': a.id})}">
            <div>
                <label>Título: <input type="text" name="titulo"></label>
                <label>Año de lanzamiento:<input type="numeric" name="lanzamiento"></label>
            </div>
            <button type="submit">Guardar</button>
        </form>
    </body>
</html>
