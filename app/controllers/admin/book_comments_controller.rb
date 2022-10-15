class Admin::BookCommentsController < ApplicationController
  
  layout "admin_application"
  
  def index
    @book_comments = BookComment.all.page(params[:page]).per(8)
  end

  def show
    @book_comment = BookComment.find(params[:id])
  end
  
  def destroy
    book_comment = BookComment.find(params[:id])
    book_comment.destroy
    redirect_to admin_book_comments_path, notice: "コメントを削除しました"
  end
  
end
