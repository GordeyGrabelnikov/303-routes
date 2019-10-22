# frozen_string_literal: true

module Points
  class Publish < BaseServiceObject
    param :point

    def call
      point.published!
      point.save!
      UserMailer.with(resource: point, user: point.user).confirm_email.deliver_later
    end
  end
end
