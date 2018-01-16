# == Schema Information
#
# Table name: products
#
#  category_id :integer
#  created_at  :datetime         not null
#  description :string           not null
#  id          :integer          not null, primary key
#  image       :string
#  name        :string           not null
#  price       :float            not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
# Indexes
#
#  index_products_on_category_id  (category_id)
#  index_products_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#

class Product < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  belongs_to :category

  validates :name, presence: true
  validates :description, presence: true
  validates :price, numericality: true
  validates :image, presence: true
  validates :category_id, presence: true
end
