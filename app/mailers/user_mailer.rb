# frozen_string_literal: true

class UserMailer < ApplicationMailer
  before_action { @user = params[:user] }

  default from: 'support@piazza.przbadu.com'

  default to: -> { %("#{@user.name}" <#{@user.email}>) }

  layout 'mailer'

  def password_reset(id)
    @password_reset_id = id

    mail(subject: t('.subject'))
  end
end
