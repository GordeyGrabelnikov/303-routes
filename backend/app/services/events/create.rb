# frozen_string_literal: true

require 'dry/transaction'

module Events
  class Create
    include Dry::Transaction(container: TransactionContainer)

    around :transaction, with: 'transaction'
    tee :params
    step :create_event
    step :add_creator
    step :add_guide

    def params(input)
      @event_params = input.fetch(:params)
      @guide_id = input.fetch(:guide_id)
      @user = input.fetch(:user)
    end

    def create_event
      @event = Event.create(@event_params)

      if @event.errors.any?
        Failure(error: @event.errors.full_messages.join(' | '))
      else
        Success(@event)
      end
    end

    def add_creator
      creator = EventsUsers::Create.call(@event.id, @user.id, role: :creator)
      if creator.errors.any?
        Failure(error: creator.errors.full_messages.join(' | '))
      else
        Success(@event)
      end
    end

    def add_guide
      if @guide_id.present?
        event_guide = EventsUsers::Create.call(@event.id, @guide_id, role: :guide)
        return Failure(error: event_guide.errors.full_messages.join(' | ')) if event_guide.errors.any?
      end
      Success(@event)
    end
  end
end
