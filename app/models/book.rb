class Book < ApplicationRecord

	#複数のbooksに1つのuserなのでhas_many→belong_toに変更した
	# belong_to→belongs_toへ
	belongs_to :user
	#引数で渡されたユーザidがFavoritesテーブル内に存在（exists?）するかどうか調べる
	#存在していればtrue、存在していなければfalseを返す
	has_many :favorites, dependent: :destroy
        def favorited_by?(user)
            favorites.where(user_id: user.id).exists?
        end
    # 1つのbookに複数のコメントの関連付け
    has_many :post_comments, dependent: :destroy
    has_many :book_comments, dependent: :destroy


	#バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	#presence trueは空欄の場合を意味する。
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end
