require 'rails_helper'

RSpec.describe User, type: :model do
  let(:image) {
    Rack::Test::UploadedFile.new(
      Rails.root.join('spec', 'image', '1.png')
    )
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
        users = User.new(fname: nil, lname: nil, email: nil)
        expect(users).to_not be_valid
      end

      it "is not valid with nil and string mobile" do
        user = User.new(birthdate: nil, avatar: nil, mobile: "string")
        expect(user).to_not be_valid
      end

      it "is valid complete parameters" do
        user = build(:user, avatar: image)
        expect(user).to be_valid
      end
    end
  end
end
