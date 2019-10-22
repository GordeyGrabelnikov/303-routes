# frozen_string_literal: true

module Routes
  class Publish < BaseServiceObject
    param :route

    def call
      route.published!
      route.save!
      UserMailer.with(resource: route, user: route.user).confirm_email.deliver_later
    end
  end
end
