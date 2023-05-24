package com.blog.blog.repository.interfaces;

import com.blog.blog.model.Post;
import com.blog.blog.model.Tag;

import java.util.ArrayList;

public interface TagRepository {
    public ArrayList<Tag> getAll();

    public Tag get(int id);

    public Tag getByPost(Post post);

    public void add(Tag tag);

    public boolean delete(Tag tag);

    public void update(Tag tag);
}
