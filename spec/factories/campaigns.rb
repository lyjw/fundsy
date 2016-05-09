FactoryGirl.define do

  # Define factory for the Campaign model here.
  # This should always give a valid campaign.
  factory :campaign do
    # Using a sequence guarantees that we will have a unique number 'n', which we can use to generate a unique title
    sequence(:title)  { |n| "#{Faker::Company.bs}" }
    body              { "#{Faker::Hipster.paragraph}" }
    goal              { 11 + rand(100000) }
    end_date          { Time.now + rand(120).days }
  end
end
