class AdTypesController < ApplicationController
  before_action :set_ad_type, only: %i[show edit update destroy]

  # GET /ad_types
  # GET /ad_types.json
  def index
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      @ad_types = AdType.all
    end
  end

  # GET /ad_types/1
  # GET /ad_types/1.json
  def show
    super if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
  end

  # GET /ad_types/new
  def new
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      @ad_type = AdType.new
    end
  end

  # GET /ad_types/1/edit
  def edit; end

  # POST /ad_types
  # POST /ad_types.json
  def create
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      @ad_type = AdType.new(ad_type_params)

      if @ad_type.save
        redirect_to @ad_type, notice: 'AdType was successfully created.'
      else
        render :new
      end
    end
  end

  # PATCH/PUT /ad_types/1
  # PATCH/PUT /ad_types/1.json
  def update
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      if @ad_type.update(ad_type_params)
        redirect_to @ad_type, notice: 'AdType was successfully updated.'
      else
        render :edit
      end
    end
  end

  # DELETE /ad_types/1
  # DELETE /ad_types/1.json
  def destroy
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      @ad_type.destroy
      redirect_to ad_types_url, notice: 'AdType was successfully destroyed.'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ad_type
    @ad_type = AdType.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def ad_type_params
    params.require(:ad_type).permit(:description)
  end
end
