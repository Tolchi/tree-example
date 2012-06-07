class NotificationsMailer < ActionMailer::Base
  default from: "noreply@argentinahanin.com.ar"
  default to:   "sheep@argentinahanin.com.ar"
    
  def new_message(message)
    @message = message
    mail(:subject => "[Argentina Hanin Network] #{message.subject}")
  end
end
