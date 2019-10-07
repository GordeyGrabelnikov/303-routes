# frozen_string_literal: true

class SearchResourcesBase
  attr_accessor :initial_scope

  def initialize(initial_scope)
    @initial_scope = initial_scope
  end

  def call(params)
    scoped = search(initial_scope, params[:search])
    scoped = filter_by_category(scoped, params[:category])

    scoped
  end
end
