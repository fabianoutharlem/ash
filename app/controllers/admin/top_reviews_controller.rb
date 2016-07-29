module Admin
  class TopReviewsController < AdminBaseController
    before_action :set_top_review, only: [:show, :edit, :update, :destroy]

    # GET /top_reviews
    # GET /top_reviews.json
    def index
      @top_reviews = TopReview.all
    end

    # GET /top_reviews/1
    # GET /top_reviews/1.json
    def show
    end

    # GET /top_reviews/new
    def new
      @top_review = TopReview.new
    end

    # GET /top_reviews/1/edit
    def edit
    end

    # POST /top_reviews
    # POST /top_reviews.json
    def create
      @top_review = TopReview.new(top_review_params)

      respond_to do |format|
        if @top_review.save
          format.html { redirect_to admin_top_reviews_path, notice: 'Top review is aangemaakt.' }
          format.json { render :show, status: :created, location: @top_review }
        else
          format.html { render :new }
          format.json { render json: @top_review.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /top_reviews/1
    # PATCH/PUT /top_reviews/1.json
    def update
      respond_to do |format|
        if @top_review.update(top_review_params)
          format.html { redirect_to admin_top_reviews_path, notice: 'Top review is aangepast.' }
          format.json { render :show, status: :ok, location: @top_review }
        else
          format.html { render :edit }
          format.json { render json: @top_review.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /top_reviews/1
    # DELETE /top_reviews/1.json
    def destroy
      @top_review.destroy
      respond_to do |format|
        format.html { redirect_to admin_top_reviews_path, notice: 'Top review is verwijderd.' }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_top_review
      @top_review = TopReview.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def top_review_params
      params.require(:top_review).permit(:id, :image, :review, :enabled)
    end
  end
end