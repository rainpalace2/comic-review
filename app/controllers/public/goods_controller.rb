class Public::GoodsController < ApplicationController
  before_action :authenticate_customer!, except: [:search_top, :search]
  before_action :set_search

  # APIを使用する記述
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
    @books = Good.page(params[:page])
  end

  def show
    @good = Good.find(params[:id])
    @review = Review.new
  end

  def search_index_result
     # ransackの記述
    @q = Good.ransack(params[:q])
    @goods = @q.result(distinct: true)
    @qs = @goods.page(params[:page]).per(20)
  end

  def search_top
  end


  private
# キーワード検索をするための記述
  def set_search
     @q = Good.ransack(params[:q])
    @goods = @q.result(distinct: true)
  end

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