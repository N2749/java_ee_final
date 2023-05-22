package com.blog.blog.model;

import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Entity(name = "User")
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column
    private String username;
    @Column
    private String login;
    @Column
    private String password;
    @Column
    private boolean isAdmin;
    @Column
    private boolean isStaff;
    @OneToMany(
            mappedBy = "creator",
            cascade = CascadeType.ALL,
            orphanRemoval = true
    )
    private List<Post> posts = new ArrayList<>();

    public User(String username, String login, String password) {
        this.username = username;
        this.login = login;
        this.password = password;
        this.isAdmin = false;
        this.isStaff = false;
    }

    public User() {
        this.username = "";
        this.login = "";
        this.password = "";
        this.isAdmin = false;
        this.isStaff = false;

    }

    public boolean isAdmin() {
        return isAdmin;
    }

    public void setAdmin(boolean admin) {
        isAdmin = admin;
    }

    public boolean isStaff() {
        return isStaff;
    }

    public void setStaff(boolean staff) {
        isStaff = staff;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void addPost(Post post) {
        this.posts.add(post);
        post.setCreator(this);
    }

    public void deletePost(Post post) {
        this.posts.remove(post);
        post.setCreator(null);
    }

    @Override
    public String toString() {
        return "User{" +
               "id=" + id +
               ", username='" + username + '\'' +
               ", login='" + login + '\'' +
               ", password='" + password + '\'' +
               ", isAdmin=" + isAdmin +
               ", isStaff=" + isStaff +
               '}';
    }
}
