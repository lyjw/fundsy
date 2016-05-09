class PledgesController < ApplicationController
  before_action :authenticate_user!

  def new
    @pledge = Pledge.new
  end

end
