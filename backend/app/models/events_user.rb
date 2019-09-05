# frozen_string_literal: true

class EventsUser < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :user_id, uniqueness: { scope: :event_id }

  enum role: %i[follower creator]
end
