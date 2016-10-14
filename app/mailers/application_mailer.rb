class ApplicationMailer < ActionMailer::Base
  default from: "\"Sephora\" <no-reply@sephora.com>"
  layout 'mailer'
end
