class PropertiesController < ApplicationController

  before_action :authenticate_user!, except: [:show]
  before_action :set_property, only: [:show, :edit, :update, :multiple_updates, :destroy]
  before_action :vacancy_check, only: [:show]

  def index
    @properties = current_user.properties.all
  end

  def new
    @property = Property.new
    @entity = @property.entities.build
  end

  def create
    @property = Property.new(property_params)
    @property.user_id = current_user.id
    if @property.save
      redirect_to property_path(@property), flash: { notice: "ルーム情報を登録しました。" }
    else
      render 'new'
    end
  end

  def show
    average_rating
    @entities = @property.entities
    @reputations = @property.reputations.where.not(testimonial: [nil, '']).where(visible: true).order("created_at")

    @favorites = @property.favorites
    @favorite = Favorite.find_by(user_id: current_user, property_id: @property) if user_signed_in?

    redirect_to_properties_show_after_log_in
  end

  def edit
    @reputations = @property.reputations.where.not(testimonial: [nil, '']).where(visible: true).order("created_at")
  end

  def update
    if @property.update(property_params)
      redirect_to property_path(@property), flash: { notice: "ルーム情報を更新しました。" }
    else
      render 'edit'
    end
  end

  def multiple_updates
    if params[:num] =~ /^[0-9]+$/
      params[:num].to_i.times do

      add_entity

      end
      flash[:notice] = "#{params[:num]}日分を追加しました。"

    elsif params[:num] == "end_of_month"
      latest_entity = @property.entities.last

      until latest_entity.date == latest_entity.date.end_of_month

        add_entity

        latest_entity = @property.entities.last
      end

      flash[:notice] = "月末まで追加しました。"
    end

    redirect_to property_path(@property)
  end

  def destroy
    if @property.destroy
      flash[:notice] = "ルーム情報を削除しました"
      redirect_to root_path
    else
      flash[:alert] = "ルーム情報を削除できませんでした"
      redirect_to users_mypage_path
    end
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end

  def vacancy_check
    @path = Rails.application.routes.recognize_path(request.referer)
    if @path[:controller] == "properties" && @path[:action] == "show"
      if @q.date_gteq.present? &&
        @q.date_lt.present? &&
        @q.property_name_or_property_introduction_cont_all.present? then

        cid = @q.date_gteq
        cod = @q.date_lt
        p_name = @q.property_name_or_property_introduction_cont_all
        property = Property.find_by(name: p_name)

        if @q.property_max_capacity_gteq.present?
          if property.entities.where(date: cid...cod).vacant.count == cod.to_date - cid.to_date &&
            @q.property_max_capacity_gteq <= @property.max_capacity then
            
            flash[:notice] = "空室がありました。このまま予約する場合は「予約にすすむ」を押してください。"
            redirect_to property_path(@property, cid: cid, cod: cod)
          else
            flash[:alert] = "空室がありません。条件を変更してください。"
            redirect_to entities_path
          end
        else
          if property.entities.where(date: cid...cod).vacant.count == cod.to_date - cid.to_date            
            flash[:notice] = "空室がありました。このまま予約する場合は「予約にすすむ」を押してください。"
            redirect_to property_path(@property, cid: cid, cod: cod)
          else
            flash[:alert] = "空室がありません。条件を変更してください。"
            redirect_to entities_path
          end
        end

      end
    end
  end

  def add_entity
    latest_entity = @property.entities.last

    entity = Entity.new(
      property_id: @property.id,
      date: latest_entity.date.tomorrow
    )

    unless entity.save
      flash[:notice] = "追加できませんでした。"
      redirect_to 'show'
    end
  end

  def average_rating
    @average_rating = @property.reputations.sum(:rating) / @property.reputations.count
  end

  def property_params
    params.require(:property).permit(
      :name,
      :postal_code,
      :country,
      :city,
      :address,
      :introduction,
      :main_image,
      {sub_images: []},
      :if_dynamic_pricing,
      :base_price,
      :min_price,
      :max_price,
      :reservation_fee,
      :max_capacity,
      entities_attributes: [
        :id,
        :date,
        :_destroy
      ]
    )
  end

  def redirect_to_properties_show_after_log_in
    path = Rails.application.routes.recognize_path(request.referer)
    if path[:controller] == "properties" &&
      path[:action] == "show" &&
      params[:cid].present? &&
      params[:cod].present? then
      authenticate_user!
    end
  end

end
