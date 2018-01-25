require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:prod) { create(:product, category_id: category.id, user_id: user.id) }

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  describe "GET #index" do
    it "render a list of products" do
      get :index
      expect(assigns(:products)).to eq([prod])
    end
  end

  describe "GET #show" do
    it "assigns the selected product to @product" do
      get :show, params: { id: prod.id }
      expect(assigns(:product)).to eq(prod)
    end
  end

  describe "GET #new" do
    it "assigns a new product as @product" do
      get :new
      expect(assigns(:product)).to be_a_new(Product)
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new product" do
        expect {
          post :create, params: { product:
                                attributes_for(:product,
                                               category_id: category.id,
                                               user_id: user.id) }
        }.to change(Product, :count).by(1)
      end

      it "redirects to the new product" do
        post :create, params: { product:
                                attributes_for(:product,
                                               category_id: category.id,
                                               user_id: user.id) }
        expect(response).to redirect_to(Product.last)
      end
    end

    context "with invalid attributes" do
      it "does not save new product" do
        expect {
          post :create, params: { product: attributes_for(:invalid_product) }
        }.to_not change(Product, :count)
      end

      it "reloads the new method" do
        post :create, params: { product: attributes_for(:invalid_product) }
        expect(response).to render_template :new
      end
    end
  end

  describe "Delete Destroy" do
    it "deletes the contact" do
      prod
      expect {
        delete :destroy, params: { id: prod.id }
      }.to change(Product, :count).by(-1)
    end

    it "redirects to product index" do
      delete :destroy, params: { id: prod.id }
      expect(response).to redirect_to products_path
    end
  end
end
