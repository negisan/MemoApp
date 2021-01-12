class AddUserIdToMemed < ActiveRecord::Migration[6.0]
  def up
    #null制約でエラー回避のためのSQL、本番環境ではデータ削除はだめ
    execute 'DELETE FROM memos;'
    add_reference :memos, :user, null: false, index: true
  end

  def down
    remove_reference :memos, :user, index: true
  end
end
