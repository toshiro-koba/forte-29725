class GiftsController < ApplicationController
  def index
    @reciver = User.find(params[:user_id])
    @gift = Gift.new
  end

  def new
  end

  def create
    @reciver = User.find(params[:user_id])
    @gift = Gift.new(order_params)
    if @gift.valid?
      pay_item
      @gift.save
      return redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def order_params
    params.require(:gift).permit(:price).merge(user_id: @reciver.id, giver_id: current_user.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # PAY.JPテスト秘密鍵
    Payjp::Charge.create(
      amount: order_params[:price], # 商品の値段
      card: params[:token], # カードトークン
      currency: 'jpy'                 # 通貨の種類(日本円)
    )
  end
end
