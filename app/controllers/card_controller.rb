class CardController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy]
  before_action :set_list, only: [:new, :create]

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      redirect_to top_index_path
    else
      render action: :new
    end
  end

  def show
  end

  def edit
    # Listモデルからuser_idが@curretn_user.idと一致するレコードの情報を取得する
    @lists = List.where(user: @current_user)
  end

  def destroy
    @card.destroy
    redirect_to top_index_path
  end

  def update
    if @card.update_attributes(card_params)
      redirect_to top_index_path
    else
      # バリデーション時にundefined method `map' for nil:NilClassとでるため下記記述
      @lists = List.where(user: @current_user)
      render action: :edit
    end
  end

  private
    def card_params
      # .marge(:list_id, params[:list_id])にするとカード移動ができなくなる
      params.require(:card).permit(:title, :memo, :list_id)
    end

    def set_card
      @card = Card.find_by(id: params[:id])
    end

    def set_list
      @list = List.find_by(id: params[:list_id])
    end
end
