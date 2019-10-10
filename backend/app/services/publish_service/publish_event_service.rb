# frozen_string_literal: true

module PublishService
  class PublishEventService < PublishService::PublishService
    def call
      record.event_status = :published
      record.save!
      UserMailer.with(resource: record, user: record.creator).confirm_event_email.deliver_now
    end
  end
end
