class UsersController < ApplicationController
   before_action :logged_in_user, only: [:edit, :update]
   before_action :correct_user, only: [:edit, :update]
   before_action :admin_user, only: [:destroy, :index]
   before_action :admin_or_correct_user, only: :edit
  
 
  def index
    @users = User.paginate(page: params[:page], per_page: 20)
  end
 
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to user_url
    else render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end
 
  
  private
   
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end
    
     # アクセスしたユーザーが現在ログインしているユーザーか確認します。
    def correct_user
      redirect_to(root_url) unless current_user?(@user)
    end
    
     # システム管理権限所有かどうか判定します。
    def admin_user
      redirect_to root_url unless current_user.admin?
    end
    
    def admin_or_correct_user
      @user = User.find(params[:user_id]) if @user.blank?
      unless current_user?(@user) || current_user.admin?
        flash[:danger] = "編集権限がありません。"
        redirect_to(root_url)
      end  
    end
end