package com.blog.blog.repository.interfaces;

import java.util.ArrayList;

import com.blog.blog.model.Post;
import com.blog.blog.model.User;

public interface PostRepository {
    public ArrayList<Post> getAll();

    public Post getPost(int id);

    public Post getPostsByUser(User user);

    public void addPost(Post post);

    public boolean deletePost(Post post);

    public void editPost(Post post);
}
