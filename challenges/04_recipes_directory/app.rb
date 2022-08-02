require_relative 'lib/recipe_directory'
require_relative 'lib/database_connection'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('receipes_directory')

recipe_directory = RecipeDirectory.new

recipe_directory.all.each do |recipe|
  puts recipe.name
end