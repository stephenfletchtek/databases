# {cohort} Model and Repository Classes Design Recipe

## 1. Design and create the Table

Already done

## 2. Create Test SQL seeds

```sql
TRUNCATE TABLE students, cohorts RESTART IDENTITY;
INSERT INTO cohorts (name, starting_date) VALUES ('june22', '15/06/22');
INSERT INTO cohorts (name, starting_date) VALUES ('july22', '18/07/22');
INSERT INTO cohorts (name, starting_date) VALUES ('august22', '04/08/22');
INSERT INTO students (name, cohort_id) VALUES ('Bart Simpson', 1);
INSERT INTO students (name, cohort_id) VALUES ('Homer Simpson', 2);
INSERT INTO students (name, cohort_id) VALUES ('Daffy Duck', 2);
INSERT INTO students (name, cohort_id) VALUES ('Goldilocks', 3);
INSERT INTO students (name, cohort_id) VALUES ('Big Bad Wolf', 3);
INSERT INTO students (name, cohort_id) VALUES ('Red Riding Hood', 3);
```

```bash
psql -h 127.0.0.1 student_directory_2< seeds.sql
```

## 3. Define the class names

```ruby
# Table name: cohorts

# Model class
# (in lib/cohort.rb)
class Cohort
end

# Repository class
# (in lib/cohort_repo.rb)
class CohortRepository
end
```

## 4. Implement the Model class

```ruby
# EXAMPLE
# Table name: cohorts

# Model class
# (in lib/cohort.rb)

class Cohort
  attr_accessor :id, :name, :starting_date, :students
end
```

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: albums

# Repository class
# (in lib/album_repository.rb)

class AlbumRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT * FROM albums;

    # Returns an array of Album objects.
  end

  def find(id)
    # Executes the SQL query:
    # SELECT * FROM albums WHERE id = $1;

    # Returns an album object of Album objects.
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all albums

repo = AlbumRepository.new

albums = repo.all

albums.length # =>  2

albums.first.id # =>  '1'
albums.first.title # =>  'Motomami'
albums.first.release_year # =>  '2022'
albums.first.artist_id # =>  '1'

albums.second.id # =>  '2'
albums.second.title # =>  'In Colour'
albums.second.release_year # =>  '2022'
albums.second.artist_id # =>  '2'

# 2
# Get a album based on an id

repo = AlbumRepository.new

album = repo.find(1)

album.id # =>  '1'
album.title # =>  'Motomami'
album.release_year # =>  '2022'
album.artist_id # =>  '1'

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/albums_repository_spec.rb

def reset_albums_table
  seed_sql = File.read('spec/seeds_albums.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

describe AlbumRepository do
  before(:each) do
    reset_albums_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._