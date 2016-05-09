require 'rails_helper'

RSpec.describe Campaign, type: :model do

  # 'describe' defines a group of test examples for model validations
  describe "validations" do

    # Use 'it' or 'specify' to define a test example.
    # The first argument to 'it' is a string that describes what you want to test. The test is written within a block you pass to 'it'.
    it "requires a title" do
      # GIVEN: Campaign with no title
      c = Campaign.new

      # WHEN: We validate the campaign
      validation_outcome = c.valid?

      # THEN: validation_outcome is false
      expect(validation_outcome).to be false
    end

    it "requires a goal" do
      # GIVEN: Campaign with no goal
      c = Campaign.new

      # WHEN: We validate the campaign
      c.valid?

      # THEN: There is an error on :goalo
      expect(c.errors).to have_key(:goal)
    end

    it "requires goal to be more than $10" do
      c = Campaign.new(goal: 9)
      c.valid?
      expect(c.errors).to have_key(:goal)
    end

    it "requires a unique title" do
      # c = Campaign.new(title: "Hello", goal: 11)
      # c.save
      Campaign.create(title: "Hello", goal: 11)
      c = Campaign.new(title: "Hello", goal: 11)

      c.valid?

      expect(c.errors).to have_key(:title)
    end

  end

   # When testing methods, it is convention to prefix the method with a '.'
   describe ".upcased_title" do

     it "returns an upcased title" do
       c = Campaign.new(title: "hello", goal: 11)

       result = c.upcased_title

       expect(result).to eq("HELLO")
     end
     
   end


end
