require_relative 'artist'

class ArtistRepository
  def all
    sql = 'SELECT * FROM artists;'
    result = DatabaseConnection.exec_params(sql, [])
    result.map { |record| make_artist(record) }
  end

  def find(id)
    sql = 'SELECT * FROM albums WHERE id = $1;'
    result = DatabaseConnection.exec_params(sql, [id])
    result.map { |record| make_artist(record) }[0]
  end

  private

  def make_artist(result)
    artist = Artist.new
    artist.id = result['id']
    artist.name = result['name']
    artist.genre = result['genre']
    return artist
  end
end