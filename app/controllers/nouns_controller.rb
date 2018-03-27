class NounsController < ApplicationController
  before_action :set_noun, only: %i[show edit update destroy]

  # GET /nouns
  # GET /nouns.json
  def index
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      @nouns = Noun.all
    end
  end

  # GET /nouns/1
  # GET /nouns/1.json
  def show
    super if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
  end

  # GET /nouns/new
  def new
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      @noun = Noun.new
    end
  end

  # GET /nouns/1/edit
  def edit; end

  # POST /nouns
  # POST /nouns.json
  def create
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      @noun = Noun.new(noun_params)

      if @noun.save
        redirect_to @noun, notice: 'Noun was successfully created.'
      else
        render :new
      end
    end
  end

  # PATCH/PUT /nouns/1
  # PATCH/PUT /nouns/1.json
  def update
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      if @noun.update(noun_params)
        redirect_to @noun, notice: 'Noun was successfully updated.'
      else
        render :edit
      end
    end
  end

  # DELETE /nouns/1
  # DELETE /nouns/1.json
  def destroy
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      @noun.destroy
      redirect_to nouns_url, notice: 'Noun was successfully destroyed.'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_noun
    @noun = Noun.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def noun_params
    params.require(:noun).permit(:description)
  end
end
