class ChangeColumnOfFavorites < ActiveRecord::Migration[6.1]
  def change
    change_column :favorites, :customer_id, :integer, null: false
    change_column :favorites, :post_id, :integer, null: false
  end
end
