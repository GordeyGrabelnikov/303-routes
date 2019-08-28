class EventsUser < ApplicationRecord
  enum role: [ :follower, :creator]
  belongs_to :event
  belongs_to :user
  validates :user_id, uniqueness: { scope: :event_id }
end
