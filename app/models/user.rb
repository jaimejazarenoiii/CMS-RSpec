# == Schema Information
#
# Table name: users
#
#  avatar                 :string
#  birthdate              :datetime         not null
#  created_at             :datetime         not null
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  fname                  :string           not null
#  id                     :integer          not null, primary key
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  lname                  :string           default(""), not null
#  mobile                 :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("normal"), not null
#  sign_in_count          :integer          default(0), not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :avatar, ImageUploader

  has_many :products, dependent: :destroy

  validates :email, uniqueness: true
  validates :fname, presence: true
  validates :lname, presence: true
  validates :birthdate, presence: true
  validates :mobile, numericality: { only_integer: true }
  validates :avatar, presence: true

  enum role: { normal: 0, admin: 1 }
end
