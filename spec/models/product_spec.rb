require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:user) { create(:user, avatar: i) }
  let(:cat) { create(:category) }
  let(:i) {
    Rack::Test::UploadedFile.new(
      Rails.root.join('spec', 'image', '1.png')
    )
  }

  describe Product do
    context "associations" do
      it "should belongs to category" do
        relationship = Product.reflect_on_association(:category)
        expect(relationship.macro).to eq(:belongs_to)
      end
      it "should belongs to user" do
        relationship = Product.reflect_on_association(:user)
        expect(relationship.macro).to eq(:belongs_to)
      end
    end
  end

  it "is not valid with nil parameters" do
    products = Product.new(name: nil, description: nil, image: nil)
    expect(products).to_not be_valid
  end

  it "is not valid when price not integer" do
    product = Product.new(price: "string", category_id: nil)
    expect(product).to_not be_valid
  end

  it "is valid with complete parameters" do
    product =  build(:product, user_id: user.id, category_id: cat.id, image: i)
    expect(product).to be_valid
  end
end
