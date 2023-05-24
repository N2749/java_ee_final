package com.blog.blog.repository.implementation.hibernate;

import com.blog.blog.model.User;
import com.blog.blog.repository.database.HibernateConnection;
import com.blog.blog.repository.interfaces.UserRepository;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.ArrayList;


public class UserRepositoryHibernate implements UserRepository {

    Transaction transaction;
    Session session = HibernateConnection.getSession();

    @Override
    public ArrayList<User> getAll() {
        String query = "from " + User.class.getSimpleName();
        ArrayList<User> users = (ArrayList<User>) session.createQuery(query).list();
        return users;
    }

    @Override
    public User get(int id) {
        User user = session.get(User.class, id);
        return user;
    }

    @Override
    public User getUserByLogin(String login) {
        return (User) session.createQuery("FROM User WHERE login LIKE '" + login + "'").getResultList().get(0);
    }

    @Override
    public void add(User user) {
        transaction = session.beginTransaction();
        session.save(user);
        transaction.commit();
    }

    @Override
    public boolean delete(int id) {
//        TODO: continue here
        return false;
    }

    @Override
    public void update(User user) {
//        TODO: figure out the way to know if edit was successful or not
        transaction = session.beginTransaction();
        session.update(user);
        transaction.commit();
    }
}
