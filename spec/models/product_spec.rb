require "rails_helper"

RSpec.describe Product, type: :model do
  describe Product do
    it { should have_valid(:name).when("Hoola Matte Bronzer", "Long-Wear Gel Eyeliner") }
    it { should_not have_valid(:name).when("", nil) }

    it { should have_valid(:brand).when("Benefit Cosmetics") }
    it { should_not have_valid(:brand).when("", nil) }

    it { should have_valid(:color).when("Matte Finish") }
    it { should have_valid(:description).when("Dust on Benefit's iconic hoola Matte Bronzer..") }
    it { should have_valid(:price).when(29.00, 1, 100.0) }
    it { should have_valid(:product_photo).when("www.google.com/picture.jpg") }
    it { should have_valid(:size).when(0.2, 3.5, 10) }

    let(:category) { FactoryGirl.create(:category) }
    it { should have_valid(:category_id).when(category.id) }
    it { should have_valid(:category_id).when("", nil) }
  end
end
