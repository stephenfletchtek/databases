# {{posts}} Model and Repository Classes Design Recipe


## 1. Design and create the Table

Already created

## 2. Create Test SQL seeds

```sql
-- (file: spec/seeds_{table_name}.sql)
TRUNCATE TABLE posts, user_accounts RESTART IDENTITY;
INSERT INTO posts (title, content, num_views, user_account)
VALUES ('Plutonium in Springfield', 'Today, I will explain howe to mine plutonium from underneath Springfield lake!', '5', '1');
INSERT INTO posts (title, content, num_views, user_account)
VALUES ('Prank my sister', 'I have thought of the best way to prank my baby sister.', '10', '2');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 social_network < seeds.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# Table name: posts

# Model class
# (in lib/post.rb)
class Post
end

# Repository class
# (in lib/post_repository.rb)
class PostRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# Table name: posts

# Model class
# (in lib/post.rb)

class Post
  attr_accessor :id, :title, :content, :user_account_id
end
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

```ruby
# Table name: posts

# Repository class
# (in lib/post_repo.rb)

class PostRepository
  # Selecting all records
  def all
    # Executes the SQL query:
    # SELECT * FROM posts;
    # Returns an array of Post objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT * FROM posts WHERE id = $1;
    # Returns a single Post object.
  end

  def create(post)
    # INSERT INTO posts (title, content, num_views, user_account_id) VALUES ($1, $2, $3, $4)
    # returns nothing
  end

  def update(id, post)
    # UPDATE posts SET (title, content, num_views, user_account_id) = ($1, $2, $3, $4) WHERE id = $5
    # returns nothing
  end

  def delete(post)
    # DELETE FROM posts WHERE id = $1
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# 1
# Get all posts

repo = PostRepository.new
posts = repo.all

posts.length # =>  2

posts[0].id # =>  1
posts[0].title # => 'Plutonium in Springfield'
posts[0].content # => 
# 'Today, I will explain howe to mine plutonium from underneath Springfield lake!'
posts[0].num_views # => '5'
posts[0].user_account_id # => '1'

posts[1].id # =>  2
posts[1].title # => 'Prank my sister'	
posts[1].content # =>
# 'I have thought of the best way to prank my baby sister.'
posts[1].num_views # => '10'
posts[1].user_account_id # => '2'

# 2
# Get a single post

repo = PostRepository.new
post = repo.find(1)[0]

post.id # =>  1
post.title # => 'Plutonium in Springfield'
post.content # =>  
# 'Today, I will explain howe to mine plutonium from underneath Springfield lake!'
post.num_views # => '5'
post.user_account_id # => '1'

# 3
# Create a post
pollute = Post.new
pollute.title = 'Pig poo disposal'
str = 'Simply dump the silos in Springfield lake, no one will ever find out!'
pollute.content = str
pollute.num_views = '20'
pollute.user_account_id = '1'

repo = PostRepository.new
repo.create(pollute)

posts = repo.all
posts.length # => 3

posts[2].id # => '3'
posts[2].title # => pollute.title
posts[2].content # => pollute.content
posts[2].num_views # => pollute.num_views
posts[2].user_account_id # => pollute.user_account_id

# 4
# Update a post
pollute = Post.new
pollute.title # => 'Pig poo disposal'
pollute.content # => 
# 'Simply dump the silos in Springfield lake, no one will ever find out!'
pollute.num_views # => '20'
pollute.user_account_id # => '1'

repo = PostRepository.new
repo.update(1, pollute)

posts = repo.all
posts.length # => 2

posts[1].id # => '1'
posts[1].title # => pollute.title
posts[1].content # => pollute.content
posts[1].num_views # => pollute.num_views
posts[1].user_account_id # => pollute.user_account_id

# 5
# Delete
repo = PostRepository.new
repo.delete(1)

posts = repo.all
posts.length # =>

posts[0].id # =>  2
posts[0].title # => 'Prank my sister'	
posts[0].content # =>
# 'I have thought of the best way to prank my baby sister.'
posts[0].num_views # => '10'
posts[0].user_account_id # => '2'
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# file: spec/post_repository_spec.rb

def reset_posts_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network' })
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

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._