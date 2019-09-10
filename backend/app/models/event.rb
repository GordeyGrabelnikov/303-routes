# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :route
  has_many :events_users, dependent: :destroy
  has_many :users, through: :events_users

  validates :event_name, :event_description, :event_date, presence: true

  enum event_status: { unpublished: 0, published: 1 }
end
