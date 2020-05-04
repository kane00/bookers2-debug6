class Favorite < ApplicationRecord
	#Favoriteモデルに関連付けを追加
	belongs_to :user
    belongs_to :book
end
