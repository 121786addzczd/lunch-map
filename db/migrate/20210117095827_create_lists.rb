class CreateLists < ActiveRecord::Migration[6.0]
  def change
    create_table :lists do |t|
      t.string :title, null: false
      # references型はカラム名+"_id"がテーブル名として設定されるので、今回listsテーブルにはuser_idというカラムが追加される
      t.references :user, foreign_key: true, null: false
      # foreign_key: trueは外部キーとして使用するということを示す
      t.timestamps
    end
  end
end
