package com.blog.blog.model;

import jakarta.persistence.*;

import java.util.List;

@Entity(name = "Post")
@Table(name = "posts")
public class Post {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne(fetch = FetchType.LAZY)
    private User creator;
    @Column
    private String title;
    @Column
    String text;

    @ManyToMany
    @JoinTable(name="posts")
    List<Tag> tags;

    public Post(User creator, String title, String text) {
        this.creator = creator;
        this.title = title;
        this.text = text;
    }

    public Post() {

    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public User getCreator() {
        return creator;
    }

    public void setCreator(User creator) {
        this.creator = creator;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }
}
