require_relative 'recipe'
require_relative 'database_connection'

class RecipeDirectory
  def all
    sql = 'SELECT * FROM recipes;'
    result = DatabaseConnection.exec_params(sql, [])

    return result.map { |record| make_recipe(record) }
  end

  def find(id)
    sql = 'SELECT * FROM recipes WHERE id = $1;'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)
    fail "No record found" if result.ntuples == 0
    result = result[0]

    return make_recipe(result)
  end

  def make_recipe(record)
    recipe = Recipe.new
    recipe.id = record['id']
    recipe.name = record['name']
    recipe.cooking_time = record['cooking_time']
    recipe.rating = record['rating']
    return recipe
  end
end