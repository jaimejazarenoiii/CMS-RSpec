require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:image) {
    Rack::Test::UploadedFile.new(
      Rails.root.join('spec', 'image', '1.png')
    )
  }

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  it "Log in authenticated user" do
    user = double('user')
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
    get :index
    expect(response).to be_success
  end

  it "Does not accept nil log in form" do
    allow(
      request.env['warden']
    ).to receive(:authenticate!).and_throw(:warden, { :scope => :user })
    allow(controller).to receive(:current_user).and_return(nil)
    get :index
    response.body.should == ""
  end

  describe "GET #index" do
    it "show all users" do
      users = User.all
      get :index
      expect(assigns(:users).map { |e| e }).to eq(users.map { |e| e })
    end
  end

  describe "GET #new" do
    it "assigns a new user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "GET #edit" do
    it "assigns the requested user to edit" do
      user = create(:user, avatar: image)
      get :edit, { params: { id: user } }
      expect(user).to eq(User.last)
    end
  end

  describe "POST #create" do
    it "creates a new User" do
      user = create(:user, avatar: image)
      expect(user).to be_a(User)
      expect(user).to eq(User.last)
    end
    it "doesnt create user with invalid parameters" do
      post :create, { params: { user: { name: nil, price: nil } } }
      expect(:user).not_to be_a(User)
    end
  end

  describe "GET #show" do
    it "get the specific user" do
      user = create(:user, avatar: image)
      get :show, { params: { id: user } }
      expect(assigns(:user)).to eq(user)
    end
  end
end
