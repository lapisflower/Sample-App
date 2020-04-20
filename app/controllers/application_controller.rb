class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  # テキスト8.9。before_actionであらかじめ@userを定義する必要がある。
  before_action :set_user
  
  def set_user
     # session→paramsでも可？
     @user = User.find(session[:user_id])
  end
end
