package com.blog.blog.service;

import com.blog.blog.model.User;
import com.blog.blog.repository.implementation.hibernate.UserRepositoryHibernate;
import com.blog.blog.repository.interfaces.UserRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "users", value = "/users")
public class UserService extends HttpServlet {

    UserRepository repository = new UserRepositoryHibernate();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        try {
            switch (action) {
                case "createUser":
                    createUser(req, resp);
                    break;
                case "updateUser":
                    updateUser(req, resp);
                    break;
                case "deleteUser":
                    deleteUser(req, resp);
                    break;
                case "logIn":
                    logIn(req, resp);
                    break;
                case "logOut":
                    logOut(req, resp);
                    break;
                default:
                    throw new IllegalArgumentException("Unexpected value: " + action);
            }
        } catch (NullPointerException | IllegalArgumentException e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void deleteUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = getUserId(req);
        if (id == -1) return;
        repository.delete(id);
        logOut(req, resp);
    }

    private void updateUser(HttpServletRequest req, HttpServletResponse resp) {

    }

    private void createUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String username = req.getParameter("username");
        String login = req.getParameter("login");
        String password = req.getParameter("password");

        User user = new User(username, login, password);
        repository.add(user);

        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        out.println("<html><body>");
        out.println("<h1>Welcome to the club, Buddy!</h1>");
        out.println("<a href=\"/login\">Go to login page</a>");
        out.println("</body></html>");
        out.close();
    }

    int getUserId(HttpServletRequest request) {

        int id = -1;
        Cookie[] cookies = request.getCookies();
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("userId")) {
                id = Integer.parseInt(cookie.getValue());
            }
        }
        return id;
    }


    private void logIn(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String login = req.getParameter("login");
        String password = req.getParameter("password");

        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        if (login.length() == 0 || password.length() == 0) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        UserRepository repository = new UserRepositoryHibernate();
        User user = repository.getUserByLogin(login);
        if (user == null || !user.getPassword().equals(password)) {
            resp.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        Cookie usernameCookie = new Cookie("username", user.getUsername());
        Cookie idCookie = new Cookie("userId", "" + user.getId());
        Cookie isAdminCookie = new Cookie("isAdmin", "" + user.isAdmin());
        Cookie isStaffCookie = new Cookie("isStaff", "" + user.isStaff());
        usernameCookie.setMaxAge(30 * 60);
        isAdminCookie.setMaxAge(30 * 60);
        isStaffCookie.setMaxAge(30 * 60);
        idCookie.setMaxAge(30 * 60);
        resp.addCookie(usernameCookie);
        resp.addCookie(idCookie);
        resp.addCookie(isAdminCookie);
        resp.addCookie(isStaffCookie);
        resp.sendRedirect("/");
    }

    public static void logOut(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Cookie[] cookies = request.getCookies();

        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("user") || cookie.getName().equals("username") || cookie.getName().equals("userId") || cookie.getName().equals("isAdmin") || cookie.getName().equals("isStaff")) {
                cookie.getValue();
                cookie.setMaxAge(0);
                response.addCookie(cookie);
                continue;
            }
        }
        response.sendRedirect("/blog");
    }
}
