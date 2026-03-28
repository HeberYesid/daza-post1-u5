package com.ejemplo.gestiontareas.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@WebServlet("/tareas")
public class TareaServlet extends HttpServlet {

    private final List<String> tareas = Collections.synchronizedList(new ArrayList<>());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("tareas", new ArrayList<>(tareas));
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/tareas.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String accion = request.getParameter("accion");

        if ("agregar".equals(accion)) {
            String nuevaTarea = request.getParameter("nuevaTarea");
            if (nuevaTarea != null) {
                String limpia = nuevaTarea.trim();
                if (!limpia.isEmpty()) {
                    tareas.add(limpia);
                }
            }
            response.sendRedirect(request.getContextPath() + "/tareas");
            return;
        }

        if ("eliminar".equals(accion)) {
            String indiceTexto = request.getParameter("indice");
            try {
                int indice = Integer.parseInt(indiceTexto);
                if (indice >= 0 && indice < tareas.size()) {
                    tareas.remove(indice);
                }
            } catch (NumberFormatException ignored) {
                // Ignora valores no numericos para mantener respuesta robusta.
            }
            response.sendRedirect(request.getContextPath() + "/tareas");
            return;
        }

        response.sendRedirect(request.getContextPath() + "/tareas");
    }
}
