require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = create(:user, email: "ken@yahoo.com")
    @category = create(:category, name: "Gucci Gang")
    sign_in @user
  end

  describe "GET #index" do
    it "populates an array of products" do
      product = create(:product)
      get :index
      expect(assigns(:products)).to eq([product])
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    it "assigns the requested product to @product" do
      product = create(:product)
      get :show, params: { id: product }
      expect(assigns(:product)).to eq(product)
    end

    it "renders the #show view" do
      get :show, params: { id: create(:product) }
      expect(response).to  render_template :show
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new product" do
        expect {
          post :create, params: { product:
                                  attributes_for(:product,
                                                 user_id: @user.id,
                                                 category_id: @category.id) }
        }.to change(Product, :count).by(1)
      end

      it "redirects to the new product" do
        post :create, params: { product:
                                attributes_for(:product,
                                               user_id: @user.id,
                                               category_id: @category.id) }
        expect(response).to redirect_to Product.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new product" do
        expect {
          post :create, params: { product: attributes_for(:invalid_product) }
        }.to_not change(Product, :count)
      end

      it "re-renders the new method" do
        post :create, params: { product: attributes_for(:invalid_product) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @product = create(:product, user: @user)
    end

    it "deletes the product" do
      expect {
        delete :destroy, params: { id: @product }
      }.to change(Product, :count).by(-1)
    end

    it "redirects to products#index" do
      delete :destroy, params: { id: @product }
      expect(response).to redirect_to products_path
    end
  end

  describe 'PUT update' do
    before :each do
      @product = create(:product, name: "Sapatos", price: 10.00, user: @user)
    end

    context "valid attributes" do
      it "located the requested @product" do
        put :update, params: { id: @product, product: attributes_for(:product) }
        expect(assigns(:product)).to eq(@product)
      end

      it "changes @product's attributes" do
        put :update, params: { id: @product,
                               product: attributes_for(:product,
                                                       name: "Shoes",
                                                       price: 150.00) }
        @product.reload
        expect(@product.name).to eq("Shoes")
        expect(@product.price).to eq(150.00)
      end

      it "redirects to the updated product" do
        put :update, params: { id: @product, product: attributes_for(:product) }
        expect(response).to redirect_to @product
      end
    end

    context "invalid attributes" do
      it "locates the requested @product" do
        put :update, params: { id: @product,
                               product: attributes_for(:invalid_product) }
        expect(assigns(:product)).to eq(@product)
      end

      it "does not change @product's attributes" do
        put :update, params: { id: @product,
                               product: attributes_for(:product,
                                                       name: "Shoes",
                                                       price: nil) }
        @product.reload
        expect(@product.name).to_not eq("Shoes")
        expect(@product.price).to eq(10.00)
      end

      it "re-renders the edit method" do
        put :update, params: { id: @product,
                               product: attributes_for(:invalid_product) }
        expect(response).to render_template :edit
      end
    end
  end
end
