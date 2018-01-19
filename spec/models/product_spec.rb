require 'rails_helper'

RSpec.describe Product, type: :model do
  describe Product do
    it "should belongs to user" do
      relationship = Product.reflect_on_association(:user)
      expect(relationship.macro).to eq(:belongs_to)
    end
  end

  describe Product do
    it "should belongs to category" do
      relationship = Product.reflect_on_association(:category)
      expect(relationship.macro).to eq(:belongs_to)
    end
  end

  it "is not valid with nil parameters" do
    product = Product.new(name: nil, description: nil, image: nil)
    expect(product).to_not be_valid
  end

  it "is not valid when mobile not integer" do
    product = Product.new(price: "string", category_id: nil)
    expect(product).to_not be_valid
  end
end
