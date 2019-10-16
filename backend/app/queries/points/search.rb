# frozen_string_literal: true

module Points
  class Search < BaseQueryObject
    param :initial_scope

    option :search, optional: true
    option :category, optional: true

    def call
      scoped = initial_scope
      scoped = scoped.where(['lower(name) LIKE ?', "%#{search.downcase}%"]) if search.present?

      scoped
    end
  end
end
