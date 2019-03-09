class AddDetailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :coins, :int
    add_column :users, :points, :int
  end
end
