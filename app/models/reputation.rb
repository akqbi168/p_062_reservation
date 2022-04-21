class Reputation < ApplicationRecord

  belongs_to :user
  belongs_to :property

  with_options presence: true do
    validates :rating
  end

end
