# frozen_string_literal: true

module Events
  class Create < BaseServiceObject
    param :user

    option :event_name
    option :event_description
    option :event_date
    option :route_id
    option :guide_id, optional: true

    def call
      validate
      return event unless valid?

      event.save!
      EventsUsers::Create.call(event, user, role: :creator)
      if guide_id.present?
        guide = User.find_by(id: guide_id)
        EventsUsers::Create.call(event, guide, role: :guide)
      end
      event
    end

    private

    def validate
      errors.add(:base, 'please specify user') unless user
      errors.merge_with_models(event) unless event.valid?
    end

    def event
      @event ||= Event.new(event_name: event_name, event_description: event_description, event_date: event_date, route_id: route_id)
    end
  end
end




