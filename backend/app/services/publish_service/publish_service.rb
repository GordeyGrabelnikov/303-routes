# frozen_string_literal: true

module PublishService
  class PublishService < BaseServiceObject
    param :record

    def call
      record.public_send("#{publishable}_status=", :published)
      record.save!
      UserMailer.with(resource: record, user: record.user).confirm_email.deliver_later
    end

    def publishable
      "#{record.class}".downcase
    end
  end
end
