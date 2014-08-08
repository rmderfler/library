class Author

  attr_accessor :id, :name

  def initialize(info)
    @id = info['id']
    @name = info['name']
  end

  def self.all
    authors = []
    results = DB.exec('SELECT * FROM authors;')
    results.each do |result|
      authors << Author.new(result)
    end
    authors
  end

  def save
    results = DB.exec("INSERT INTO authors (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_author)
    self.name = another_author.name
  end
end
