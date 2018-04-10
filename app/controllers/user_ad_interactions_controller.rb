class UserAdInteractionsController < ApplicationController
  before_action :set_user_ad_interaction, only: %i[show edit update destroy]

  # GET /user_ad_interactions
  # GET /user_ad_interactions.json
  def index
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      @user_ad_interactions = UserAdInteraction.all
    end
  end

  # GET /user_ad_interactions/1
  # GET /user_ad_interactions/1.json
  def show
    super if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
  end

  # GET /user_ad_interactions/new
  def new
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      @user_ad_interaction = UserAdInteraction.new
    end
  end

  # GET /user_ad_interactions/1/edit
  def edit; end

  # POST /user_ad_interactions
  # POST /user_ad_interactions.json
  def create
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      @user_ad_interaction = UserAdInteraction.new(user_ad_interaction_params)

      if @user_ad_interaction.save
        redirect_to @user_ad_interaction, notice: 'UserAdInteraction was successfully created.'
      else
        render :new
      end
    end
  end

  # PATCH/PUT /user_ad_interactions/1
  # PATCH/PUT /user_ad_interactions/1.json
  def update
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      if @user_ad_interaction.update(user_ad_interaction_params)
        redirect_to @user_ad_interaction, notice: 'UserAdInteraction was successfully updated.'
      else
        render :edit
      end
    end
  end

  # DELETE /user_ad_interactions/1
  # DELETE /user_ad_interactions/1.json
  def destroy
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      @user_ad_interaction.destroy
      redirect_to user_ad_interactions_url, notice: 'UserAdInteraction was successfully destroyed.'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_ad_interaction
    @user_ad_interaction = UserAdInteraction.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_ad_interaction_params
    params.require(:user_ad_interaction).permit(:description)
  end
end
