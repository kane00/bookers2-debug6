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

  # フォロワー取得,user.follwersをできるようにする
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy 
  # フォロー取得,フォローされているユーザーを取り出す
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy 
  # 自分がフォローしている人
  has_many :following_user, through: :follower, source: :followed 
  # 自分をフォローしている人
  has_many :follower_user, through: :followed, source: :follower 

  # フォローする関数
  def follow(user_id)
    follower.create(followed_id: user_id)
  end
  # フォローを外す関数
  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end
  # フォローしているか調べるための関数
  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  # introductionのバリデーション設定がない　Max50字設定
  validates :introduction, length: {maximum: 50}
end
