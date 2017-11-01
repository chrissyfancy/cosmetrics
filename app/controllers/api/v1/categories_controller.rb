class Api::V1::CategoriesController < ApplicationController
  def index
    render json: {
      makeup: makeup,
      beauty_supplements: beauty_supplements,
      bath_and_body: bath_and_body,
      hair: hair,
      fragrance: fragrance,
      tools: tools,
      nails: nails
    }
  end

  def makeup
    JSON.parse(Net::HTTP.get(URI.parse("https://api.birchbox.com/products/v2/categories/5/department_tree")))
  end

  def beauty_supplements
    JSON.parse(Net::HTTP.get(URI.parse("https://api.birchbox.com/products/v2/categories/4/department_tree")))
  end

  def bath_and_body
    JSON.parse(Net::HTTP.get(URI.parse("https://api.birchbox.com/products/v2/categories/3/department_tree")))
  end

  def hair
    JSON.parse(Net::HTTP.get(URI.parse("https://api.birchbox.com/products/v2/categories/6/department_tree")))
  end

  def fragrance
    JSON.parse(Net::HTTP.get(URI.parse("https://api.birchbox.com/products/v2/categories/7/department_tree")))
  end

  def tools
    JSON.parse(Net::HTTP.get(URI.parse("https://api.birchbox.com/products/v2/categories/352/department_tree")))
  end

  def nails
    JSON.parse(Net::HTTP.get(URI.parse("https://api.birchbox.com/products/v2/categories/913/department_tree")))
  end
end
