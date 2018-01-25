require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "GET #index" do
    it "assigns all normal users as @users" do
      @users = User.where(role: User.roles[:normal])
      get :index
      expect(assigns(:users).map { |e| e }).to eq(@users.map { |e| e })
    end
  end

  describe "GET #show" do
    it "assigns the selected user to @user" do
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "GET #new" do
    it "assigns a new user as @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new user" do
        expect {
          post :create, params: { user: attributes_for(:user) }
        }.to change(User, :count).by(1)
      end

      it "redirects to the new user" do
        post :create, params: { user: attributes_for(:user) }
        expect(response).to redirect_to root_path
      end
    end

    context "with invalid attributes" do
      it "does not save new user" do
        expect {
          post :create, params: { user: attributes_for(:invalid_user) }
        }.to_not change(User, :count)
      end
    end
  end
end
