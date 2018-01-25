require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:admin) { create(:admin) }
  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in admin
  end

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new category" do
        expect {
          post :create, params: { category:
                                  attributes_for(:category) }
        }.to change(Category, :count).by(1)
      end

      it "redirects to the new category" do
        post :create, params: { category: attributes_for(:category) }
        expect(response).to redirect_to products_path
      end
    end

    context "with invalid attributes" do
      it "does not save the new category" do
        expect {
          post :create, params: { category:
                                  attributes_for(:invalid_category) }
        }.to_not change(Category, :count)
      end

      it "re-renders the new method" do
        post :create, params: { category: attributes_for(:invalid_category) }
        expect(response).to render_template :new
      end
    end
  end
end
