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
      unless @user.valid?
        # falseになった場合は、newアクションへrender
        render :new and return
      end
      # sessionにハッシュオブジェクトの形で情報を保持させるために、attributesメソッドを用いてデータを整形
    session["regist_data"] = {user: @user.attributes}
    # attributesメソッドでデータ整形をした際にパスワードの情報は含まれていいないので、パスワードを再度sessionに代入する。
    session["regist_data"][:user]["password"] = params[:user][:password]
    # ユーザーモデルに紐づく住所情報を入力させるため、該当するインスタンスを生成
    @address = @user.build_address
    # 住所情報を登録させるページを表示するnew_addressアクションのビューへrender住所情報を登録させるページを表示するnew_addressアクションのビューへrender
    render :new_address

  end

  def create_address
    @user = User.new(session["regist_data"]["user"])
    @address = Address.new(address_params)
      unless @address.valid?
        # 設定したバリデーションの条件を満たさない場合は、renderメソッドによってnew_addressアクションに画面遷移
        render :new_address and return #ユーザーの情報は保存されてしまうため、防ぐためにand return
      end
    @user.build_address(@address.attributes)
    @user.save
    session[:user_id] = @user.id #ログインに必要なsessionを作成
    session["regist_data"]["user"].clear #登録に必要なsessionを削除する

    flash[:notice] = "ようこそ！#{@user.name}さん"
      redirect_to user_path(@user)
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

  def address_params
    params.require(:address).permit(:postal_code, :address)
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
