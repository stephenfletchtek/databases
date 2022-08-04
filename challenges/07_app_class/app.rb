require_relative './lib/album_repo'
require_relative './lib/artist_repo'
require_relative 'lib/database_connection'

class Application
  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run
    @io.puts "Enter your choice:"
    user = @io.gets.chomp
    if user == "1"
      @io.puts "Here is the list of albums:"
      sorted = @album_repository.all.sort_by { |album| album.id.to_i }
      sorted.each { |album| @io.puts "* #{album.id} - #{album.title}" }
    elsif user == "2"
      @io.puts "Here is the list of artists:"
      sorted = @artist_repository.all.sort_by { |artist| artist.id.to_i }
      sorted.each { |artist| @io.puts "* #{artist.id} - #{artist.name}" }
    else
      @io.puts "Choice not recognised"
    end
  end
end

if __FILE__ == $0
  app = Application.new(
    'music_library',
    Kernel,
    AlbumRepository.new,
    ArtistRepository.new
  )
  app.run
end