class Api::BaseController < ApplicationController
  before_action :authenticate_user
  # It will take all sessions and make it null. Because we are in an API, we are using an API key to authenticate the user. We are not using the session at all.
  protect_from_forgery with: :null_session

  def index
    @campaigns = Campaign.order(:created_at)
    # This will render /api/v1/views/index.json.jbuilder
    # as we specified in routes that the default is json
  end

  def show
    campaign = Campaign.find params[:id]
    render json: campaign
  end

  private

  def authenticate_user
    @user = User.find_by_api_key params[:api_key]
    head :forbidden unless @user
  end

end
