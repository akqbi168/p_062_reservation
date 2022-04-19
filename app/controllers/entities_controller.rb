class EntitiesController < ApplicationController

  def index
    @properties = Property.all

    # 検索結果を一覧表示する時に、過去のカートデータを取り除く
    if user_signed_in?
      my_carts = Cart.where(user_id: current_user.id)
      old_carts = my_carts.where.not(id: my_carts.last.id) unless my_carts.empty?
      old_carts.destroy_all unless old_carts.nil? || old_carts.empty?
    end
  end

end
