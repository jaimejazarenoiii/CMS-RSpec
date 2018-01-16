module Users
  class SessionsController < Devise::SessionsController
    def create
      redirect_to products_path, notice: "Successful login" if user_signed_in?
    end
  end
end
