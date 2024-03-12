class CreatePostTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_tags do |t|
      t.references :post, null: false, foreign_key:true
      t.references :tag, null: false, foreign_key:true

      t.timestamps
    end
    #同じタグは2回保存できない
    add_index :post_tags, [:post_id, :tag_id], unique:true
  end
end
