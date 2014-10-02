class AddLastLoginAttempttoUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_login_attempt, :datetime
  end
end
