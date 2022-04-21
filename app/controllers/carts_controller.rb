class CartsController < ApplicationController

  before_action :authenticate_user!

  def create
    cart = Cart.new(
      user_id: current_user.id,
      ci_date: params[:cid].to_date,
      co_date: params[:cod].to_date,
    )
    cart.save

    my_entities = Entity.where(property_id: params[:pid].to_i, date: cart.ci_date...cart.co_date)
    my_entities.update_all(occupied_status: "pending", cart_id: cart.id, updated_at: Time.current)
    redirect_to new_reservation_path(cart_id: cart.id)
  end

end
