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
    public ArrayList<User> getUsers() {
        transaction = session.beginTransaction();
        String query = "from " + User.class.getSimpleName();
        System.out.println(query);
        ArrayList<User> users = (ArrayList<User>) session.createQuery(query).list();
        transaction.commit();
        return users;
    }

    @Override
    public User getUser(int id) {
        transaction = session.beginTransaction();
        User user = session.get(User.class, Integer.valueOf(id));
        transaction.commit();
        return user;
    }

    @Override
    public User getUserByLogin(String login) {
        return (User) session.createQuery("FROM User WHERE login LIKE '" + login + "'").getResultList().get(0);
    }

    @Override
    public void addUser(User user) {
        transaction = session.beginTransaction();
        System.out.println(user.toString());
        session.save(user);
        transaction.commit();
    }

    @Override
    public boolean deleteUser(int id) {
        return false;
    }

    @Override
    public boolean editUser(User student) {
        return false;
    }
}
