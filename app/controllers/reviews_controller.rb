class ReviewsController < ApplicationController

  def index
    @reviews = Review.approved
  end

  def create
    @review = Review.new(review_params)

    respond_to do |format|
      if @review.save
        format.html { redirect_to reviews_path, notice: 'Recensie is aangemaakt.' }
      else
        format.html { redirect_to reviews_path }
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:name, :email, :review, :rating)
  end

end