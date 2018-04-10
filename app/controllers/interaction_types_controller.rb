class InteractionTypesController < ApplicationController
  before_action :set_interaction_type, only: %i[show edit update destroy]

  # GET /interaction_types
  # GET /interaction_types.json
  def index
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      @interaction_types = InteractionType.all
    end
  end

  # GET /interaction_types/1
  # GET /interaction_types/1.json
  def show
    super if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
  end

  # GET /interaction_types/new
  def new
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      @interaction_type = InteractionType.new
    end
  end

  # GET /interaction_types/1/edit
  def edit; end

  # POST /interaction_types
  # POST /interaction_types.json
  def create
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      @interaction_type = InteractionType.new(interaction_type_params)

      if @interaction_type.save
        redirect_to @interaction_type, notice: 'InteractionType was successfully created.'
      else
        render :new
      end
    end
  end

  # PATCH/PUT /interaction_types/1
  # PATCH/PUT /interaction_types/1.json
  def update
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      if @interaction_type.update(interaction_type_params)
        redirect_to @interaction_type, notice: 'InteractionType was successfully updated.'
      else
        render :edit
      end
    end
  end

  # DELETE /interaction_types/1
  # DELETE /interaction_types/1.json
  def destroy
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      @interaction_type.destroy
      redirect_to interaction_types_url, notice: 'InteractionType was successfully destroyed.'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_interaction_type
    @interaction_type = InteractionType.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def interaction_type_params
    params.require(:interaction_type).permit(:description)
  end
end
