# frozen_string_literal: true
module PublishService
  class PublishService < BaseServiceObject
    param :record
    param :publishable

    def call
      record.send("#{publishable}_status=", :published)
      record.save!
      UserMailer.with(resource: record, user: record.user).confirm_email.deliver_later
    end
  end
end