package com.blog.blog.repository.interfaces;

import java.util.ArrayList;

import com.blog.blog.model.Post;
import com.blog.blog.model.User;

public interface PostRepository {
    public ArrayList<Post> getAll();

    public Post get(int id);

    public Post getByUser(User user);

    public void add(Post post);

    public boolean delete(Post post);

    public void update(Post post);
}
