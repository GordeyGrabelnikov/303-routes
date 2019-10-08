# frozen_string_literal: true

module Events
  class Create < BaseServiceObject
    param :user
    param :event_param

    def call
      event.save!
      EventsUsers::Create.call(event, user, role: :creator)
      event
    end

    private

    def event
      @event ||= Event.new(event_param)
    end
  end
end
