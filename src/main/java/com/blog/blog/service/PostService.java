package com.blog.blog.service;

import com.blog.blog.model.Post;
import com.blog.blog.model.Tag;
import com.blog.blog.repository.implementation.hibernate.PostRepositoryHibernate;
import com.blog.blog.repository.implementation.hibernate.TagRepositoryHibernate;
import com.blog.blog.repository.implementation.hibernate.UserRepositoryHibernate;
import com.blog.blog.repository.interfaces.PostRepository;
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
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

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
        String postId = req.getParameter("postId");

        Post post = repository.get(Integer.parseInt(postId));
        repository.delete(post);

        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        out.println("<html><body>");
        out.println("<h1>All the things we care about will perish eventually, sooner or later</h1>");
        out.println("<a href=\"/blog_war_exploded\">Go to home page</a>");
        out.println("</body></html>");
        out.close();
    }

    private void updatePost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        System.out.println("hererrrrr");
        String title = req.getParameter("title");
        String text = req.getParameter("text");
        String postId = req.getParameter("postId");
        String[] tagsIds = req.getParameterValues("tags");
        Arrays.stream(tagsIds).forEach(System.out::println);
        List<Tag> tags = new ArrayList<>();
        TagRepository tagRepository = new TagRepositoryHibernate();
        for (String s : tagsIds) {
            tags.add(tagRepository.get(Integer.parseInt(s)));
        }
        tags.stream().forEach(System.out::println);

        Post post = repository.get(Integer.parseInt(postId));
        post.setTitle(title);
        post.setText(text);
        post.setTags(tags);
        repository.update(post);

        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        out.println("<html><body>");
        out.println("<h1>All of us commit mistakes. Don't blame yourself, it just happens</h1>");
        out.println("<a href=\"/blog_war_exploded\">Go to home page</a>");
        out.println("</body></html>");
        out.close();
    }

    private void createPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String title = req.getParameter("title");
        String text = req.getParameter("text");
        String[] tagsIds = req.getParameterValues("tags");

        int creator_id = getUserId(req);

        UserRepository userRepository = new UserRepositoryHibernate();

        List<Tag> tags = new ArrayList<>();
        TagRepository tagRepository = new TagRepositoryHibernate();

        for (String s : tagsIds) {
            tagRepository.get(Integer.parseInt(s));
        }

        Post post = new Post(userRepository.get(creator_id), title, text, tags);

        repository.add(post);

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
