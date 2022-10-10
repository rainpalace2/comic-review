class Public::GoodsController < ApplicationController

  def search
    @books = []
    @title = params[:title]
    if @title.present?
      results = RakutenWebService::Books::Book.search({
        title: @title,
      })

      results.each do |result|
        book = Good.new(read(result))
        @books << book
      end
    end

    @books.each do |book|
      unless Good.all.include?(book)
        book.save
      end
    end
  end

  def index
    @books = Good.all
    @goo
  end

  def show
    @good = Good.find(params[:id])
    @review = Review.new
  end

  private

  def read(result)
    title = result["title"]
    author = result["author"]
    url = result["itemUrl"]
    isbn = result["isbn"]
    image_url = result["mediumImageUrl"].gsub('?_ex=120x120','')
    booksGenreId = result["booksGenreId"]
    item_caption = result["itemCaption"]
    {
      title: title,
      author: author,
      url: url,
      isbn: isbn,
      image_url: image_url,
      booksGenreId: booksGenreId,
      item_caption: item_caption
    }
  end
end