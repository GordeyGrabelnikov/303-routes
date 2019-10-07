# frozen_string_literal: true

module SearchResources
  class SearchEvents < SearchResourcesBase
    def search(scoped, query = nil)
      query.blank? ? scoped : scoped.where(['lower(event_name) LIKE ?', "%#{query.downcase}%"])
    end

    def filter_by_category(scoped, route_name = nil)
      route_name.blank? ? scoped : scoped.where(route_id: route_name)
    end
  end
end
