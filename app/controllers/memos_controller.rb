class MemosController < ApplicationController
  before_action :set_memo, only: [:show, :edit, :update, :destroy]

  def index
    @memos = current_user.memos.page(params[:page]).per(20)
  end

  def show
  end

  def new
    @memo = Memo.new
  end

  def create
    @memo = current_user.memos.new(memo_params)
    if @memo.save
      redirect_to memo_path(@memo), notice: "#{@memo.title}を作成しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @memo.update(memo_params)
      redirect_to memo_path(@memo), notice: "#{@memo.title}を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @memo.destroy!
    redirect_to memos_url, alert: "#{@memo.title}を削除しました"
  end

  private
    def set_memo
      @memo = current_user.memos.find(params[:id])
    end

    def memo_params
      params.require(:memo).permit(:title, :content, :image)
    end
end
