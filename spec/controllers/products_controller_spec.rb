require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
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
    Category.create!(
      name: "foo"
    )
  }

  let(:product) {
    Product.create(
      user_id: user.id,
      name: "Cap",
      description: "Black",
      price: 90.75,
      category_id: category.id,
      image: Rack::Test::UploadedFile.new(
        Rails.root.join('spec', 'images', '2.png')
      )
    )
  }
  let(:invalid_product) {
    Product.create(
      user_id: nil,
      name: nil,
      description: nil,
      price: nil,
      category_id: nil,
      image: nil
    )
  }

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  describe "GET #index" do
    it "assigns all products to @product" do
      products = Product.all
      get :index
      expect(assigns(:products).map { |e| e }).to eq(products.map { |e| e })
    end
  end

  describe "GET #show" do
    it "assigns the requested product as @product" do
      product
      get :show, params: { id: product }
      expect(assigns(:product)).to eq(product)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new product" do
        product
        expect(product).to be_valid
      end
    end

    context "with invalid parameters" do
      it "assigns a newly created but unsaved product as @product" do
        invalid_product
        expect(:invalid_product).not_to be_a(Product)
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the chosen product" do
      product
      expect {
        delete :destroy, params: { id: product }
      }.to change(Product, :count).by(-1)
    end
    it "redirects to product list" do
      product
      delete :destroy, params: { id: product }
      expect(response).to redirect_to(products_url)
    end
  end
end
