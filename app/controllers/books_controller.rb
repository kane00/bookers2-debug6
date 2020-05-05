class BooksController < ApplicationController
  # 下記アクションはログインユーザーによってのみ実行可能にする、[]で個別にも可能
  before_action :authenticate_user!

  def show
    @book = Book.find(params[:id])
    # 上の本に紐づいているユーザーを表示
    @user = @book.user
    @newbook = Book.new
  end

  def index
  	@books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
    @book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def create
  	@book = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
    # user_idが正しいか確認
    @book.user_id = current_user.id

    if @book.save #入力されたデータをdbに保存する。
  		redirect_to books_path, notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
  		@books = Book.all
  		render 'index'
  	end
  end

  def edit
  	@book = Book.find(params[:id])
    # 非ログインユーザーに対してのアクセス制限
    if user_signed_in?
      # ログインユーザと一致していなければ(!=)book一覧にリダイレクト
      if @book.user_id != current_user.id
          redirect_to books_path
          # 一致していたらそのままeditへ
      end
    else
      # ログインしていなかったら
      redirect_to ("/users/sign_in")
    end
  end



  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render "edit"
  	end
  end

  # def delete→destroy
  def destroy
  	@book = Book.find(params[:id])
    # destoy→destroy
  	@book.destroy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  # 非ログインユーザーに対してのアクセス制限
  def ensure_correct_user
      @book = Book.find(params[:id])
      if user_signed_in?
        if @book.user_id != current_user.id
          redirect_to books_path
        end
      else
        redirect_to ("/users/sign_in")
      end
  end



  private
    def book_params
  	 params.require(:book).permit(:title, :body)
    end

end
