# frozen_string_literal: true

module SearchResources
  class SearchPoints < SearchResourcesBase
    def search(scoped, query = nil)
      query.blank? ? scoped : scoped.where(['lower(name) LIKE ?', "%#{query.downcase}%"])
    end

    def filter_by_category(scoped, route_type = nil)
      route_type.blank? ? scoped : scoped.where(route_type: route_type)
    end
  end
end
