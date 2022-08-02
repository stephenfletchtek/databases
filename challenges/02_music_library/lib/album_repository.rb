require_relative 'album'

class AlbumRepository
  def all
    sql = 'SELECT id, title, release_year, artist_id FROM albums;'
    result_set = DatabaseConnection.exec_params(sql, [])
    result_set.map { |record| make_album(record) }
  end

  def find(id)
    sql = "SELECT * FROM albums WHERE id = #{id}"
    result = DatabaseConnection.exec_params(sql, [])[0]
    make_album(result)
  end

  def create(title, release_year, artist_id)
    sql = "INSERT INTO albums (title, release_year, artist_id) VALUES ('#{title}', '#{release_year}', '#{artist_id}');"
    DatabaseConnection.exec_params(sql, [])
  end

  def update(id, col, new_value)
    sql = "UPDATE albums SET #{col} = '#{new_value}' WHERE id = #{id};"
    DatabaseConnection.exec_params(sql, [])
  end

  def delete(id)
    sql = "DELETE FROM albums WHERE id = #{id};"
    DatabaseConnection.exec_params(sql, [])
  end

  private

  def make_album(record)
    album = Album.new
    album.id = record['id']
    album.title = record['title']
    album.release_year = record['release_year']
    album.artist_id = record['artist_id']
    album
  end
end