require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:category) {
    Category.create!(
      name: "asdasdas"
    )
  }

  let(:user) {
    User.create(
      fname: "bago",
      lname: "luma",
      mobile: 123_456_789,
      email: "sample@yahoo.com",
      birthdate: "2018-01-07",
      role: "admin",
      password: "foobar",
      avatar:
      Rack::Test::UploadedFile.new(
        Rails.root.join('spec', 'support', '1.png')
      )
    )
  }

  let(:product) {
    Product.create!(
      user_id: user.id,
      name: "Cap",
      description: "Black",
      price: 90.75,
      category_id: category.id,
      image: Rack::Test::UploadedFile.new(
        Rails.root.join('spec', 'support', '1.png')
      )
    )
  }

  let(:valid_session) { {} }

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  describe "GET #index" do
    it "assigns all products as @products" do
      products = Product.all
      get :index
      expect(assigns(:products).map { |e| e }).to eq(products.map { |e| e })
    end
  end

  describe "GET #show" do
    it "assigns the specific product" do
      product.save
      get :show, { params: { id: product } }
      expect(product).to eq(Product.last)
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested product" do
      product.save
      expect {
        delete :destroy, { params: { id: product } }
      }.to change(Product, :count).by(-1)
    end
    it "redirects to products list" do
      product.save
      delete :destroy, { params: { id: product } }
      expect(response).to redirect_to(products_url)
    end
  end

  describe "POST #create" do
    it "creates a new Product" do
      product.save
      expect(product).to eq(Product.last)
    end
    it "doesnt create product with nil parameters" do
      post :create, { params: { product: { name: nil } } }
      expect(:product).not_to be_a(Product)
    end
  end
end
