require 'rails_helper'

RSpec.describe Review, type: :model do
  describe Review do
    it { should have_valid(:body).when("This is the best product ever")}
    it { should_not have_valid(:body).when("", nil)}

    it { should have_valid(:rating).when(1, 2, 3, 4, 5)}
    it { should_not have_valid(:rating).when("", nil, 0, 6, 7)}

    let(:user) { FactoryGirl.create(:user) }
    let(:product) { FactoryGirl.create(:product) }

    it { should have_valid(:user_id).when(user.id)}
    it { should_not have_valid(:user_id).when("", nil)}

    it { should have_valid(:product_id).when(product.id)}
    it { should_not have_valid(:product_id).when("", nil)}
  end
end
