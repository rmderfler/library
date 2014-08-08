class Patron

  attr_accessor :name, :info

  def initialize(info)
    @name = info['name']
    @id = info['id']
  end

  def save
    results = DB.exec("INSERT INTO patrons (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end


  def self.all
    all = []
    results = DB.exec("SELECT * FROM patrons;")
    results.each do |result|
      all << self.new(result)
    end
    all
  end

  def ==(another_patron)
    self.name = another_patron.name
  end

  def delete
    DB.exec("DELETE FROM patrons WHERE id = '#{@id}';")
  end

end
