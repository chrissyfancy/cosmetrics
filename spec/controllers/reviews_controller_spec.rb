require 'rails_helper'

RSpec.describe ReviewsController, type: :controller, pending: true do
  describe "GET#index" do
    before(:each) do
      create(:user)
      create(:product)
      create(:review)
    end

    it "returns a list of all reviews" do
      get :index
    end
  end

  describe "POST#create" do
    let!(:review_params) do {
      review: {
        body: "This is the worst EVER",
        rating: 1,
        user_id: user.id,
        product_id: product.id }
      }
    end

    it "adds a new Review to the database" do
      expect{ post(:create, params: review_params) }.to_change { Review.count }.by 1
    end

    it "redirects to the Product show page" do
      expect(response).to redirect_to product_path(product.id)
    end

    it "returns a successful response" do
      expect(response.status).to eq(200)
    end
  end
end
