require 'book_repository'

RSpec.describe BookRepository do
  def reset_book_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_book_table
  end

  it "gets all books" do
    repo = BookRepository.new
    books = repo.all
    expect(books.length).to eq 5
    expect(books[0].id).to eq '1'
    expect(books[0].title).to eq 'Nineteen Eighty-Four'
    expect(books[0].author_name).to eq 'George Orwell'
    expect(books[1].id).to eq '2'
    expect(books[1].title).to eq 'Mrs Dalloway'
    expect(books[1].author_name).to eq 'Virginia Woolf'
  end
  
  it "gets a single book" do
    repo = BookRepository.new
    book = repo.find(1)
    expect(book.id).to eq '1'
    expect(book.title).to eq 'Nineteen Eighty-Four'
    expect(book.author_name).to eq 'George Orwell'
  end

  it "creates a book" do
    repo = BookRepository.new
    repo.create('Catch 22', 'Joseph Heller' )
    books = repo.all
    expect(books.length).to eq 6
    expect(books[-1].id).to eq '6'
    expect(books[-1].title).to eq 'Catch 22'
    expect(books[-1].author_name).to eq 'Joseph Heller'    
  end

  it "updates a book" do
    repo = BookRepository.new
    repo.update(1, 'title', 1984)
    book = repo.find(1)
    expect(book.title).to eq "1984"      
  end

  it "deletes a book" do
    repo = BookRepository.new
    repo.delete(1)
    books = repo.all
    expect(books.length).to eq (4)
    expect { repo.find(1) }.to raise_error "Book not found!"  
  end
end