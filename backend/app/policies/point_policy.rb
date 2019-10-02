# frozen_string_literal: true

class PointPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.nil?
        scope.where(point_status: :published)
      elsif user.admin?
        scope.all
      else
        scope.where('point_status = ? OR user_id = ?', Point.point_statuses[:published], user.id)
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
    user.present? && (user == point.user || user.admin?)
  end

  def destroy?
    user.present? && (user == point.user || user.admin?)
  end

  def update_point_status?
    user.present? && user.admin?
  end

  private

  def point
    record
  end
end
