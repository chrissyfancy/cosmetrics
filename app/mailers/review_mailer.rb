class ReviewMailer < ApplicationMailer
  def new_review(review)
    @review = review

    mail(
      to: review.user.email,
      subject: "Your review on #{review.product.name}."
    )
  end
end
