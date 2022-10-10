class Public::BooksController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:edit, :update, :destroy]

  def index
    # 評価の高い順、新しい順の記述
    @books = Book.all.order(params[:sort])
    @book = Book.new
  end

  def show
   @book = Book.find(params[:id])
   @book_comment = BookComment.new
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

  def edit
    @book = Book.find(params[:id])
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "更新しました。"
    else
      render "edit"
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


  def ensure_correct_customer
    @book = Book.find(params[:id])
    unless @book.customer == current_customer
      redirect_to books_path
    end
  end

end

