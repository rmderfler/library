class Book

  attr_accessor :id, :title

  def initialize(info)
    @id = info['id']
    @title = info['title']
  end

  def self.all
    titles = []
    results = DB.exec('SELECT * FROM books;')
    results.each do |result|
      titles << Book.new(result)
    end
    titles
  end

  def save
    results = DB.exec("INSERT INTO books (title) VALUES ('#{@title}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_title)
    self.title = another_title.title
  end

  def delete
    DB.exec("DELETE FROM books WHERE id = '#{@id}';")
  end

  def add_author(author)
    results = DB.exec("INSERT INTO books_authors (book_id, author_id) VALUES (#{self.id}, #{author.id}) RETURNING id;")
    @id = results.first['id'].to_i
  end

  def Book.search_by_author(author)
    results = DB.exec("SELECT books.* FROM
                      authors JOIN books_authors ON (authors.id = books_authors.author_id)
                              JOIN books on (books_authors.book_id = books.id)
                      where authors.name = '#{author}';")
    @title = results.first['title']
  end
end

