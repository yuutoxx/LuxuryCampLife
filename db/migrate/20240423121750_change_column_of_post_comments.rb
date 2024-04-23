class ChangeColumnOfPostComments < ActiveRecord::Migration[6.1]
  def change
    change_column :post_comments, :customer_id, :integer, null: false
    change_column :post_comments, :post_id, :integer, null: false
    change_column :post_comments, :comment, :text, null: false
  end
end
