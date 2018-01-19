class Restaurant < ApplicationRecord
  validates_presence_of :name
  mount_uploader :image, PhotoUploader
  belongs_to :category
  has_many :comments

  has_many :comments, dependent: :restrict_with_error
  has_many :users, through: :comments

  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user


end