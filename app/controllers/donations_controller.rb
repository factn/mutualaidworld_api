class DonationsController < ApplicationController
  before_action :set_donation, only: %i[show edit update destroy]

  # GET /donations
  # GET /donations.json
  def index
    if request.headers["HTTP_ACCEPT"] == "application/vnd.api+json"
      super
    else
      @donations = Donation.all
    end
  end

  # GET /donations/1
  # GET /donations/1.json
  def show
    super if request.headers["HTTP_ACCEPT"] == "application/vnd.api+json"
  end

  # GET /donations/new
  def new
    if request.headers["HTTP_ACCEPT"] == "application/vnd.api+json"
      super
    else
      @donation = Donation.new
    end
  end

  # GET /donations/1/edit
  def edit; end

  # POST /donations
  # POST /donations.json
  def create
    if request.headers["HTTP_ACCEPT"] == "application/vnd.api+json"
      super
    else
      @donation = Donation.new(donation_params)

      if @donation.save
        redirect_to @donation, notice: "Donation was successfully created."
      else
        render :new
      end
    end
  end

  # PATCH/PUT /donations/1
  # PATCH/PUT /donations/1.json
  def update
    if request.headers["HTTP_ACCEPT"] == "application/vnd.api+json"
      super
    else
      if @donation.update(donation_params)
        redirect_to @donation, notice: "Donation was successfully updated."
      else
        render :edit
      end
    end
  end

  # DELETE /donations/1
  # DELETE /donations/1.json
  def destroy
    if request.headers["HTTP_ACCEPT"] == "application/vnd.api+json"
      super
    else
      @donation.destroy
      redirect_to donations_url, notice: "Donation was successfully destroyed."
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_donation
    @donation = Donation.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def donation_params
    params.require(:donation).permit(:donator_id, :scenario_id, :amount)
  end
end
