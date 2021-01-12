class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_admin

  def index
    @users = User.all.page(params[:page]).per(20)
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_user_url(@user), notice: "ユーザー#{@user.name}を登録しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_url(@user), notice: "ユーザー#{@user.name}を更新しました"
    else
      render :edit
    end
  end

  def destroy
    if @user == current_user
      redirect_to admin_user_url, alert: 'このユーザーは削除できません'
    else
      @user.destroy
      redirect_to admin_users_url, notice: "ユーザー#{@user.name}を削除しました"
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
    end

    def require_admin
      redirect_to root_url unless current_user.admin?
    end
end
