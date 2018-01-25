require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with the correct attributes" do
    user = build(:user)
    expect(user).to be_valid
  end

  it "is not valid without a first name" do
    user = build(:user, fname: nil)
    expect(user).to_not be_valid
  end

  it "is not valid without a last name" do
    user = build(:user, lname: nil)
    expect(user).to_not be_valid
  end

  it "is not valid without an email" do
    user = build(:user, email: nil)
    expect(user).to_not be_valid
  end

  it "is not valid without a mobile number" do
    user = build(:user, mobile: nil)
    expect(user).to_not be_valid
  end

  it "is not valid without an image" do
    user = build(:user, avatar: nil)
    expect(user).to_not be_valid
  end

  it "is not valid without a birthdate" do
    user = build(:user, birthdate: nil)
    expect(user).to_not be_valid
  end

  it "should have many products" do
    products = User.reflect_on_association(:products)
    expect(products.macro).to eq(:has_many)
  end
end
