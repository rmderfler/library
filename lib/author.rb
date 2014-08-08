class Author

  attr_accessor :id, :name
  @table = 'authors'

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

  def add_book(book)
    results = DB.exec("INSERT INTO books_authors (author_id, book_id) VALUES (#{self.id}, #{book.id}) RETURNING id;")
    @id = results.first['id']
  end

  def delete
    DB.exec("DELETE FROM authors WHERE id = '#{id}'")
  end
end
