class Reservation < ApplicationRecord

  has_many :entities
  belongs_to :user
  belongs_to :property

  enum generation: {
    '18〜19歳': 1,
    '20代': 2,
    '30代': 3,
    '40代': 4,
    '50代': 5,
    '60代': 6,
    '70代〜': 7
  }

  enum sex: {
    '男性': 1,
    '女性': 2,
    'その他': 9,
    '回答しない': 0
  }

  # ハイフンを含めない場合はこちら
  PHONE_NUMBER_REGEX = /\A0[0-9]{9,10}\z/
  # ハイフンを含める場合はこちら
  # PHONE_NUMBER_REGEX = /\A0[0-9-]{9,12}\z/

  with_options presence: true do
    validates :user_name
    validates :generation
    validates :sex
    validates :address, length: {minimum: 8}
    validates :phone_number, format: { with: PHONE_NUMBER_REGEX }
  end

end
