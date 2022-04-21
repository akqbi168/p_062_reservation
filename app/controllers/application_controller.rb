class ApplicationController < ActionController::Base

  before_action :header_definition
  before_action :header_search
  before_action :store_current_location, unless: :devise_controller?

  helper ApplicationHelper

  private

  def header_definition
    if user_signed_in?
      @reputations_to_my_properties = Reputation.where(property_id: current_user.properties.ids)
    end
  end

  def header_search
    # 予約ボタンを押してから15分経過すると確保していたルームが検索に表示される（予約処理は継続できるが、他の人に取られる可能性が出てくる）
    pending_entities_30mins_old = Entity.pending.where(updated_at: (Time.current - 15.minutes)..)
    pending_entities_30mins_old.update_all(occupied_status: "vacant")

    # 検索フォームのLIKE検索（空白で単語を分割）
    path = Rails.application.routes.recognize_path(request.referer)
    if path[:controller] == "entities" && path[:action] == "index" && params[:q].present?
      if params[:q]['property_name_or_property_introduction_cont_all'].present?
        params[:q]['property_name_or_property_introduction_cont_all'] = params[:q]['property_name_or_property_introduction_cont_all'].split(/[\p{blank}\s]+/)
      end
    end

    @q = Entity.vacant.ransack(params[:q])
    if @q.date_gteq.present? && @q.date_lt.present?

      # INがOUTより後の日付 => 両者を入れ替え
      if @q.date_gteq > @q.date_lt
        @q.date_gteq, @q.date_lt = @q.date_lt, @q.date_gteq

      # INとOUTが同日 => IN日を基準にOUT日を翌日に変更
      elsif @q.date_gteq == @q.date_lt
        @q.date_lt = @q.date_gteq + 1
      end

    # OUT日が空白 => IN日を基準にOUT日を翌日に設定
    elsif @q.date_gteq.present? && @q.date_lt.nil?
      @q.date_lt = @q.date_gteq + 1

    # IN日が空白 => OUT日を基準にIN日を前日に設定
    elsif @q.date_gteq.nil? && @q.date_lt.present?
      @q.date_gteq = @q.date_lt - 1

    # IN日、OUT日ともに空白 => IN日を明日に、OUT日を2日後に設定
    else
      @q.date_gteq = Date.current + 1
      @q.date_lt = @q.date_gteq + 1
  
    end
    @results = @q.result.joins(:property)
  end

  # ログイン前のページを記憶する
  def store_current_location
    store_location_for(:user, request.url)
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end

  # ログアウト時のリダイレクト先を現在のページに変更
  def after_sign_out_path_for(resource)
    request.referer
  end

end
