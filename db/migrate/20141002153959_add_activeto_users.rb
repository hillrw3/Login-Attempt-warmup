class AddActivetoUsers < ActiveRecord::Migration
  def change
    add_column :users, :active, :boolean, default: true
  end
end
