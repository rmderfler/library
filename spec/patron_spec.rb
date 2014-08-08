require 'patron'
require 'spec_helper'

describe Patron do
  it 'is initialized with a name' do
    patron = Patron.new({'name' => 'Eva Peron'})
    expect(patron).to be_an_instance_of Patron
  end

  it "lists all patrons if there are none" do
    expect(Patron.all).to eq []
  end

  it "saves a patron" do
    new_patron = Patron.new({'name' => "Billy"})
    new_patron.save
    expect(Patron.all).to eq [new_patron]
  end

  it 'reads a book object by the same name as the same object' do
    new_patron = Patron.new({'name' => "Billy"})
    another_patron = Patron.new({'name' => "Wendy"})
    expect(new_patron).to eq another_patron
  end

  it 'deletes a patron from the db' do
    new_patron = Patron.new({'name' => "Billy"})
    another_patron = Patron.new({'name' => "Wendy"})
    new_patron.save
    another_patron.save
    new_patron.delete
    expect(Patron.all).to eq [another_patron]
  end
end
