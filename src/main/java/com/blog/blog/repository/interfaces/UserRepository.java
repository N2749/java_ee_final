package com.blog.blog.repository.interfaces;

import java.util.ArrayList;

import com.blog.blog.model.User;

public interface UserRepository {
	public ArrayList<User> getUsers();
	public User getUser(int id);
	public User getUserByLogin(String login);
	public void addUser(User user);
	public boolean deleteUser(int id);
	public boolean editUser(User user);
}