# frozen_string_literal: true

class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.nil?
        scope.where(record_status: :published)
      elsif user.admin?
        scope.all
      else
        scope.joins(:events_users).where('record_status = ? OR (user_id = ? and role = ?)', Event.record_statuses[:published], user.id, EventsUser.roles[:creator]).distinct
      end
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present?
  end

  def update?
    user.present? && (user_is_creator? || user.admin?)
  end

  def destroy?
    return true if user.present? && (user_is_creator? || user.admin?)
  end

  def update_event_status?
    user.present? && user.admin?
  end

  def follow?
    user.present?
  end

  def unfollow?
    user.present?
  end

  private

  def event
    record
  end

  def user_is_creator?
    user == event.users.find_by(events_users: { role: EventsUser.roles[:creator] })
  end
end
