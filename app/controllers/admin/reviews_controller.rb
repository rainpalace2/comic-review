class Admin::ReviewsController < ApplicationController
  
  layout "admin_application"
  
  def index
    @reviews = Review.all.page(params[:page]).per(8)
  end

  def show
    @review = Review.find(params[:id])
  end
  
  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to reviewspath, notice: "レビューを削除しました"
  end
end
