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

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  # introductionのバリデーション設定がない　Max50字設定
  validates :introduction, length: {maximum: 50}
end
