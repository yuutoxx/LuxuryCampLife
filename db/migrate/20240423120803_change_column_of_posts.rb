class ChangeColumnOfPosts < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :customer_id, :integer, null: false
    change_column :posts, :title, :string, null: false
    change_column :posts, :body, :text, null: false
    change_column :posts, :price, :integer, null: false
    change_column :posts, :star, :integer, null: false
  end
end
