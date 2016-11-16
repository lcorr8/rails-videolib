class UsersController < ApplicationController
  before_action :set_user
  before_action :set_user_record, only: [:show, :update, :destroy]

  def index
    @users = User.all
    authorize @user
  end

  def new
  end

  def create
  end

  def show
    authorize @user
  end

  def edit
  end

  def update
    authorize @user
    #password wont save with omniauth sign up, so i have to re do it here.... :/ ?
    @user_record.password = Devise.friendly_token[0,20]

    if @user_record.update(user_record_params)
      redirect_to user_path(@user_record)
      flash[:notice] = "User updated"
    else
      redirect_to user_path(@user_record)
      flash[:error] = "Unable to Update User"
    end
    #make it so admins can't demote themselves and only other admins can edit them
  end

  def destroy
    authorize @user_record
    if @user_record.destroy
      redirect_to users_path
      flash[:notice] = "User deleted"
    else
      redirect_to user_path(@user_record)
      flash[:error] = "Unable to Delete User"
    end
  end


  private

    def set_user
      @user = current_user
    end

    def set_user_record
      @user_record = User.find(params[:id])
    end

    def user_record_params
      params.require(:user).permit(:role)
    end
end
