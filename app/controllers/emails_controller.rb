class EmailsController < ApplicationController
  def create
    if params[:email]
      SubscriptionMailer.new_subscription(params[:email]).deliver_later
      flash[:message] = "You have successfully signed up for our weekly subscription!"
    end
    redirect_to root_path
  end
end
