# frozen_string_literal: true

require 'sidekiq-scheduler'

class EventArchiving
  include Sidekiq::Worker

  def perform(*_args)
    @events = Event.where(['date = ?', Time.zone.today])
    @events.each do |event|
      event.archived!
      event.save
    end
  end
end
