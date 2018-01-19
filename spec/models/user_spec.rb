require 'rails_helper'

RSpec.describe User, type: :model do
  describe "when email address is already taken" do
    before do
      @user = User.new(email: "charles@example.com")
      user = @user.dup
      user.save
    end
    it { should_not be_valid }
  end

  describe User do
    it "should have many products" do
      relationship = User.reflect_on_association(:products)
      expect(relationship.macro).to eq(:has_many)
    end
  end

  it "is not valid without a parameters" do
    user = User.new(fname: nil, lname: nil, email: nil)
    expect(user).to_not be_valid
  end

  it "is not valid with nil and string mobile" do
    user = User.new(birthdate: nil, avatar: nil, mobile: "string")
    expect(user).to_not be_valid
  end
end
