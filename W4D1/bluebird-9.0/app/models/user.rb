# == Schema Information
#
# Table name: users
#
#  id                    :bigint(8)        not null, primary key
#  username              :string           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  email                 :string           not null
#  age                   :integer          not null
#  political_affiliation :string
#

class User < ApplicationRecord
  validates :username, :email, presence: true, uniqueness: true
  
  has_many :chirps,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :Chirp

  has_many :likes,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Like
  
  has_many :liked_chirps,
    through: :likes,
    source: :chirp

  has_many :comments,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :Comment

end
