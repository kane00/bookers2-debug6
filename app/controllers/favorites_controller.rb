class FavoritesController < ApplicationController

	#index,newアクションは作成必要ない
	def create
		@book = Book.find(params[:book_id])
		# book_id: @book.idの＠抜けていた
		favorite = current_user.favorites.new(book_id: @book.id)
		favorite.save
		# リダイレクト先を同じページにする(更新のような形)
		# redirect_back(fallback_location: root_path)
		# Ajax通信にする際にリダイレクトを消す
	end
	def destroy
		@book = Book.find(params[:book_id])
		favorite = current_user.favorites.find_by(book_id: @book.id)
		favorite.destroy
		# リダイレクト先を同じページにする(更新のような形)
		# redirect_back(fallback_location: root_path)
		# Ajax（非同期通信）にする際にリダイレクトを消す.
	end

end
