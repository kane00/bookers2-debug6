class SearchesController < ApplicationController
	# ログイン済ユーザーのみにアクセスを許可
	before_action :authenticate_user!

	def search
	    @model = params["search"]["model"]
	    # "search"という名で作成したハッシュの中の"model"(カラム)にあるデータを取得している
	    @content = params["search"]["content"]
	    @method = params["search"]["method"]
	    @records = search_for(@model, @content, @method)
	    # 下記の"search_for"メソッドで検索結果に合致するレコードを取得している
	end

	private
	  def search_for(model, content, method)
	  	# userを選択した際
	    if model == 'user'
	      if method == 'perfect'
	        User.where(name: content)
	      elsif method == 'forward'
	        User.where('name LIKE ?', content+'%')
	      elsif method == 'backward'
	        User.where('name LIKE ?', '%'+content)
	      else
	        User.where('name LIKE ?', '%'+content+'%')
	      end
	    # bookを選択した際
	    elsif model == 'book'
	      if method == 'perfect'
	        Book.where(title: content)
	      elsif method == 'forward'
	        Book.where('title LIKE ?', content+'%')
	      elsif method == 'backward'
	        Book.where('title LIKE ?', '%'+content)
	      else
	        Book.where('title LIKE ?', '%'+content+'%')
	      end
	    end
	  end

end
