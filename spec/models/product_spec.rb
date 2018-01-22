require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:category) {
    Category.create!(
      name: "asdasdas"
    )
  }

  let(:user) {
    User.create(
      fname: "bago",
      lname: "luma",
      mobile: 123_456_789,
      email: "sample@yahoo.com",
      birthdate: "2018-01-07",
      role: "admin",
      password: "foobar",
      avatar:
      Rack::Test::UploadedFile.new(
        Rails.root.join('spec', 'support', '1.png')
      )
    )
  }

  let(:valid_attributes) {
    {
      user_id: user.id,
      name: "Cap",
      description: "Black",
      price: 90.75,
      category_id: category.id,
      image: Rack::Test::UploadedFile.new(
        Rails.root.join('spec', 'support', '1.png')
      )
    }
  }

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

  it "is not valid when price not integer" do
    product = Product.new(price: "string", category_id: nil)
    expect(product).to_not be_valid
  end

  it "is valid with complete parameters" do
    product = Product.new(valid_attributes)
    expect(product).to be_valid
  end
end
