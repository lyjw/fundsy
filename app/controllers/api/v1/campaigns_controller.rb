class Api::V1::CampaignsController < Api::BaseController

  def index
    @campaigns = Campaign.order(:created_at)
    # This will render /api/v1/views/index.json.jbuilder
    # as we specified in routes that the default is json
  end

  def show
    campaign = Campaign.find params[:id]
    render json: campaign
  end

  def create
    campaign = Campaign.create(campaign_params)
    if campaign.save
      render json: campaign
    else
      render json: { errors: campaign.errors.full_messages }
    end
  end

  private

  def campaign_params
    params.require(:campaign).permit(:title, :body, :goal, :end_date)
  end

end
