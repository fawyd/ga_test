class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    session[:google_token] = auth.credentials.token
    session[:google_secret] = auth.credentials.secret
    redirect_to '/', notice: 'account added'
  end

  def failure
    redirect_to '/', alert: params[:message]
  end
end
