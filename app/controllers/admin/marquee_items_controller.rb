module Admin
  class MarqueeItemsController < AdminBaseController
    before_action :set_marquee_item, only: [:show, :edit, :update, :destroy]

    # GET /marquee_items
    # GET /marquee_items.json
    def index
      @marquee_items = MarqueeItem.all
    end

    # GET /marquee_items/1
    # GET /marquee_items/1.json
    def show
    end

    # GET /marquee_items/new
    def new
      @marquee_item = MarqueeItem.new
    end

    # GET /marquee_items/1/edit
    def edit
    end

    # POST /marquee_items
    # POST /marquee_items.json
    def create
      @marquee_item = MarqueeItem.new(marquee_item_params)

      respond_to do |format|
        if @marquee_item.save
          format.html { redirect_to admin_marquee_items_path, notice: 'Marquee item was successfully created.' }
          format.json { render :show, status: :created, location: @marquee_item }
        else
          format.html { render :new }
          format.json { render json: @marquee_item.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /marquee_items/1
    # PATCH/PUT /marquee_items/1.json
    def update
      respond_to do |format|
        if @marquee_item.update(marquee_item_params)
          format.html { redirect_to admin_marquee_items_path, notice: 'Marquee item was successfully updated.' }
          format.json { render :show, status: :ok, location: @marquee_item }
        else
          format.html { render :edit }
          format.json { render json: @marquee_item.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /marquee_items/1
    # DELETE /marquee_items/1.json
    def destroy
      @marquee_item.destroy
      respond_to do |format|
        format.html { redirect_to admin_marquee_items_path, notice: 'Marquee item was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_marquee_item
      @marquee_item = MarqueeItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def marquee_item_params
      params.require(:marquee_item).permit(:title, :link)
    end
  end
end