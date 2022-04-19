class HomesController < ApplicationController

  before_action :set_price_ratio

  def top
    @top_phrase = "Skybnbへようこそ！\nキーワードや日にちを入力して\nルームを検索しましょう！"

    if Property.where.not(main_image: nil).count >= 4
      @properties = Property.where.not(main_image: nil).order("RANDOM()").limit(4)
    else
      @properties = Property.order("main_image DESC").order("RANDOM()").limit(4)
    end

    @random_cities = Property.select(:city).distinct.order("RANDOM()").limit(4)
  end

  def welcome
  end

  private

  # seedを入力した場合に適用
  def set_price_ratio
    inactive_entities = Entity.where(price_ratio: 0)

    inactive_entities.each do |e|
      # 祝前日 or 土曜日 => 120%
      if HolidayJp.holiday?(e.date.tomorrow) == true || e.date.wday == 6
        ratio = 1.2
      # 金曜日 => 110%
      elsif e.date.wday == 5
        ratio = 1.1
      # 日曜日 or 月曜日 => 90%
      elsif e.date.wday == 0 || e.date.wday == 1
        ratio = 0.9
      # それ以外 => 100%
      else
        ratio = 1.0
      end

      e.update(price_ratio: ratio)
    end
  end

end
