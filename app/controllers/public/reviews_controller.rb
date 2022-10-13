class Public::ReviewsController < ApplicationController
  before_action :authenticate_customer!, only: [:create]

  def index
    @good = Good.find(params[:good_id])
    @reviews = @good.reviews
  end

  def create
    @review = Review.new(review_params)
    @review.customer_id = current_customer.id
    if @review.save
      redirect_to good_reviews_path(@review.good)
    else
       @good = Good.find(params[:good_id])
      render "public/goods/show"
    end
  end

  private

  def review_params
    params.require(:review).permit(:good_id, :score, :content)
  end

end
