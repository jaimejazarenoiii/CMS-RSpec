require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "GET #index" do
    it "populates an array of users" do
      user = create(:user)
      get :index
      expect(assigns(:users)).to eq([user])
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    it "assigns the requested user to @user" do
      user = create(:user)
      get :show, params: { id: user }
      expect(assigns(:user)).to eq(user)
    end

    it "renders the #show view" do
      get :show, params: { id: create(:user) }
      expect(response).to  render_template :show
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new user" do
        expect {
          post :create, params: { user:
                                  attributes_for(:user) }
        }.to change(User, :count).by(1)
      end

      it "redirects to the new user" do
        post :create, params: { user: attributes_for(:user) }
        expect(response).to redirect_to root_path
      end
    end

    context "with invalid attributes" do
      it "does not save the new user" do
        expect {
          post :create, params: { user:
                                  attributes_for(:invalid_user) }
        }.to_not change(User, :count)
      end
    end
  end

  describe 'PUT update' do
    before :each do
      @user = create(:user, fname: "Lodi", lname: "Pitmalo")
      sign_in @user
    end

    context "valid attributes" do
      it "located the requested @user" do
        put :update, params: { id: @user, user: attributes_for(:user) }
        expect(assigns(:user)).to eq(@user)
      end

      it "changes @user's attributes" do
        put :update, params: { id: @user,
                               user: attributes_for(:user,
                                                    fname: "Idol",
                                                    lname: "Malopit") }
        @user.reload
        expect(@user.fname).to eq("Idol")
        expect(@user.lname).to eq("Malopit")
      end

      it "redirects to the updated user" do
        put :update, params: { id: @user, user: attributes_for(:user) }
        expect(response).to redirect_to @user
      end
    end

    context "invalid attributes" do
      it "locates the requested @user" do
        put :update, params: { id: @user,
                               user: attributes_for(:invalid_user) }
        expect(assigns(:user)).to eq(@user)
      end

      it "does not change @user's attributes" do
        put :update, params: { id: @user,
                               user: attributes_for(:user,
                                                    fname: nil,
                                                    lname: "Malopit") }
        @user.reload
        expect(@user.fname).to eq("Lodi")
        expect(@user.lname).to_not eq("Malopit")
      end

      it "re-renders the edit method" do
        put :update, params: { id: @user,
                               user: attributes_for(:invalid_user) }
        expect(response).to render_template :edit
      end
    end
  end
end
