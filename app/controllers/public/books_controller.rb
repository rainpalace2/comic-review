class Public::BooksController < ApplicationController
  before_action :authenticate_customer!, only: [:show]

  def index
    @books = Book.all
    @book = Book.new
  end

  def show
   @book = Book.find(params[:id])
   @review = Review.new
  end

  def create
    @book = Book.new(book_params)
    @book.customer_id = current_customer.id
    if @book.save
      redirect_to book_path(@book), notice: "新規投稿に成功しました。"
    else
      @books = Book.all
      render :index
    end
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "更新しました。"
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

private

  def book_params
    params.require(:book).permit(:title, :body, :rate)
  end
  
end

