require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#new" do

    before { get :new }

    it "renders the new template" do
      expect(response).to render_template(:new)
    end
    it "assigns a new user variable" do
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "#create" do

    context "with valid user attributes" do

      def valid_request
        post :create, user: FactoryGirl.attributes_for(:user)
      end

      it "adds a new user record to the database" do
        # expect { valid_request }.to change { User.count }.by(1)
        count_before = User.count
        valid_request
        count_after = User.count

        expect(count_after).to eq(count_before + 1)
      end

      it "redirects to the home page" do
        valid_request
        expect(response).to redirect_to(root_path)
      end

      it "sets a flash message" do
        valid_request
        expect(flash[:notice]).to be
      end

      it "sets the session user_id with the created user id" do
        valid_request
        expect(session[:user_id]).to eq(User.last.id)
      end

    end

    context "with invalid user attributes" do

      def invalid_request
        post :create, user: FactoryGirl.attributes_for(:user).merge(first_name: nil)
      end

      it "doesn't add a record to the database" do
        count_before = User.count
        invalid_request
        count_after = User.count

        expect(count_after).to eq(count_before)
      end

      it "renders the new template" do
        invalid_request
        expect(response).to render_template(:new)
      end

      it "sets a flash alert" do
        invalid_request
        expect(flash[:alert]).to be
      end
    end
  end
end
