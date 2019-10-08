# frozen_string_literal: true

module Events
  class Create < BaseServiceObject
    param :user
    param :event_param

    option :guide_id, default: -> { '' }


    def call
      event.save!
      EventsUsers::Create.call(event, user, role: :creator)
      if guide_id.present?
        guide = User.find_by(id: guide_id)
        EventsUsers::Create.call(event, guide, role: :guide)
      end
      event
    end

    private

    def event
      @event ||= Event.new(event_param)
    end
  end
end
