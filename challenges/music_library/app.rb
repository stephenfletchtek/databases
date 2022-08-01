require_relative 'lib/album_repository'

require_relative 'lib/database_connection'

DatabaseConnection.connect('music_library')

sql = 'SELECT id, title, release_year FROM albums;'
result = DatabaseConnection.exec_params(sql, [])

album_repo = AlbumRepository.new
album_repo.all.each { |album| p album }
