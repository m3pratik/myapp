class LoginController < ApplicationController

  $pubnub = nil

  def index
  end

  def login_step
    username = params[:username]
    channel = params[:channel]

    redirect_to channel_url(:channel => channel, :username => username)
  end

end
