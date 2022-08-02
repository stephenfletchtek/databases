# Model and Repository Classes Design Recipe

## 1. Design and create the Table

Aleady done

## 2. Create Test SQL seeds

Seeds are provided

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

```ruby
# EXAMPLE
# Table name: books

# Model class
# (in lib/book.rb)
class Book
end

# Repository class
# (in lib/book_repository.rb)
class BookRepository
end
```

## 4. Implement the Model class

```ruby
# EXAMPLE
# Table name: books

# Model class
# (in lib/book.rb)

class Book
  attr_accessor :id, :title, :author_name
end

# id is primary key
```

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: books

# Repository class
# (in lib/book_repository.rb)

class BookRepository

  # Selecting all records
  # No arguments
  def all
    # SELECT * FROM books;
    # Returns an array of Book objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # SELECT * FROM books WHERE id = #{id}#;
    # Returns a single Student object.
  end

  def create(title, author_name)
    # INSERT INTO books (title, author_name) VALUES (#{title}, #{author_name})
    # returns nothing
  end

  def update(id, column, value)
    # UPDATE books SET #{column} = #{value} where id = #{id}
    # returns nothing
  end

  def delete(id)
    # DELETE FROM books WHERE id = #{id}
    # returns nothing
  end
end
```

## 6. Write Test Examples

```ruby
# 1
# Get all books
repo = BookRepository.new
books = repo.all
books.length # =>  5
book[0].id # =>  1
book[0].title # =>  'Nineteen Eighty-Four'
book[0].author_name # =>  'George Orwell'
book[1].id # =>  2
book[1].title # =>  'Mrs Dalloway'
book[1].author_name # =>  'Virginia Woolf'

# 2
# Get a single book
repo = BookRepository.new
book = repo.find(1)
book.id # =>  1
book.title # =>  'Nineteen Eighty-Four'
book.author_name # =>  'George Orwell'

# 3
# Create a book
repo = BookRepository.new
book.create('Catch 22', 'Joseph Heller' )
books = repo.all
books.length # =>  6
book[-1].id # =>  6
book[-1].title # =>  'Catch 22'
book[-1].author_name # =>  'Joseph Heller'

# 4
# Update book
repo = BookRepository.new
repo.update(1, 'title', 1984)
book = repo.find(1)
book.title # => "1984"

# 5
# Delete book
repo = BookRepository.new
repo.delete(1)
books = repo.all
books.length # => 4
repo.find(1) # => nil
```

## 7. Reload the SQL seeds before each test run

```ruby
# file: spec/book_repository_spec.rb

def reset_book_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store_test' })
  connection.exec(seed_sql)
end

describe BookRepository do
  before(:each) do 
    reset_book_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._