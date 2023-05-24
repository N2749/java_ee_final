package com.blog.blog.repository.implementation.hibernate;

import com.blog.blog.model.Post;
import com.blog.blog.model.Tag;
import com.blog.blog.repository.database.HibernateConnection;
import com.blog.blog.repository.interfaces.TagRepository;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.ArrayList;

public class TagRepositoryHibernate implements TagRepository {


    Transaction transaction;
    Session session = HibernateConnection.getSession();

    @Override
    public ArrayList<Tag> getAll() {
        String query = "from " + Tag.class.getSimpleName();
        ArrayList<Tag> tags = (ArrayList<Tag>) session.createQuery(query).list();
        return tags;
    }

    @Override
    public Tag get(int id) {
        transaction = session.beginTransaction();
        Tag tag = session.get(Tag.class, Integer.valueOf(id));
        transaction.commit();
        return tag;
    }

    @Override
    public Tag getByPost(Post post) {
        return null;
    }

    @Override
    public void add(Tag tag) {
        transaction = session.beginTransaction();
        session.save(tag);
        transaction.commit();
    }

    @Override
    public boolean delete(Tag tag) {
        transaction = session.beginTransaction();
        session.delete(tag);
        transaction.commit();
        return false;
    }

    @Override
    public void update(Tag tag) {
        transaction = session.beginTransaction();
        session.update(tag);
        transaction.commit();
    }
}
