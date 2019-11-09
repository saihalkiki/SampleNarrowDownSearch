class Event < ApplicationRecord
  validates :title, presence: true
  validates :start_datetime, presence: true
  validates :end_datetime, presence: true
  validates :prefecture, presence: true
end
