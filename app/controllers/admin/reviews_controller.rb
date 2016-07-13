class Admin::ReviewsController < Admin::AdminBaseController

  def index
    @reviews = Review.all
  end

  def update
    @review = Review.find(params[:id])
    if @review.present?
      @review.update_attributes(review_params)
      if @review.valid?
        respond_to do |format|
          format.js { render nothing: true, status: 200 }
          format.html {
            flash['success'] = 'Recensie is succesvol aangepast'
            render :edit
          }
        end
      end
    end
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    flash[:notice] = 'Recensie is succesvol verwijdert'
  end

  private

  def review_params
    params.require(:review).permit(:id, :review_id, :approved)
  end

end