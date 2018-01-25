require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:admin) { create(:admin) }
  let(:category) { create(:category) }

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in admin
  end

  describe "GET #new" do
    it "assigns a new category as @category" do
      get :new
      expect(assigns(:category)).to be_a_new(Category)
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new category" do
        expect {
          post :create, params: { category: attributes_for(:category) }
        }.to change(Category, :count).by(1)
      end

      it "redirects to the new category" do
        post :create, params: { category: attributes_for(:category) }
        expect(response).to redirect_to products_path
      end
    end
  end
end
