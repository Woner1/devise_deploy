class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    render json: { status: 200 }
  end
end
