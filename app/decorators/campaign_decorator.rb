class CampaignDecorator < Draper::Decorator
  # Delegates everything you call to it to the campaign
  delegate_all

  def all_cap_title
    title.upcase
  end

  # object. is used when you are overriding the cl
  def created_at
    object.created_at.strftime("%Y-%B-%d")
  end

  def goal
    # Accessing a helper methods (whether it is built in by Rails or created by yourself)
    h.number_to_currency(object.goal)
  end

  def end_date
    "End Date: #{h.formatted_date(object.end_date)}"
  end

  def publish_button
    if object.draft?
      h.link_to "Publish", h.campaign_publishings_path(object), method: :patch, data: {confirm: "Are you sure you want to publish?"}, class: "btn btn-primary"
    end
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
