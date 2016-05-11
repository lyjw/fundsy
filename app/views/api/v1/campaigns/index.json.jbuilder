json.array! @campaigns do |campaign|
  json.id         campaign.id
  json.title      campaign.title.titleize
  json.api_url    api_v1_campaign_url(campaign)
  json.url        campaign_url(campaign)
  json.created_at formatted_date(campaign.created_at)
  json.end_date   formatted_date(campaign.end_date)
end
