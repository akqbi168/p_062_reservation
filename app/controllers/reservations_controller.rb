class ReservationsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_reservation, only: [:new, :confirm, :create]

  def index
    @my_reservations = current_user.reservations.includes(:entities).order("entities.date")
  end

  def new
    @reservation = Reservation.new
    @my_latest_reservation = current_user.reservations.last
  end

  def confirm
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = current_user.id
    @reservation.property_id = @property.id
    session[:reservation] = reservation_params
    @reservation.assign_attributes(session[:reservation])

    render 'new' if @reservation.invalid?
  end

  def create
    @reservation = Reservation.new(session[:reservation])
    @reservation.user_id = current_user.id
    @reservation.property_id = @property.id
    if @property.if_dynamic_pricing == true
      @reservation.total_price = @my_entities.pluck(:price_ratio).map{|ratio| [ [@property.base_price * ratio, @property.min_price].max, @property.max_price].min }.sum.to_i + @property.reservation_fee
    else
      @reservation.total_price = @property.base_price * @my_entities.count + @property.reservation_fee
    end

    render 'new' and return if params[:back]

    if @reservation.save
      session.delete(:reservation)

      @my_entities.update_all(
        reservation_id: @reservation.id,
        cart_id: 0, 
        occupied_status: 3
      )
      @my_cart.destroy
      redirect_to reservation_path(@reservation), flash: { notice: "ご予約ありがとうございます。" }
    else
      render 'new'
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
    @path = Rails.application.routes.recognize_path(request.referer)
    @past_reputation = Reputation.find_by(user_id: @reservation.user_id, property_id: @reservation.property_id)
  end

  private

  def set_reservation
    @my_cart = Cart.where(user_id: current_user.id).last
    @my_entities = Entity.where(cart_id: @my_cart.id, date: @my_cart.ci_date...@my_cart.co_date).joins(:property)
    @property = @my_entities.last.property
  end

  def reservation_params
    params.require(:reservation).permit(
      :user_name,
      :generation,
      :sex,
      :address,
      :phone_number,
      :total_price
    )
  end

end
