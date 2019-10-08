# frozen_string_literal: true

module EventsUsers
  class Create < BaseServiceObject
    param :event
    param :user

    option :role, default: -> { :follower }

    def call
      events_user.save!
    end

    private

    def events_user
      @events_user ||= EventsUser.new(event: event, user: user, role: role)
    end
  end
end
