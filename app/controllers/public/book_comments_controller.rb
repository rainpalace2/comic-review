class Public::BookCommentsController < ApplicationController

  def index
    @book = Book.find(params[:book_id])
    @book.book_comments = @book.book_comments
  end

  def create
    book = Book.find(params[:book_id])
    @comment = current_customer.book_comments.new(book_comment_params)
    @comment.book_id = book.id
    @comment.save
  end

  def destroy
    @comment = BookComment.find_by(id: params[:id], book_id: params[:book_id])
    @comment.destroy
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment, :customer_id, :book_id)
  end

end
