# == Schema Information
#
# Table name: categories
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  name       :string           default(""), not null
#  updated_at :datetime         not null
#

class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
