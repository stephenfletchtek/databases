# Two Tables Design Recipe Template

## 1. Extract nouns from the user stories or specification

```
As a blogger
So I can write interesting stuff
I want to write posts having a title.

As a blogger
So I can write interesting stuff
I want to write posts having a content.

As a blogger
So I can let people comment on interesting stuff
I want to allow comments on my posts.

As a blogger
So I can let people comment on interesting stuff
I want the comments to have a content.

As a blogger
So I can let people comment on interesting stuff
I want the author to include their name in comments.
```

```
Nouns:

post, title, content
comment, content, author
```

## 2. Infer the Table Name and Columns


| Record                | Properties          |
| --------------------- | ------------------- |
| post                  | title, content      |
| comment               | content, author     |


1. Name of the first table (always plural): `posts` 

    Column names: `title`, `content`

2. Name of the second table (always plural): `comments` 

    Column names: `content`, `author`

## 3. Decide the column types.

```
Table: posts
id: SERIAL
title: text
content: text

Table: comments
id: SERIAL
content: text
author: text
```

## 4. Decide on The Tables Relationship

```
1. Can one post have many comments? YES
2. Can one comment have many posts? NO

-> Therefore,
-> A post HAS MANY comments
-> An comment BELONGS TO a post

-> Therefore, the foreign key is on the comments table.
```

## 4. Write the SQL.

```sql
-- file: posts_comments_table.sql

-- Create the table without the foreign key first.
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text
);

-- Then the table with the foreign key first.
CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  content text,
  author text,
-- The foreign key name is always {other_table_singular}_id
  post_id int,
  constraint fk_post foreign key(post_id)
    references posts(id)
    on delete cascade
);
```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 blog < posts_comments_table.sql
```