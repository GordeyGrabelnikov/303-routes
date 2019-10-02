# frozen_string_literal: true

class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.nil?
        scope.where(event_status: :published)
      elsif user.admin?
        scope.all
      else
        scope.joins(:events_users).where('event_status = ? OR (user_id = ? and role = ?)', Event.event_statuses[:published], user.id, EventsUser.roles[:creator])
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

  private

  def event
    record
  end

  def user_is_creator?
    return true if user == event.users.find_by(events_users: { role: EventsUser.roles[:creator] })
  end
end
