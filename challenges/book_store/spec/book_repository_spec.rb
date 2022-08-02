require 'book_repository'

RSpec.describe BookRepository do
  def reset_book_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store_test' })
    connection.exec(seed_sql)
  end
  
  describe BookRepository do
    before(:each) do 
      reset_book_table
    end
  
  
end