class Entity < ApplicationRecord

  belongs_to :property
  belongs_to :cart, optional: true
  belongs_to :reservation, optional: true

  enum occupied_status: {
    vacant: 1,
    pending: 2,
    occupied: 3
  }

  with_options presence: true do
    validates :date, uniqueness: { scope: :property_id }
  end

  scope :vacant, -> { where(occupied_status: "vacant") }
  scope :pending, -> { where(occupied_status: "pending") }
  scope :occupied, -> { where(occupied_status: "occupied") }

end
