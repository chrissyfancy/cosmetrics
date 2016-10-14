require 'rails_helper'

RSpec.describe Product, type: :model do
  it "is valid" do
    sample_product = FactoryGirl.build(:product)
    expect(sample_product).to be_valid
  end

  it do
    should have_valid(:name).when('Hoola Matte Bronzer', 'Long-Wear Gel Eyeliner')
  end

  it do
    should_not have_valid(:name).when(nil, '')
  end
end
