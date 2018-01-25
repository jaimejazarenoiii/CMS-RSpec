require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:category) {
    Category.create!(
      name: "asdasdas"
    )
  }

  let(:user) {
    User.create!(
      fname: "foo",
      lname: "bar",
      mobile: 123_456_789,
      email: "sample@gmail.com",
      birthdate: "1988-12-02",
      password: "foobar",
      avatar:
      Rack::Test::UploadedFile.new(
        Rails.root.join('spec', 'images', '2.png')
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
        Rails.root.join('spec', 'images', '2.png')
      )
    }
  }

  describe Product do
    it "should belong to user" do
      relationship = Product.reflect_on_association(:user)
      expect(relationship.macro).to eq(:belongs_to)
    end
    it "should belong to a category" do
      relationship = Product.reflect_on_association(:category)
      expect(relationship.macro).to eq(:belongs_to)
    end
  end
  context "Create product" do
    it "is not valid with nil parameters" do
      product = Product.new(name: nil, description: nil, image: nil)
      expect(product).to_not be_valid
    end
    it "is valid with complete parameters" do
      product = Product.new(valid_attributes)
      expect(product).to be_valid
    end
    context "Price" do
      it "should be numerical" do
        price = Product.new(price: "Lorem ipsum")
        expect(price).to_not be_valid
      end
    end
  end
end
