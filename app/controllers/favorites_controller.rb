class FavoritesController < ApplicationController

  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @favorite = Favorite.new(
      user_id: current_user.id,
      property_id: params[:pid]
    )

    if @favorite.save
      flash[:notice] = "いいねしました！"
    else
      flash[:alert] = "処理に失敗しました。"
    end
    redirect_to request.referer
  end

  def destroy
    @favorite = Favorite.find(params[:fid])

    if @favorite.destroy
      flash[:notice] = "いいねをやめました。"
    else
      flash[:alert] = "処理に失敗しました。"
    end

    redirect_to request.referer
  end

end
