class Api::V2::CampaignsController < Api::V1::CampaignsController

  def index
    @campaigns = Campaign.order(:created_at)
    # This will render /api/v1/views/index.json.jbuilder
    # as we specified in routes that the default is json
  end

  def show
    campaign = Campaign.find params[:id]
    render json: campaign
  end

end
