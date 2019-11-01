# frozen_string_literal: true

class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.nil?
        scope.where.not(record_status: :unpublished)
      elsif user.admin?
        scope.all
      else
        published_or_user_follower(scope, user)
      end
    end

    private

    def published_or_user_follower(scope, user)
      scope.joins(:events_users)
           .where('record_status = ? OR user_id = ?', Event.record_statuses[:published], user.id)
           .distinct
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
    user.present? && (user == event.creator || user.admin?)
  end

  def destroy?
    user.present? && (user == event.creator || user.admin?)
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
end
