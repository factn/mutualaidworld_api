class VerbsController < ApplicationController
  before_action :set_verb, only: %i[show edit update destroy]

  # GET /verbs
  # GET /verbs.json
  def index
    if request.headers["HTTP_ACCEPT"] == "application/vnd.api+json"
      super
    else
      @verbs = Verb.all
    end
  end

  # GET /verbs/1
  # GET /verbs/1.json
  def show
    super if request.headers["HTTP_ACCEPT"] == "application/vnd.api+json"
  end

  # GET /verbs/new
  def new
    if request.headers["HTTP_ACCEPT"] == "application/vnd.api+json"
      super
    else
      @verb = Verb.new
    end
  end

  # GET /verbs/1/edit
  def edit; end

  # POST /verbs
  # POST /verbs.json
  def create
    if request.headers["HTTP_ACCEPT"] == "application/vnd.api+json"
      super
    else
      @verb = Verb.new(verb_params)

      if @verb.save
        redirect_to @verb, notice: "Verb was successfully created."
      else
        render :new
      end
    end
  end

  # PATCH/PUT /verbs/1
  # PATCH/PUT /verbs/1.json
  def update
    if request.headers["HTTP_ACCEPT"] == "application/vnd.api+json"
      super
    else
      if @verb.update(verb_params)
        redirect_to @verb, notice: "Verb was successfully updated."
      else
        render :edit
      end
    end
  end

  # DELETE /verbs/1
  # DELETE /verbs/1.json
  def destroy
    if request.headers["HTTP_ACCEPT"] == "application/vnd.api+json"
      super
    else
      @verb.destroy
      redirect_to verbs_url, notice: "Verb was successfully destroyed."
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_verb
    @verb = Verb.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def verb_params
    params.require(:verb).permit(:description)
  end
end
