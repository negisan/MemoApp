class MemosController < ApplicationController
  before_action :set_memo, only: [:show, :edit, :update, :destroy]

  def index
    @memos = Memo.all
  end

  def show
  end

  def new
    @memo = Memo.new
  end

  def create
    @memo = Memo.new(memo_params)
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
      @memo = Memo.find(params[:id])
    end

    def memo_params
      params.require(:memo).permit(:title, :content, :image)
    end
end
