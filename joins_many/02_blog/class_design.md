# Cohort Model and Repository Classes Design Recipe

## 1. Design and create the Table

Already done

## 2. Create Test SQL seeds

```sql
TRUNCATE TABLE posts, comments RESTART IDENTITY;
INSERT INTO posts (title, content) VALUES ('Monday', 'I learned some databases');
INSERT INTO posts (title, content) VALUES ('Tuesday', 'I fed an axylotl');
INSERT INTO posts (title, content) VALUES ('Wednesday', 'It poured with rain');
INSERT INTO comments (content, author, post_id) VALUES ('Boring!', 'Bart Simpson', 1);
INSERT INTO comments (content, author, post_id) VALUES ('Whats an axylotl?', 'Homer Simpson', 2);
INSERT INTO comments (content, author, post_id) VALUES ('Thatth Thweet', 'Daffy Duck', 2);
INSERT INTO comments (content, author, post_id) VALUES ('I went for a swim', 'Goldilocks', 3);
INSERT INTO comments (content, author, post_id) VALUES ('Snap!', 'Big Bad Wolf', 1);
INSERT INTO comments (content, author, post_id) VALUES ('What is a database?', 'Red Riding Hood', 1);
```

```bash
psql -h 127.0.0.1 blog < spec/seeds.sql
```

## 3. Define the class names

```ruby
# Table name: posts

# Model class
# (in lib/post.rb)
class Post
end

# Repository class
# (in lib/post_repo.rb)
class PostRepository
end
```

## 4. Implement the Model class

```ruby
# Table name: posts
# Model class
# (in lib/post.rb)

class Post
  attr_accessor :id, :title, :content, :comments
end
```

## 5. Define the Repository Class interface

```ruby
# Table name: posts
# Repository class
# (in lib/post_repo.rb)

class PostRepository
  # find_with_comments method
  def find_with_comments(id)
    # SQL 'SELECT posts.id,
    #             posts.title, 
    #             posts.content,
    #             comments.id AS comment_id,
    #             comments.content AS comment_content,
    #             comments.author
    #     FROM posts JOIN comments
    #     ON comments.post_id = post.id
    #     WHERE posts.id = $1;'

    # returns a post object containing related comments
  end
end
```

## 6. Write Test Examples

```ruby
# 1 Get post with comments

repo = PostRepository.new
post = repo.find_with_comments(1)
post.title # => 'Monday'
post.comments.length # => 2
post.comments[0].author # => 'Bart Simpson'
```

## 7. Reload the SQL seeds before each test run

```ruby
# file: spec/post_repository_spec.rb

def reset_posts_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'blog' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do
    reset_posts_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_Used the test-driving process of red, green, refactor to implement the behaviour._