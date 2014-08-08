require 'author'
require 'spec_helper'

describe Author do
  it "initializes an author with a name and id" do
    expect(Author.new({'name' => "Shakespeare"})).to be_an_instance_of Author
  end

  it "lists all authors if there are no authors" do
    expect(Author.all).to eq []
  end

  it "saves authors" do
    new_author = Author.new({'name' => "Dos"})
    new_author.save
    expect(Author.all).to eq [new_author]
  end

  it 'reads an author object by the same name as the same object' do
    new_author = Author.new({'name' => "Dos"})
    another_author = Author.new({'name' => "Dos"})
    expect(new_author).to eq another_author
  end

  it 'adds a book to an author' do
    new_book = Book.new({'title' => "Crime and Punishment"})
    id_book = new_book.save
    new_author = Author.new({'name' => "Dostoyevsky"})
    id_author = new_author.save
    new_author.add_book(new_book)
    results = DB.exec("SELECT * FROM books_authors where author_id = #{id_author}")
    expect(results.first['book_id']).to eq id_book.to_s
  end
end
