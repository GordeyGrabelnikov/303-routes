# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :route
  has_many :events_users, dependent: :destroy
  has_many :users, through: :events_users

  validates :name, :description, :date, presence: true
  validates :name, uniqueness: { scope: %i[date route_id], message: 'This event exist already' }
  validate :date_cannot_be_in_the_past

  ratyrate_rateable :event

  enum record_status: { unpublished: 0, published: 1 }

  def creator
    users.find_by(events_users: { role: :creator })
  end

  def guide
    users.find_by(events_users: { role: :guide })
  end

  private

  def date_cannot_be_in_the_past
    errors.add(:expiration_date, "can't be in the past") if date.present? && date < Date.today
  end
end
