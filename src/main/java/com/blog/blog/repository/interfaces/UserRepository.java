package com.blog.blog.repository.interfaces;

import java.util.ArrayList;

import com.blog.blog.model.User;

public interface UserRepository {
	public ArrayList<User> getAll();
	public User get(int id);
	public User getUserByLogin(String login);
	public void add(User user);
	public boolean delete(int id);
	public void update(User user);
}