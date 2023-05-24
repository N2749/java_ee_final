package com.blog.blog.service;

import com.blog.blog.model.Tag;
import com.blog.blog.repository.implementation.hibernate.TagRepositoryHibernate;
import com.blog.blog.repository.implementation.hibernate.UserRepositoryHibernate;
import com.blog.blog.repository.interfaces.TagRepository;
import com.blog.blog.repository.interfaces.UserRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "tagService", value = "/tagService")
public class TagService extends HttpServlet {

    TagRepository repository = new TagRepositoryHibernate();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            switch (action) {
                case "createTag":
                    createTag(req, resp);
                    break;
                case "updateTag":
                    updateTag(req, resp);
                    break;
                case "deleteTag":
                    deleteTag(req, resp);
                    break;
                default:
                    throw new IllegalArgumentException("Unexpected value: " + action);
            }
        } catch (NullPointerException | IllegalArgumentException e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void deleteTag(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String tagId = req.getParameter("tagId");

        Tag tag = repository.get(Integer.parseInt(tagId));
        repository.delete(tag);

        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        out.println("<html><body>");
        out.println("<h1>All the things we care about will perish eventually, sooner or later</h1>");
        out.println("<a href=\"/blog_war_exploded\">Go to home page</a>");
        out.println("</body></html>");
        out.close();
    }

    private void updateTag(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String name = req.getParameter("tagName");
        String tagId = req.getParameter("tagId");

        Tag tag = repository.get(Integer.parseInt(tagId));
        tag.setName(name);
        repository.update(tag);

        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        out.println("<html><body>");
        out.println("<h1>All of us commit mistakes. Don't blame yourself, it just happens</h1>");
        out.println("<a href=\"/blog_war_exploded\">Go to home page</a>");
        out.println("</body></html>");
        out.close();
    }

    private void createTag(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String name = req.getParameter("tagName");

        UserRepository userRepository = new UserRepositoryHibernate();
        Tag tag = new Tag(name);
        repository.add(tag);

        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        out.println("<html><body>");
        out.println("<h1>You've created something worthy. Congrats!</h1>");
        out.println("<a href=\"/blog_war_exploded\">Go to home page</a>");
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
}
