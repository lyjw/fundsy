require 'rails_helper'

# "Campaigns" is a string because multiple controllers could be involved in the testing of the Campaigns feature
RSpec.feature "Campaigns", type: :feature do

  describe "Listings Page" do
    it "contains a text: All Campaigns" do
      # Visit is a method from Capybara that emulates visiting a page from RSpec. Here, it emulates a visit to the campaigns#index
      visit campaigns_path
      expect(page).to have_text("All Campaigns")
    end

    it "contains an h2 element with text: Recent Campaigns" do
      visit campaigns_path
      expect(page).to have_selector "h2", text: "Recent Campaigns"
    end

    it "displays a campaign's title on the page" do
      c = FactoryGirl.create(:campaign)

      visit campaigns_path
      # Regular expressions is used here to enable case-insensitive searching (/i)
      expect(page).to have_text /#{c.title}/i
    end
  end

end
