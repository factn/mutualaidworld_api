class VouchesController < ApplicationController
  before_action :set_vouch, only: %i[show edit update destroy]

  # GET /vouches
  # GET /vouches.json
  def index
    if request.headers["HTTP_ACCEPT"] == "application/vnd.api+json"
      super
    else
      @vouches = Vouch.all
    end
  end

  # GET /vouches/1
  # GET /vouches/1.json
  def show
    super if request.headers["HTTP_ACCEPT"] == "application/vnd.api+json"
  end

  # GET /vouches/new
  def new
    if request.headers["HTTP_ACCEPT"] == "application/vnd.api+json"
      super
    else
      @vouch = Vouch.new
    end
  end

  # GET /vouches/1/edit
  def edit; end

  # POST /vouches
  # POST /vouches.json
  def create
    if request.headers["HTTP_ACCEPT"] == "application/vnd.api+json"
      super
    else
      @vouch = Vouch.new(vouch_params)

      if @vouch.save
        redirect_to @vouch, notice: "Vouch was successfully created."
      else
        render :new
      end
    end
  end

  # PATCH/PUT /vouches/1
  # PATCH/PUT /vouches/1.json
  def update
    if request.headers["HTTP_ACCEPT"] == "application/vnd.api+json"
      super
    else
      if @vouch.update(vouch_params)
        redirect_to @vouch, notice: "Vouch was successfully updated."
      else
        render :edit
      end
    end
  end

  # DELETE /vouches/1
  # DELETE /vouches/1.json
  def destroy
    if request.headers["HTTP_ACCEPT"] == "application/vnd.api+json"
      super
    else
      @vouch.destroy
      redirect_to vouches_url, notice: "Vouch was successfully destroyed."
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_vouch
    @vouch = Vouch.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def vouch_params
    params.require(:vouch).permit(:scenario_id, :verifier_id, :image, :rating)
  end
end
