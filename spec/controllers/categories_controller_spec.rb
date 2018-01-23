require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:user) { create(:user, avatar: i, role: "admin") }
  let(:i) {
    Rack::Test::UploadedFile.new(
      Rails.root.join('spec', 'image', '1.png')
    )
  }

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  describe "GET #new" do
    it "assigns a new category as @category" do
      get :new
      expect(assigns(:category)).to be_a_new(Category)
    end
  end

  describe "POST #create" do
    it "creates a new Category" do
      expect {
        post :create, { params: { category: { name: "Gulay" } } }
      }.to change(Category, :count).by(1)
    end
    it "assigns a newly created category as @category" do
      category = Category.create!(name: "Gulay")
      expect(category).to be_a(Category)
      expect(category).to eq(Category.last)
    end
    it "doesnt create category with nil parameters" do
      post :create, { params: { category: { name: nil } } }
      expect(:category).not_to be_a(Category)
    end
  end
end
