# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :route
  has_many :events_users
  has_many :users, through: :events_users
end
