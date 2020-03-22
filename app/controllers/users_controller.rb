class UsersController < ApplicationController
  # allow users to be created without a log in by overriding the application controllers before actions
  # before_action :authenticate_user!, except: [:create, :new]

  before_action :set_user, only: %i[show edit update destroy verify]

  before_action :authenticate_user, only: [:test]


  def test
    if current_user
      render json: { current_user_id: current_user.id }
    else
      render 'failed'
    end
  end

  # GET /users
  # GET /users.json
  def index
    if request.headers["HTTP_ACCEPT"] == "application/vnd.api+json"
      super
    else
      @users = User.all
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    super if request.headers["HTTP_ACCEPT"] == "application/vnd.api+json"
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users
  # POST /users.json
  def create
    @user = User.find_or_create_by(phone: user_params[:phone])
    @user.generate_pin
    @user.send_pin

    @user.update confirmation_sent_at: Time.zone.now

    render json: { user_id: @user.id }
  end

  def verify
    if params[:pin] == @user.pin
      @user.update confirmed_at: Time.zone.now
      @user.generate_token!

      render json: { token: @user.token }
    else
      render json: 'Invalid pin supplied.'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if request.headers["HTTP_ACCEPT"] == "application/vnd.api+json"
      super
    else
      if @user.update(user_params)
        redirect_to @user, notice: "User was successfully updated."
      else
        render :edit
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if request.headers["HTTP_ACCEPT"] == "application/vnd.api+json"
      super
    else
      @user.destroy
      redirect_to users_url, notice: "User was successfully destroyed."
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:user_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:phone)
  end
end
