require "rails_helper"

RSpec.describe Category, type: :model do
  describe Category do
    it { should have_valid(:name).when("Skin Care", "Eyes") }
    it { should_not have_valid(:name).when("", nil) }

    it { should have_valid(:description).when("For all products relating to..") }
  end
end
