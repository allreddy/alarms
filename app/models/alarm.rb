class Alarm < ApplicationRecord

    validates :name, presence: true
    validates :text, length: { maximum: 20 }, format: { with: /\A[A-Z\s]+\z/, message: "Alarms must be in CAPS only!" }

end
