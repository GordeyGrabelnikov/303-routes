# frozen_string_literal: true

class RoutePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.nil?
        scope.where(record_status: :published)
      elsif user.admin?
        scope.all
      else
        scope.where('record_status = ? OR user_id = ?', Route.record_statuses[:published], user.id)
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
    user.present? && (user == route.user || user.admin?)
  end

  def destroy?
    user.present? && (user == route.user || user.admin?)
  end

  def update_route_status?
    user.present? && user.admin?
  end

  private

  def route
    record
  end
end
