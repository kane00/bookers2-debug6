class UsersController < ApplicationController
  # 下記アクションはログインユーザーによってのみ実行可能にする、[]で個別にも可能
  before_action :authenticate_user!
  # :editを加える　編集画面に遷移する時にログインユーザーと一致しているかの確認
	before_action :baria_user, only: [:edit, :update]

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def index
  	@users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def create
    @book = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
    if @book.save #入力されたデータをdbに保存する。
      redirect_to @book, notice: "successfully created book!"#保存された場合の移動先を指定。
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
      # users_pathをuser_pathに
  		redirect_to user_path(@user), notice: "successfully updated user!"
  	else
      # ミスの際のrender先がindex→edit
  		render "edit"
  	end
  end

  # フォロー人数表示用
  def following
  end
  # フォロワー人数表示用
  def followers
  end

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
   def baria_user
  	unless params[:id].to_i == current_user.id
  		redirect_to user_path(current_user)
  	end
   end

end
