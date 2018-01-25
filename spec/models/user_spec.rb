require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_attributes) {
    {
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
    }
  }
  describe "email_address" do
    context "when creating users email" do
      it "should be valid email for user" do
        user_email = User.new(email: "sample@gmail.com")
        expect(user_email).not_to be_nil
      end
      it "should not create existing email " do
        user_email = User.new(email: "sample@gmail.com")
        another_email = User.new(email: "samplee@gmail.com")
        expect(user_email).not_to eq(another_email)
      end
    end
  end
  describe User do
    it "should have many products" do
      relationship = User.reflect_on_association(:products)
      expect(relationship.macro).to eq(:has_many)
    end
    context "Contact number" do
      it "should be numerical" do
        number = User.new(mobile: "Lorem ipsum")
        expect(number).to_not be_valid
      end
    end
    context "Create user" do
      it "is not valid with nil parameters" do
        user = User.new(fname: nil, lname: nil, email: nil, mobile: nil,
                        birthdate: nil, password: nil)
        expect(user).to_not be_valid
      end
      it "is valid with complete parameters" do
        user = User.new(valid_attributes)
        expect(user).to be_valid
      end
    end
  end
end
