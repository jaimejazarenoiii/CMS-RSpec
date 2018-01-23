require 'rails_helper'

RSpec.describe Category, type: :model do
  describe Category do
    it "should have many products" do
      relationship = Category.reflect_on_association(:products)
      expect(relationship.macro).to eq(:has_many)
    end
  end

  describe "when category name is already taken" do
    before do
      @category = create(:category)
      cat = @category.dup
      cat.save
    end
    it { should_not be_valid }
  end

  it "is not valid without category" do
    category = Category.new(name: nil)
    expect(category).to_not be_valid
  end

  it "is valid with category" do
    category = create(:category)
    expect(category).to be_valid
  end
end
