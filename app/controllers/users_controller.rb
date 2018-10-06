class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  skip_before_action :require_login, only: [:create], raise: false

  # GET /users
  def index
    @users = User.all
    render json: @users, only: [:id, :username, :token, :is_available]
  end

  # GET /users/1
  def show
    render json: @user, only: [:id,:username, :token]
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, only: [:id, :username, :token], status: :created, location: @user
    else
      render json: {"error": error_message(@user)}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user, only: [:id, :username, :token]
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(
        :username,
        :password
      )
    end

    def error_message(user)
      error_hash = user.errors.to_hash()
      if error_hash.key?(:username)
        return "Invalid username entry"
      elsif error_hash.key?(:password)
        return "Invalid password entry"
      end
    end
end
