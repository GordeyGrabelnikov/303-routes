class RoutesRepository < BaseRepository
  option :relation, default: -> { Route }

  def public_routes
    relation.published
  end
end