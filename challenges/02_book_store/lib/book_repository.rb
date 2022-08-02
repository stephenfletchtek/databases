require_relative 'book'

class BookRepository
  def all
    sql = 'SELECT * FROM books;'
    result_set = DatabaseConnection.exec_params(sql, [])
    result_set.map { |record| make_book(record) }
  end

  def find(id)
    sql = "SELECT * FROM books WHERE id = #{id};"
    result = DatabaseConnection.exec_params(sql, [])
    fail "Book not found!" if result.ntuples == 0
    make_book(result[0])
  end

  def create(title, author_name)
    sql = "INSERT INTO books (title, author_name) VALUES ('#{title}', '#{author_name}');"
    DatabaseConnection.exec_params(sql, [])
  end

  def update(id, column, new_value)
    sql = "UPDATE books SET #{column} = #{new_value}"
    DatabaseConnection.exec_params(sql, [])
  end

  def delete(id)
    sql = "DELETE FROM books WHERE id = #{id}"
    DatabaseConnection.exec_params(sql, [])
  end

  private

  def make_book(record)
    book = Book.new
    book.id = record['id']
    book.title = record['title']
    book.author_name = record['author_name']
    book
  end
end 