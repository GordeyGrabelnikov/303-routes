# frozen_string_literal: true

require 'dry/transaction'

module Events
  class Update
    include Dry::Transaction(container: TransactionContainer)

    around :transaction, with: 'transaction'
    tee :params
    step :update_event
    step :current_guide_check
    step :change_guide

    def params(input)
      @event = input.fetch(:event)
      @event_params = input.fetch(:event_params)
      @guide_id = input.fetch(:guide_id)
    end

    def update_event
      if @event.present?
        @event.update(@event_params)
        return Failure(error: @event.errors.full_messages.join(' | ')) if @event.errors.any?

        return Success(@event)
      end
      Failure(error: 'Event not exist')
    end

    def current_guide_check
      if @event.guide.present?
        destroy_current_guide unless @guide_id == @event.guide.id
      end
      Success(@event)
    end

    def change_guide
      if @guide_id.present? && event_without_guide?
        new_event_guide = EventsUsers::Create.call(@event.id, @guide_id, role: :guide)
        return Failure(error: new_event_guide.errors.full_messages.join(' | ')) if new_event_guide.errors.any?
      end
      Success(@event)
    end

    private

    def destroy_current_guide
      EventsUser.where(event: @event, role: :guide).first.destroy
    end

    def event_without_guide?
      !@event.guide
    end
  end
end
