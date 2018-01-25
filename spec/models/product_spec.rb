require 'rails_helper'

RSpec.describe Product, type: :model do
  context "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:image) }
    it { should validate_presence_of(:category_id) }
  end
  context "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:category) }
  end
end
