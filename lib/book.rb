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
end

