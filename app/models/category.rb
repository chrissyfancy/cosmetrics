class Category < ApplicationRecord
  has_many :products
  validates :name, presence: true

  HOST_MAP = {
    development: "http://localhost:3000",
    production: "https://cosmetrics.herokuapp.com"
  }

  def self.fetched_categories
    JSON.parse(Net::HTTP.get(URI.parse(HOST_MAP[Rails.env.to_sym] + "/api/v1/categories")))
  end
end
