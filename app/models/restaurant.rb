class Restaurant < ApplicationRecord
  validates_presence_of :name
  mount_uploader :image, PhotoUploader
  belongs_to :category

  has_many :comments, dependent: :restrict_with_error #comments存在時restaurant無法被刪除
  has_many :users, through: :comments

  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user


  def is_favorited?(user)
    self.favorited_users.include?(user)
  end
  
end