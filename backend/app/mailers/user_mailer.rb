class UserMailer < ApplicationMailer

    default from: '303routes@example.com'

    def confirm_email
      @resource = params[:resource]
      mail(to: @resource.user.email, subject: 'Welcome to My Awesome Site')
    end


    def confirm_event_email
      @resource = params[:resource]
      mail(to: @resource.creator.email, subject: 'Welcome to My Awesome Site')
    end


end
