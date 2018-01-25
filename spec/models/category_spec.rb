require 'rails_helper'

RSpec.describe Category, type: :model do
  it "is valid with the correct attributes" do
    category = build(:category)
    expect(category).to be_valid
  end
  it "is not valid without a name" do
    category = build(:invalid_category)
    expect(category).to_not be_valid
  end

  it "should have many products" do
    products = Category.reflect_on_association(:products)
    expect(products.macro).to eq(:has_many)
  end
end
