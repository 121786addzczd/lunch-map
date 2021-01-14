class ApplicationController < ActionController::Base
  before_action :set_current_user

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  # authenticate_userは「ユーザーを認証する」という意味
  def authenticate_user
    # @current_userがauthenticate_userメソッドの中でも使用されているが、@変数で定義した変数は同じクラスの異なるメソッド間で共通して使用することが可能
    if @current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to login_path
    end
  end

  # forbid_login_userはログインユーザーを禁止するという意味
  def forbid_login_user
    if @current_user
      flash[:notice] = "すでにログインしています"
      redirect_to root_path
    end
  end
end
