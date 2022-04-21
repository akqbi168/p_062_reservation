class Property < ApplicationRecord

  has_many :entities, -> { order("date") }, inverse_of: :property
  accepts_nested_attributes_for :entities, reject_if: :all_blank, allow_destroy: true

  has_many :reservations
  has_many :reputations, dependent: :destroy
  has_many :favorites, dependent: :destroy

  belongs_to :user

  mount_uploader :main_image, ImageUploader
  mount_uploaders :sub_images, ImageUploader

  enum city: {
    '01: 北海道':1,  '02: 青森県':2,  '03: 岩手県':3,  '04: 宮城県':4,    '05: 秋田県':5,  '06: 山形県':6,    '07: 福島県':7,  '08: 茨城県':8,  '09: 栃木県':9,  '10: 群馬県':10,
    '11: 埼玉県':11, '12: 千葉県':12, '13: 東京都':13, '14: 神奈川県':14, '15: 新潟県':15, '16: 富山県':16,   '17: 石川県':17, '18: 福井県':18, '19: 山梨県':19, '20: 長野県':20,
    '21: 岐阜県':21, '22: 静岡県':22, '23: 愛知県':23, '24: 三重県':24,   '25: 滋賀県':25, '26: 京都府':26,   '27: 大阪府':27, '28: 兵庫県':28, '29: 奈良県':29, '30: 和歌山県':30,
    '31: 鳥取県':31, '32: 島根県':32, '33: 岡山県':33, '34: 広島県':34,   '35: 山口県':35, '36: 徳島県':36,   '37: 香川県':37, '38: 愛媛県':38, '39: 高知県':39, '40: 福岡県':40,
    '41: 佐賀県':41, '42: 長崎県':42, '43: 熊本県':43, '44: 大分県':44,   '45: 宮崎県':45, '46: 鹿児島県':46, '47: 沖縄県':47
  }

  enum occupied_status: {
    '空室':1, '検討中':2, '予約済み':3
  }

  POSTAL_CODE_REGEX = /\A\d{3}[-]?\d{4}\z/

  with_options presence: true do
    validates :name, length: {maximum: 32}
    validates :postal_code, format: { with: POSTAL_CODE_REGEX }
    validates :city
    validates :address
    validates :introduction, length: {maximum: 400}
    validates :base_price, numericality: {less_than_or_equal_to: 999999}
  end

  validates :min_price, numericality: {less_than_or_equal_to: 999999}
  validates :max_price, numericality: {less_than_or_equal_to: 999999}
  validates :reservation_fee, numericality: {less_than_or_equal_to: 999999}
  validates :max_capacity, numericality: {less_than_or_equal_to: 9}

end
