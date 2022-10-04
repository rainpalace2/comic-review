class Public::ReviewsController < ApplicationController
  def index
    @book = Book.find(params[:book_id])
    @reviews = @book.reviews
  end

  def create
    @review = Review.new(review_prams)
    # @review.customer_id = current_customer.id
    if @review.save
      redirect_to book_review_path(@review.book)
    else
       @book = Book.find(params[:book_id])
      render "public/books/show"
    end
  end

  private

  def review_prams
    params.require(:review).permit(:book_id, :score, :content, :customer_id)
  end

end
