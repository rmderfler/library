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
end
