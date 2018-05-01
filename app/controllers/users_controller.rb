class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users
  # GET /users.json
  def index
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      @users = User.all
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    super if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
  end

  # GET /users/new
  def new
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      @user = User.new
    end
  end

  # GET /users/1/edit
  def edit; end

  # POST /users
  # POST /users.json
  def create
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      @user = User.new(user_params)

      if @user.save
        redirect_to @user, notice: 'User was successfully created.'
      else
        render :new
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      if @user.update(user_params)
        redirect_to @user, notice: 'User was successfully updated.'
      else
        render :edit
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if request.headers['HTTP_ACCEPT'] == "application/vnd.api+json"
      super
    else
      @user.destroy
      redirect_to users_url, notice: 'User was successfully destroyed.'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:description, :default_total_session_donation, :default_swipe_donation)
  end
end
