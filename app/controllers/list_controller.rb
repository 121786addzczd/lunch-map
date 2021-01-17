class ListController < ApplicationController

  def index
    @lists = List.where(user: @current_user).order("created_at ASC")
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to :root
    else
      render action: :new
    end
  end

  private
    def list_params
      params.require(:list).permit(:title).merge(user: @current_user)
    end

end
