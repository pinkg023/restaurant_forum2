class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :image, PhotoUploader

  # 「使用者評論很多餐廳」的多對多關聯
  has_many :comments, dependent: :restrict_with_error #comments存在時user無法被刪除
  has_many :restaurants, through: :comments

  # 「使用者收藏很多餐廳」的多對多關聯
  has_many :favorites, dependent: :destroy            #favorite存在時，刪除user會將favorite一併刪除
  has_many :favorited_restaurants, through: :favorites, source: :restaurant   #查出來的結果是要對應restaurant那張table的主鍵

  #上述兩組User<->Restaurant透過兩張表格關聯，故需要兩個方法名稱
  #透過comments關聯的方法為User.restaurant
  #而透過favorites關聯的方法為User.favorited_restaurants

  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships
  #定義與followship相反方向的方法
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user

  def admin?
    self.role == "admin"
  end

  def following?(user)
    self.followings.include?(user)
  end
  
  
end
