# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :route
  has_many :events_users, dependent: :destroy
  has_many :users, through: :events_users

  validates :event_name, :event_description, :event_date, presence: true
  validate :event_date_cannot_be_in_the_past

  enum event_status: { unpublished: 0, published: 1 }

  def creator
    users.find_by(events_users: { role: EventsUser.roles[:creator] })

  private

  def event_date_cannot_be_in_the_past
    errors.add(:expiration_date, "can't be in the past") if event_date.present? && event_date < Date.today
  end
end
