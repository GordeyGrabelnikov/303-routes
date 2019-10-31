# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :route
  has_many :events_users, dependent: :destroy
  has_many :users, through: :events_users

  has_one :guide_events_user, -> { where(role: :guide) }, class_name: 'EventsUser', inverse_of: false
  has_one :guide, through: :guide_events_user, class_name: 'User', source: :user

  has_one :creator_events_user, -> { where(role: :creator) }, class_name: 'EventsUser', inverse_of: false
  has_one :creator, through: :creator_events_user, class_name: 'User', source: :user

  validates :name, :description, :date, presence: true
  validates :name, uniqueness: { scope: %i[date route_id], message: 'This event exist already' }
  validate :date_cannot_be_in_the_past

  ratyrate_rateable :event

  enum record_status: { unpublished: 0, published: 1, archived: 2 }

  def role(user)
    events_users.find_by(events_users: { user: user }).role
  end

  private

  def date_cannot_be_in_the_past
    errors.add(:expiration_date, "can't be in the past") if date.present? && date < Time.zone.today
  end
end
