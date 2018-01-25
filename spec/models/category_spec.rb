require 'rails_helper'

RSpec.describe Category, type: :model do
  describe Category do
    it "should have many products" do
      relationship = Category.reflect_on_association(:products)
      expect(relationship.macro).to eq(:has_many)
    end
    context "when creating category" do
      it "should not be blank" do
        category = Category.new(name: nil)
        expect(category).to_not be_valid
      end
    end
  end
  describe "when category already exists" do
    it "should not be existing" do
      category = Category.new(name: "Bag")
      another_category = Category.new(name: "Shirt")
      expect(category).not_to eq(another_category)
    end
  end
end
