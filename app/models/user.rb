class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #1つのuserに複数のbooksなのでbelong_to→has_manyに変更した
  has_many :books, dependent: :destroy
  #Favoriteモデルのカラム（user_idとbook_id）は、UserモデルのidやBookモデルのidと関連付けが必要
  #本、投稿コメント、いいね機能の関連付け
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :profile_image  #, destroy: false

  # user.following_relationships.followingsをできるようにする=フォローできるユーザーを取り出す記述
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  # user.followingsをできるようにする=フォローしているユーザーを取り出す記述
  has_many :followings, through: :following_relationships
  # フォローされているユーザーを取り出す
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  # user.follwersをできるようにする
  has_many :followers, through: :follower_relationships

  # フォローしているか調べるための関数
  def following?(other_user)
    following_relationships.find_by(following_id: other_user.id)
  end
  # フォローする関数
  def follow!(other_user)
    following_relationships.create!(following_id: other_user.id)
  end
  # フォローを外す関数
  def unfollow!(other_user)
    following_relationships.find_by(following_id: other_user.id).destroy
  end

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  # introductionのバリデーション設定がない　Max50字設定
  validates :introduction, length: {maximum: 50}
end
