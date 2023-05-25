package com.blog.blog.repository.database;

import com.blog.blog.model.Comment;
import com.blog.blog.model.Post;
import com.blog.blog.model.Tag;
import com.blog.blog.model.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateConnection {
	private static Session session;

	public static Session getSession() {
		if (session != null)
			return session;

		Configuration configuration = new Configuration();
		configuration.configure("hibernate.cfg.xml");
		configuration.addAnnotatedClass(User.class);
		configuration.addAnnotatedClass(Post.class);
		configuration.addAnnotatedClass(Comment.class);
		configuration.addAnnotatedClass(Tag.class);

		SessionFactory sessionFactory = configuration.buildSessionFactory();
		session = sessionFactory.openSession();

		return session;
	}

}
