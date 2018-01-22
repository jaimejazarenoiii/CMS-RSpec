require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_attributes) {
    {
      fname: "bago",
      lname: "luma",
      mobile: 123_456_789,
      email: "sample@yahoo.com",
      birthdate: "2018-01-07",
      password: "foobar",
      avatar:
      Rack::Test::UploadedFile.new(
        Rails.root.join('spec', 'support', '1.png')
      )
    }
  }

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

    context "Create" do
      it "is not valid without parameters" do
        user = User.new(fname: nil, lname: nil, email: nil)
        expect(user).to_not be_valid
      end

      it "is not valid with nil and string mobile" do
        user = User.new(birthdate: nil, avatar: nil, mobile: "string")
        expect(user).to_not be_valid
      end

      it "is valid complete parameters" do
        user = User.new(valid_attributes)
        expect(user).to be_valid
      end
    end
  end
end
