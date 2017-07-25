require 'rails_helper'

RSpec.describe Vote, type: :model do
  describe Vote do
    it { should have_valid(:score).when(1, 0, -1)}
    it { should_not have_valid(:score).when("", nil)}

    let(:user) { FactoryGirl.create(:user) }
    it { should have_valid(:user_id).when(user.id)}
    it { should_not have_valid(:user_id).when("", nil)}

    let(:review) { FactoryGirl.create(:review) }
    it { should have_valid(:review_id).when(review.id)}
    it { should_not have_valid(:review_id).when("", nil)}
  end
end
