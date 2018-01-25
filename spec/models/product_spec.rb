require 'rails_helper'

RSpec.describe Product, type: :model do
  it "is valid with the correct attributes" do
    product = build(:product)
    expect(product).to be_valid
  end

  it "is not valid without a user" do
    product = build(:product, user_id: nil)
    expect(product).to_not be_valid
  end

  it "is not valid without a category" do
    product = build(:product, category_id: nil)
    expect(product).to_not be_valid
  end

  it "is not valid without a description" do
    product = build(:product, description: nil)
    expect(product).to_not be_valid
  end

  it "is not valid without a price" do
    product = build(:product, price: nil)
    expect(product).to_not be_valid
  end

  it "is not valid without an image" do
    product = build(:product, image: nil)
    expect(product).to_not be_valid
  end

  it "is not valid with a non-digit price" do
    product = build(:product, price: "Dosepesos")
    expect(product).to_not be_valid
  end
end
