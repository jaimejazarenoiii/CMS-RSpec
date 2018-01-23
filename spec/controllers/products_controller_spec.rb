require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:u) { create(:user, avatar: i, role: "admin") }
  let(:cat) { create(:category) }
  let(:i) {
    Rack::Test::UploadedFile.new(
      Rails.root.join('spec', 'image', '1.png')
    )
  }

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in u
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
      product = create(:product, user_id: u.id, category_id: cat.id, image: i)
      get :show, { params: { id: product } }
      expect(product).to eq(Product.last)
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested product" do
      product = create(:product, user_id: u.id, category_id: cat.id, image: i)
      expect {
        delete :destroy, { params: { id: product } }
      }.to change(Product, :count).by(-1)
    end
    it "redirects to products list" do
      product = create(:product, user_id: u.id, category_id: cat.id, image: i)
      delete :destroy, { params: { id: product } }
      expect(response).to redirect_to(products_url)
    end
  end

  describe "POST #create" do
    it "creates a new Product" do
      product = create(:product, user_id: u.id, category_id: cat.id, image: i)
      expect(product).to eq(Product.last)
    end
    it "doesnt create product with nil parameters" do
      post :create, { params: { product: { name: nil } } }
      expect(:product).not_to be_a(Product)
    end
  end
end
