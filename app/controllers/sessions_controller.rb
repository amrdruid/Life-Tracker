class SessionsController < Devise::SessionsController
  def create
    user = User.find_for_authentication(email: params[:user][:email])

    if user && user.valid_password?(params[:user][:password])
      data = {
        token: user.authentication_token,
        email: user.email
      }
      render json: data, status: 201
    else
      rendher head: true, status: 401
    end

  end
end
