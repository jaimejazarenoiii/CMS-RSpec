require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:avatar) {
    Rack::Test::UploadedFile.new(
      Rails.root.join('spec', 'images', '2.png')
    )
  }

  let(:user) {
    User.create!(
      fname: "foo",
      lname: "bar",
      mobile: 123_456_789,
      email: "sample@gmail.com",
      birthdate: "1998-03-02",
      role: "admin",
      password: "foobar",
      avatar:
      Rack::Test::UploadedFile.new(
        Rails.root.join('spec', 'images', '2.png')
      )
    )
  }
  let(:invalid_user) {
    User.create(
      fname: nil,
      lname: nil,
      mobile: nil,
      email: nil,
      birthdate: nil,
      role: nil,
      password: nil,
      avatar: nil
    )
  }

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "GET #index" do
    it "assigns all normal users to @users" do
      @users = User.where(role: User.roles[:normal])
      get :index
      expect(assigns(:users).map { |e| e }).to eq(@users.map { |e| e })
    end
  end

  describe "GET #new" do
    it "assigns a new user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "GET #show" do
    it "assigns the requested user as @user" do
      user
      get :show, { params: { id: user } }
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new user" do
        user
        expect(user).to be_valid
      end
    end

    context "with invalid parameters" do
      it "assigns a newly created but unsaved user as @user" do
        invalid_user
        expect(:invalid_user).not_to be_a(User)
      end
    end
  end
end
