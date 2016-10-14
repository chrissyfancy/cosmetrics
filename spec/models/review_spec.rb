require 'rails_helper'

RSpec.describe Review, type: :model do

  it "should be valid" do
    review = FactoryGirl.build(:review)
    expect(review).to be_valid
  end
end
