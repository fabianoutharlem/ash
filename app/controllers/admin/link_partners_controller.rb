module Admin
  class LinkPartnersController < AdminBaseController
    before_action :set_link_partner, only: [:show, :edit, :update, :destroy]

    # GET /link_partners
    # GET /link_partners.json
    def index
      @link_partners = LinkPartner.all
    end

    # GET /link_partners/1
    # GET /link_partners/1.json
    def show
    end

    # GET /link_partners/new
    def new
      @link_partner = LinkPartner.new
    end

    # GET /link_partners/1/edit
    def edit
    end

    # POST /link_partners
    # POST /link_partners.json
    def create
      @link_partner = LinkPartner.new(link_partner_params)

      respond_to do |format|
        if @link_partner.save
          format.html { redirect_to admin_link_partners_path, notice: 'Link partner is aangemaakt.' }
          format.json { render :show, status: :created, location: @link_partner }
        else
          format.html { render :new }
          format.json { render json: @link_partner.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /link_partners/1
    # PATCH/PUT /link_partners/1.json
    def update
      respond_to do |format|
        if @link_partner.update(link_partner_params)
          format.html { redirect_to admin_link_partners_path, notice: 'Link partner is aangepast.' }
          format.json { render :show, status: :ok, location: @link_partner }
        else
          format.html { render :edit }
          format.json { render json: @link_partner.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /link_partners/1
    # DELETE /link_partners/1.json
    def destroy
      @link_partner.destroy
      respond_to do |format|
        format.html { redirect_to admin_link_partners_path, notice: 'Link partner is verwijderd.' }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_link_partner
      @link_partner = LinkPartner.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_partner_params
      params.require(:link_partner).permit(:link)
    end
  end
end