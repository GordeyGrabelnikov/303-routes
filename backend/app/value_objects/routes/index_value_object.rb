module Routes
  class IndexValueObject < BaseValueObject
    param :user

    def public_routes
      @public_routes ||= RoutesRepository.new.public_routes
    end
  end
end