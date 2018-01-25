require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:user) {
    User.create(
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

  let(:category) {
    Category.create(
      name: "foo"
    )
  }

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end
  describe "GET#new" do
    it "assigns new category to @category" do
      get :new
      expect(assigns(:category)).to be_a_new(Category)
    end
  end
  describe "POST #create" do
    it "creates a new Category" do
      expect {
        post :create, { params: { category: { name: "Bag" } } }
      }.to change(Category, :count).by(1)
    end
    it "assigns created category to @category to be saved" do
      category = Category.create!(name: "Bag")
      expect(category).to be_a(Category)
      expect(category).to eq(Category.last)
    end
    it "should not create category with nil value" do
      category = Category.new(name: nil)
      expect(category).to_not be_valid
    end
  end
end
