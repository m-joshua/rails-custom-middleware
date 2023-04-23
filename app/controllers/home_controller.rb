class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def about
    authorize :home, :about?
  end
end
