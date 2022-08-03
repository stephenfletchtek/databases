require_relative 'album'

class AlbumRepository
  def all
    sql = 'SELECT * FROM albums;'
    result = DatabaseConnection.exec_params(sql, [])

    albums = []
    result.each do |record|
      albums << make_album(record)
    end
    
    return albums
  end

  def find(id)
    sql = 'SELECT * FROM albums WHERE id = $1;'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)[0]
    return make_album(result)
  end

  def create(album)
    sql = 'INSERT INTO albums (title, release_year, artist_id) VALUES ($1, $2, $3)'
    params = [album.title, album.release_year, album.artist_id]
    DatabaseConnection.exec_params(sql, params)
    return    
  end
  
  private

  def make_album(result)
    album = Album.new
    album.id = result['id']
    album.title = result['title']
    album.release_year = result['release_year']
    album.artist_id = result['artist_id']
    return album
  end
end