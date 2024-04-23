class ChangeColumnOfCustomers < ActiveRecord::Migration[6.1]
  def change
    change_column :customers, :is_active, :boolean, null: false, default: true
  end
end
