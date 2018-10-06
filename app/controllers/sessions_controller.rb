class SessionsController < ApplicationController
  skip_before_action :require_login

  # GET /sessions
  def index
    @user = User.authenticate(params[:username], params[:password])

    if @user
      render json: @user, only: [:id, :username, :token], status: :ok
    else
      render json: {"error": "Incorrect username or password"}, status: :unauthorized
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def session_params
      params.permit(
        :username,
        :password
      )
    end
end
