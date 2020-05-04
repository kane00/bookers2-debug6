class FavoritesController < ApplicationController

	#index,newアクションは作成必要ない
	def create
		book = Book.find(params[:book_id])
		favorite = current_user.favorites.new(book_id: book.id)
		favorite.save
		redirect_to book_path(book)
	end
	def destroy
		book = Book.find(params[:book_id])
		favorite = current_user.favorites.find_by(book_id: book.id)
		favorite.destroy
		# redirect_to book_path(book)
		# 削除した後は、行う前にいた画面に遷移する?おためし
		redirect_back(fallback_location: root_path)
	end

end
