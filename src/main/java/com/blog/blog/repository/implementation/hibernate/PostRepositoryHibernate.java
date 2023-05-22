package com.blog.blog.repository.implementation.hibernate;

import com.blog.blog.model.Post;
import com.blog.blog.model.User;
import com.blog.blog.repository.database.HibernateConnection;
import com.blog.blog.repository.interfaces.PostRepository;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.ArrayList;

public class PostRepositoryHibernate implements PostRepository {


    Transaction transaction;
    Session session = HibernateConnection.getSession();

    @Override
    public ArrayList<Post> getAll() {
        transaction = session.beginTransaction();
        String query = "from " + Post.class.getSimpleName();
        System.out.println(query);
        ArrayList<Post> posts = (ArrayList<Post>) session.createQuery(query).list();
        transaction.commit();
        return posts;
    }

    @Override
    public Post getPost(int id) {
        transaction = session.beginTransaction();
        Post post = session.get(Post.class, Integer.valueOf(id));
        transaction.commit();
        return post;
    }

    @Override
    public Post getPostsByUser(User user) {
        return null;
    }

    @Override
    public void addPost(Post post) {
        transaction = session.beginTransaction();
        session.save(post);
        transaction.commit();
    }

    @Override
    public boolean deletePost(Post post) {
        return false;
    }

    @Override
    public void editPost(Post post) {

    }
}
