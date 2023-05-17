## REQUIERMENTS:
- Usage of Hibernate ORM (you should have at least 5 tables in your DB, and have different types of mapping, wherever it is necessary (one to one, many to one and so on));
- Your web app should have admin page with CRUD operations over your models;
- Your web app should have some minimalistic design;

## Backlog

---
### authorization / authentication
Possible solution is to use cookies and store user_id, is_admin, is_staff. Idk how to work with sessions

---
### add hibernate models according to tables below (in models package)

users
```
id                     INT
login                  VARCHAR(64)
username               VARCHAR(16)
password               VARCHAR(16)
is_admin               INT
is_staff               INT
```
posts
```
id                     INT
text                   TEXT
created_by             INT (FK users)
created_at             DATETIME
updated_at             DATETIME
```
comments
```
id                     INT
created_by             INT (FK users)
post_id                INT (FK posts)
text                   VARCHAR(1000)
rating                 INT
parent_comment         INT (FK comments)
created_at             DATETIME
updated_at             DATETIME
```
tags
```
id                     INT
title                  VARCHAR(20)
```
posts_tags
```
post_id                INT (FK posts)
tag_id                 INT (FK tags)
```
users_comments_rating
```
user_id                INT (FK users)
comment_id             INT (FK comment)
direction              INT
```
---
### pages
- _login / register_ speaks for itself
- _add / edit post_ fields mentioned above is filled, when edited `changed_at` sets now, if possible
- _profile page (with posts if admin/ comments)_ depending on `is_staff` show list of posts created by user
- _post_ show post text, date, user who created form for comments
- _admin page_ edit all pages: users, posts, tags, comments
---
### filter
add filter on showing comment form, so just regular users can see posts