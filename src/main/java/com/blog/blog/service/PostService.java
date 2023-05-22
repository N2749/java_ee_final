package com.blog.blog.service;

import com.blog.blog.model.Post;
import com.blog.blog.model.User;
import com.blog.blog.repository.implementation.hibernate.PostRepositoryHibernate;
import com.blog.blog.repository.implementation.hibernate.UserRepositoryHibernate;
import com.blog.blog.repository.interfaces.PostRepository;
import com.blog.blog.repository.interfaces.UserRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "postService", value = "/postService")
public class PostService extends HttpServlet {

    PostRepository repository = new PostRepositoryHibernate();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        try {
            switch (action) {
                case "createPost":
                    createPost(req, resp);
                    break;
                case "updatePost":
                    updatePost(req, resp);
                    break;
                case "deletePost":
                    deletePost(req, resp);
                    break;
                default:
                    throw new IllegalArgumentException("Unexpected value: " + action);
            }
        } catch (NullPointerException | IllegalArgumentException e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void deletePost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        //TODO: continue here.............
    }

    private void updatePost(HttpServletRequest req, HttpServletResponse resp) {

    }

    private void createPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String title = req.getParameter("title");
        String text = req.getParameter("text");
        int creator_id = getUserId(req);

        UserRepository userRepository = new UserRepositoryHibernate();
        Post post = new Post(userRepository.getUser(creator_id), title, text);
        repository.addPost(post);

        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        out.println("<html><body>");
        out.println("<h1>You've created something beautiful, excellent, worthy. Congrats!</h1>");
        out.println("<a href=\"/index.jsp\">Go to home page</a>");
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
