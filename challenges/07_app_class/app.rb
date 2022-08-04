require_relative 'lib/database_connection'
require_relative 'lib/album_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

# Print out each record from the result set .
album_repository = AlbumRepository.new

# album_repository.all.each do |album|
#   p album
# end

p album_repository.find('3')