class ProofsController < ApplicationController
  before_action :set_proof, only: %i[show edit update destroy]

  # GET /proofs
  # GET /proofs.json
  def index
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      @proofs = Proof.all
    end
  end

  # GET /proofs/1
  # GET /proofs/1.json
  def show
    super if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
  end

  # GET /proofs/new
  def new
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      @proof = Proof.new
    end
  end

  # GET /proofs/1/edit
  def edit; end

  # POST /proofs
  # POST /proofs.json
  def create
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      @proof = Proof.new(proof_params)

      if @proof.save
        redirect_to @proof, notice: 'Proof was successfully created.'
      else
        render :new
      end
    end
  end

  # PATCH/PUT /proofs/1
  # PATCH/PUT /proofs/1.json
  def update
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      if @proof.update(proof_params)
        redirect_to @proof, notice: 'Proof was successfully updated.'
      else
        render :edit
      end
    end
  end

  # DELETE /proofs/1
  # DELETE /proofs/1.json
  def destroy
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      @proof.destroy
      redirect_to proofs_url, notice: 'Proof was successfully destroyed.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proof
      @proof = Proof.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def proof_params
      params.require(:proof).permit(:scenario_id, :image)
    end
end
