# These commands given during exercise

# 1. Setup
```bash
createdb blog_2
psql -h 127.0.0.1 blog_2 < blog_posts_tags.sql
```

# 2. Select example
```sql
SELECT tags.id, tags.name
  FROM tags
    JOIN posts_tags ON posts_tags.tag_id = tags.id
    JOIN posts ON posts_tags.post_id = posts.id
    WHERE posts.id = 2;
```

# 3. Exercise One
```sql
SELECT posts.id, posts.title
  FROM posts
    JOIN posts_tags ON posts_tags.post_id = posts.id
    JOIN tags ON posts_tags.tag_id = tags.id
    WHERE tags.id = 2;
```

# 4. Challenge
```sql
INSERT INTO tags (name) VALUES ('sql');
INSERT INTO posts_tags (post_id, tag_id) VALUES (7, 5);

SELECT posts.id, posts.title
  FROM posts
    JOIN posts_tags ON posts_tags.post_id = posts.id
    JOIN tags ON posts_tags.tag_id = tags.id
      WHERE tags.id = 5;
```