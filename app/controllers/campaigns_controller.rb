class CampaignsController < ApplicationController
  before_action :find_campaign, only: [:show, :update, :edit, :destroy]
  before_action :authenticate_user!, except: [:show, :index]

  def new
    @campaign = Campaign.new
    3.times { @campaign.rewards.build }
  end

  def create
    @campaign = Campaign.create(campaign_params)
    @campaign.user = current_user

    if @campaign.save
      CampaignGoalJob.set(wait_until: @campaign.end_date).perform_later(@campaign)

      redirect_to campaign_path(@campaign), notice: "Campaign created."
    else
      # .count will call a sql aggregate function, count
      gen_count = 3 - @campaign.rewards.size
      gen_count.times { @campaign.rewards.build }
      flash[:alert] = "Invalid parameters. Campaign not created."
      render :new
    end
  end

  def show
  end

  def index
    @campaigns = Campaign.order(:created_at)

    respond_to do |format|
      format.html { render }
      format.json { render json: @campaigns.to_json }
    end
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
    @campaign = Campaign.find(params[:id]).decorate
  end

  def campaign_params
    params.require(:campaign).permit(:title, :body, :goal, :end_date, :address,
                                            { rewards_attributes: [:amount, :description, :id, :_destroy]})
  end

end
