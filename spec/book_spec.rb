require 'spec_helper'
require 'book'
require 'pry'

describe Book do
  it "is initialized by a title" do
    new_book = Book.new({'title' => 'War and Peace'})
    expect(new_book).to be_an_instance_of Book
  end

  it "lists all titles if there are no titles" do
    expect(Book.all).to eq []
  end

  it "saves titles" do
    new_title = Book.new({'title' => "HAMLET"})
    new_title.save
    expect(Book.all).to eq [new_title]
  end

  it 'reads a book object by the same name as the same object' do
    new_book = Book.new({'title' => "Hamlet"})
    another_book = Book.new({'title' => "Winnie the Pooh"})
    expect(new_book).to eq another_book
  end

  it 'deletes a book from the db' do
    new_book = Book.new({'title' => "Hamlet"})
    another_book = Book.new({'title' => "Goodnight Moon"})
    new_book.save
    another_book.save
    new_book.delete
    expect(Book.all).to eq [another_book]
  end

  it 'adds an author to a book' do
    new_book = Book.new({'title' => "Crime and Punishment"})
    id_book = new_book.save
    new_author = Author.new({'name' => "Dostoyevsky"})
    id_author = new_author.save
    new_book.add_author(new_author)
    results = DB.exec("SELECT * FROM books_authors where book_id = #{id_book}")
    expect(results.first['author_id']).to eq id_author.to_s
  end

  describe '.search_by_author' do
    it 'retrieves the book information for a given author' do
      new_book = Book.new({'title' => "Crime and Punishment"})
      another_book = Book.new({'title' => "Goodnight Moon"})
      new_book.save
      another_book.save
      new_author = Author.new({'name' => "Dostoyevsky"})
      new_author.save
      new_book.add_author(new_author)
      expect(Book.search_by_author("Dostoyevsky")).to eq new_book.title
    end
  end
end
