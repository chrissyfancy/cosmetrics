class SubscriptionMailer < ApplicationMailer
  def new_subscription(email)
    mail(
      to: email,
      subject: "Thank you for your subscription!"
    )
  end
end
