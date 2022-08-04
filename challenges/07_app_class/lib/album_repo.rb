require_relative 'album'

class AlbumRepository
  def all
    sql = 'SELECT * FROM albums;'
    result = DatabaseConnection.exec_params(sql, [])
    result.map { |record| make_album(record) }
  end

  def find(id)
    sql = 'SELECT * FROM albums WHERE id = $1;'
    result = DatabaseConnection.exec_params(sql, [id])
    result.map { |record| make_album(record) }[0]
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