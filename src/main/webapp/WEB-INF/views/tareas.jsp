<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Gestión de Tareas</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 2rem; background: #f5f7fb; }
        .card { max-width: 760px; margin: 0 auto; background: #fff; border-radius: 12px; padding: 1.5rem; box-shadow: 0 6px 20px rgba(0,0,0,.08); }
        h1 { margin-top: 0; }
        form { margin-bottom: 1rem; }
        input[type="text"] { width: 70%; padding: .65rem; border: 1px solid #cfd8e3; border-radius: 8px; }
        button { border: 0; background: #0d6efd; color: #fff; padding: .65rem .9rem; border-radius: 8px; cursor: pointer; }
        .danger { background: #dc3545; }
        ul { list-style: none; padding: 0; }
        li { display: flex; justify-content: space-between; align-items: center; border: 1px solid #e3e8ef; margin-bottom: .6rem; padding: .65rem .8rem; border-radius: 8px; }
        .muted { color: #6c757d; }
    </style>
</head>
<body>
<div class="card">
    <h1>Gestión de Tareas</h1>

    <form action="${pageContext.request.contextPath}/tareas" method="post">
        <input type="hidden" name="accion" value="agregar" />
        <input type="text" name="nuevaTarea" placeholder="Escribe una tarea" required />
        <button type="submit">Agregar</button>
    </form>

    <c:choose>
        <c:when test="${empty tareas}">
            <p class="muted">No hay tareas registradas.</p>
        </c:when>
        <c:otherwise>
            <ul>
                <c:forEach items="${tareas}" var="tarea" varStatus="status">
                    <li>
                        <span>${status.index + 1}. ${tarea}</span>
                        <form action="${pageContext.request.contextPath}/tareas" method="post" style="margin:0;">
                            <input type="hidden" name="accion" value="eliminar" />
                            <input type="hidden" name="indice" value="${status.index}" />
                            <button class="danger" type="submit">Eliminar</button>
                        </form>
                    </li>
                </c:forEach>
            </ul>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
