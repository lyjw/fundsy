class CampaignsController < ApplicationController
  before_action :find_campaign, only: [:show, :update, :edit, :destroy]

  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.create(campaign_params)

    if @campaign.save
      redirect_to campaign_path(@campaign), notice: "Campaign created."
    else
      flash[:alert] = "Invalid parameters. Campaign not created."
      render :new
    end
  end

  def show
  end

  def index
    @campaigns = Campaign.order(:created_at)
  end

  def edit
  end

  def update
    if @campaign.update campaign_params
      redirect_to campaign_path(@campaign), notice: "Campaign updated."
    else
      render :edit
    end
  end

  def destroy
    @campaign.destroy
    redirect_to campaigns_path, notice: "Campaign deleted."
  end

  private

  def find_campaign
    @campaign = Campaign.find params[:id]
  end

  def campaign_params
    params.require(:campaign).permit(:title, :body, :goal, :end_date)
  end

end
