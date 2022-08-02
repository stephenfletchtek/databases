# Model and Repository Classes Design Recipe

## 1. Design and create the Table

Already done

## 2. Create Test SQL seeds

Seed data is provided

```bash
psql -h 127.0.0.1 music_library_test < spec/seeds.sql
```

## 3. Define the class names

```ruby
# Table name: albums

# Model class
# (in lib/album.rb)
class Album
  
# Repository class
# (in lib/album_repository.rb)
class AlbumRepository
```

## 4. Implement the Model class

```ruby
# Table name: albums

# Model class
# (in lib/album.rb)
class Album
  attr_accessor :id, :title, :release_year, :artist_id
end
```

## 5. Define the Repository Class interface

```ruby
# Repository class
# (in lib/album_repository.rb)
class AlbumRepository
  def all
    # SELECT id, name, release_year, artist_id FROM albums;
    # return an array of album objects
  end

  def find(id)
    # SELECT * FROM albums WHERE id = id;
    # Return album object found
  end

  def create(title, release_year, artist_id)
    # INSERT INTO albums (title, release_year, artist_id) VALUES (title, release_year, artist_id);
    # returns nothing
  end

  def update(album_id, col, val)
    # UPDATE albums SET col = val WHERE album_id = album_id;
    # returns nothing
  end

  def delete(album_id)
    # DELETE FROM albums WHERE album_id = album_id;
    # returns nothing
  end
end
```

## 6. Write Test Examples

```ruby
# 1
# Get all albums
repo = AlbumRepository.new
albums = repo.all
albums.length # =>  12
albums[0].id # =>  1
albums[0].title # =>  'Doolittle'
albums[0].release_year # =>  1989
albums[0].artist_id # => 1

# 2
# Get a single album
repo = StudentRepository.new
album = repo.find(2)
album.id # =>  2
album.title # =>  'Surfer Rosa'
album.release_year # =>  1988
album.artist_id # => 1

# 3
# Create an album
repo = AlbumRepository.new
repo.create('Revolver', 1966, 5)
albums = repo.all
albums.length # =>  13
albums.last.id # =>  13
albums.last.title # =>  'Revolver'
albums.last.release_year # =>  1966
albums.last.artist_id # => 5

# 4
# Update an album
repo = AlbumRepository.new
repo.update(1, "release_year", 2000)
album = repo.find(1)
album.release_year # =>  2000

# 5
# Delete an album
repo = AlbumRepository.new
repo.delete(1)
albums = repo.all
albums.length # =>  11
repo.find(1) # => ???????


```
## 7. Reload the SQL seeds before each test run

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_album_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

describe AlbumRepository do
  before(:each) do
    reset_album_table
  end

  # (your tests will go here).

end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
