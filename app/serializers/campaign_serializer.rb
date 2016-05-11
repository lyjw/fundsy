class CampaignSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :url, :created_at

  # Without customization, it defaults to json (and shows all)
  # You will need to set up a separate pledge_serializer to customize
  has_many :pledges

  include ApplicationHelper

  def title
    object.title.titleize
  end

  def url
    campaign_url(object, host: "http://localhost:3000")
  end

  def created_at
    formatted_date(object.created_at)
  end

end
