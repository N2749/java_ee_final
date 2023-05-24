package com.blog.blog.utils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.stream.IntStream;

@WebServlet(name = "AppExceptionHandler", value = "/AppExceptionHandler")
public class AppExceptionHandler extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processError(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processError(request, response);
    }

    int[] statusCodesWithPages = {404, 401, 500};

    private void processError(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        // Analyze the servlet exception

        Throwable throwable = (Throwable) req.getAttribute("jakarta.servlet.error.exception");
        Integer statusCode = (Integer) req.getAttribute("jakarta.servlet.error.status_code");
        String servletName = (String) req.getAttribute("jakarta.servlet.error.servlet_name");
        if (servletName == null) {
            servletName = "Unknown";
        }
        String requestUri = (String) req.getAttribute("javax.servlet.error.request_uri");
        if (requestUri == null) {
            requestUri = "Unknown";
        }

        if (IntStream.of(statusCodesWithPages).anyMatch(x -> x == statusCode)) {
            req.getRequestDispatcher("/pages/exceptions/" + statusCode + ".html").forward(req, resp);
        } else {
            // Set response content type
            resp.setContentType("text/html");

            PrintWriter out = resp.getWriter();
            out.write("<html><head><title>Exception/Error Details</title></head><body>");
            out.write("<h3>Exception Details</h3>");
            out.write("<ul><li>Servlet Name:" + servletName + "</li>");
            out.write("<li>Exception Name:" + throwable.getClass().getName() + "</li>");
            out.write("<li>Requested URI:" + requestUri + "</li>");
            out.write("<li>Exception Message:" + throwable.getMessage() + "</li>");
            out.write("</ul>");
            out.write("<br><br>");
            out.write("<a href=\"index.html\">Home Page</a>");
            out.write("</body></html>");
        }

    }

}
