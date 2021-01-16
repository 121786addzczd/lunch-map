class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:index, :show, :edit, :update]
  # ログインユーザーは以下のアクションを禁止
  before_action :forbid_login_user, only: [:new, :create, :login_form, :login]
  # ログイン中のユーザーのidと編集したいユーザーのidが等しいか判定
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        flash[:notice] = "ようこそ！#{@user.name}さん"
        redirect_to user_path(@user)
      else
        render :new
      end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = '退会の手続きが完了しました'
    redirect_to root_path
  end


  def login_form
  end

  def login
    # 入力内容と一致するユーザーを取得し、変数@userに代入
    @user = User.find_by(email: params[:email])
    # @userが存在するかどうかを判定
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to user_path(@user)
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"

      # @emailと@passwordを定義
      @email = params[:email]
      @password = params[:password]

      render :login_form
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to login_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :profile, :image)
  end

  def set_user
    @user = User.find(params[:id])
  end

  # 正しいユーザーかを確かめるという意味のensure_correct_userメソッドを定義
  def ensure_correct_user
    # ログイン中のユーザーのidと編集したいユーザーのidが等しいか判定
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to root_path
    end
  end
end
