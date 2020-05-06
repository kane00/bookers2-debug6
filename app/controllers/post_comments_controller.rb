class PostCommentsController < ApplicationController

	def create
		book = Book.find(params[:book_id])
    	comment = current_user.post_comments.new(post_comment_params)
    	# コメントしている本のIDが、本のIDと一緒だったら
    	comment.book_id = book.id
    	# コメントを保存して
    	comment.save
    	# 同じページに戻る
    	redirect_back(fallback_location: root_path)
	end

	def destroy
		book = Book.find(params[:book_id])
		comment = current_user.post_commnets.find_by(book_id: book.id)
		comment.book_id = book.id
		comment.destroy
		# リダイレクト先を同じページにする(更新のような形)
		redirect_back(fallback_location: root_path)
	end

	private
	def post_comment_params
    	params.require(:post_comment).permit(:comment)
	end


end
