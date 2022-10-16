class Public::BooksController < ApplicationController
  before_action :ensure_correct_customer, only: [:edit, :update, :destroy]
  before_action :authenticate_customer!

  def index
    # 評価の高い順、新しい順の記述
    @books = Book.all.order(params[:sort])
    @book = Book.new
    @books = @books.page(params[:page]).per(10)
  end

  def show
   @book = Book.find(params[:id])
   @book_comment = BookComment.new
  end

  def create
    @customer = current_customer
    @book = @customer.books.build(book_params)
    if @book.save
      redirect_to book_path(@book), notice: "新規投稿に成功しました。"
    else
      @books = Book.all.order(params[:sort])
      @books = @books.page(params[:page]).per(10)
      render "public/customers/show"
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
    redirect_to customer_path(current_customer)
  end

private

  def book_params
    params.require(:book).permit(:title, :body, :rate, :image)
  end


  def ensure_correct_customer
    @book = Book.find(params[:id])
    unless @book.customer == current_customer
      redirect_to books_path
    end
  end

end

