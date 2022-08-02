require 'recipe_directory'

def reset_recipes_table
  seed_sql = File.read('spec/seeds_recipes.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'receipes_directory_test' })
  connection.exec(seed_sql)
end

RSpec.describe RecipeDirectory do
  before(:each) do
    reset_recipes_table
  end

  it 'returns all recipes' do
    repo = RecipeDirectory.new

    recipes = repo.all

    expect(recipes.length).to eq 2

    expect(recipes[0].id).to eq '1'
    expect(recipes[0].name).to eq 'Pudding'
    expect(recipes[0].cooking_time).to eq '20'
    expect(recipes[0].rating).to eq '5'
  end

  it 'returns a recipe based on an id' do
    repo = RecipeDirectory.new

    recipe = repo.find('2')
    
    expect(recipe.id).to eq ('2')
    expect(recipe.name).to eq 'Apple pie'
    expect(recipe.cooking_time).to eq '30'
    expect(recipe.rating).to eq '3'
  end

  context 'when no record is found' do
    it 'fails' do
      repo = RecipeDirectory.new
      expect{ repo.find('5') }.to raise_error "No record found"
    end
  end
end