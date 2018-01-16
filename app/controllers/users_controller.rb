class UsersController < Devise::RegistrationsController
  before_action :ensure_valid_user, only: %i[update]

  def index
    @users = User.where(role: User.roles[:normal])
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      redirect_to root_path, notice: "Successful"
    end
  end

  def update
    if @user.update_attributes(user_update_params)
      redirect_to user_path(@user.id), notice: "Successful"
    else
      render "edit"
    end
  end

  private

  def user_params
    permit_params_1 = :birthdate, :fname, :lname, :mobile
    permit_params_2 = :avatar, :password, :password_confirmation, :email
    params.require(:user).permit(permit_params_1, permit_params_2)
  end

  def user_update_params
    params.require(:user).permit(:birthdate, :fname, :lname, :mobile, :avatar)
  end

  def ensure_valid_user
    @user = User.find(params[:id])
    unless @user == current_user || current_user.admin?
      redirect_to user_path(@user.id), alert: "Invalid User"
    end
  end
end
