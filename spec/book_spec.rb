require 'spec_helper'
require 'book'
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

  it 'reads an book object by the same name as the same object' do
    new_book = Book.new({'title' => "Hamlet"})
    another_book = Book.new({'title' => "Winnie the Pooh"})
    expect(new_book).to eq another_book
  end

end
