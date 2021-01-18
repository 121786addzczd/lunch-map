class ListController < ApplicationController
  before_action :set_list, only: [:edit, :update, :destroy]

  def index
    @lists = List.where(user: @current_user).order("created_at ASC")
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to top_index_path
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    if @list.update_attributes(list_params)
      redirect_to top_index_path
    else
      render action: :edit
    end
  end

  def destroy
    @list.destroy
    redirect_to top_index_path
  end

  private
    def list_params
      params.require(:list).permit(:title).merge(user: @current_user)
    end

    def set_list
      # find_byは与えられた条件にマッチするレコードのうち最初のレコードだけを返す
      @list = List.find_by(id: params[:id])
    end

end
