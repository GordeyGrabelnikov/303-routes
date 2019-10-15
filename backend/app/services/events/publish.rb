# frozen_string_literal: true

module Events
  class Publish < BaseServiceObject
    param :event

    def call
      event.published!
      event.save!
      UserMailer.with(resource: event, user: event.creator).confirm_event_email.deliver_later
    end
  end
end
