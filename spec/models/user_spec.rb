require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  context "Associations" do
    it { should have_many(:products).dependent(:destroy) }
  end

  context "Validations" do
    it { should validate_presence_of(:fname) }
    it { should validate_presence_of(:lname) }
    it { should validate_presence_of(:birthdate) }
    it { should validate_presence_of(:avatar) }
    it { should validate_numericality_of(:mobile) }

    it { should define_enum_for(:role) }

    it "is invalid with a duplicate email address" do
      user_dup = User.new(email: "foobar@example.com")
      user.email = user_dup
      expect(user).to_not be_valid
    end
  end
end
