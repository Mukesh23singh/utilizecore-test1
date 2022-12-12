class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def status_email
    @parcel = params[:parcel]
    @sender = @parcel.sender
    @receiver = @parcel.receiver
    @url  = 'http://localhost:3000/search'
    mail(to: @sender.email, cc: @receiver.email,  subject: 'New Parcel Information')
    mail(to: @receiver.email, cc: @sender.email,  subject: 'New Parcel Information')
  end

  def status_email_sender
    @parcel = params[:parcel]
    @sender = @parcel.sender
    @receiver = @parcel.receiver
    @url  = 'http://localhost:3000/search'
    mail(to: @sender.email, cc: @receiver.email,  subject: 'New Parcel Information')
  end
end
