module ControllerMacros
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = create(:user, email: "ken@yahoo.com")
      sign_in :user, user
    end
  end
end
