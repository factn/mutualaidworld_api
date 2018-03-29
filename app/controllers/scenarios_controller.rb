class ScenariosController < ApplicationController
  before_action :set_scenario, only: %i[show edit update destroy]

  # GET /scenarios
  # GET /scenarios.json
  def index
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      @scenarios = Scenario.all
    end
  end

  # GET /scenarios/1
  # GET /scenarios/1.json
  def show
    super if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
  end

  def ad
    # authorize :admin_ad, :show?

    @example_scenarios = Scenario.first 4
    # binding.pry
    # <%= Verbs::Conjugator.conjugate scenario.verb.description.to_sym tense: :present, person: :second, plurality: :singular, aspect: :perfective %>

    respond_to do |format|
      format.html { render "ad" }
    end
  end

  # GET /scenarios/new
  def new
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      @scenario = Scenario.new
    end
  end

  # GET /scenarios/1/edit
  def edit; end

  # POST /scenarios
  # POST /scenarios.json
  def create
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      @scenario = Scenario.new(scenario_params)

      if @scenario.save
        redirect_to @scenario, notice: 'Scenario was successfully created.'
      else
        render :new
      end
    end
  end

  # PATCH/PUT /scenarios/1
  # PATCH/PUT /scenarios/1.json
  def update
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      if @scenario.update(scenario_params)
        redirect_to @scenario, notice: 'Scenario was successfully updated.'
      else
        render :edit
      end
    end
  end

  # DELETE /scenarios/1
  # DELETE /scenarios/1.json
  def destroy
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      @scenario.destroy
      redirect_to scenarios_url, notice: 'Scenario was successfully destroyed.'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_scenario
    @scenario = Scenario.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def scenario_params
    params.require(:scenario).permit(:verb_id, :noun_id, :requestor_id, :doer_id, :image, :funding_goal, :event_id)
  end
end
