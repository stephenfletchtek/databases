require_relative 'book'

class BookRepository
  def all
    sql = 'SELECT * FROM books;'
    result_set = DatabaseConnection.exec_params(sql, [])
    result_set.map { |record| make_book(record) }
  end

  def find(id)
    sql = "SELECT * FROM books WHERE id = #{id}"
    result = DatabaseConnection.exec_params(sql, [])
    make_book(result[0])
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