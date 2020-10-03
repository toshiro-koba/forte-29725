class GiftsController < ApplicationController
  def index
    redirect_to new_user_session_path unless user_signed_in?
    @reciver = User.find(params[:user_id])
    @user = User.find(params[:user_id])
    redirect_to root_path if @reciver == current_user
    @gift = Gift.new
  end

  def new; end

  def create
    @reciver = User.find(params[:user_id])
    @user = User.find(params[:user_id])
    @gift = Gift.new(order_params)
    if @gift.valid?
      pay_item
      @gift.save
      redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def order_params
    params.require(:gift).permit(:price).merge(user_id: @reciver.id, giver_id: current_user.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']  # PAY.JPテスト秘密鍵
    Payjp::Charge.create(
      amount: order_params[:price], # 商品の値段
      card: params[:token], # カードトークン
      currency: 'jpy'                 # 通貨の種類(日本円)
    )
  end
end
