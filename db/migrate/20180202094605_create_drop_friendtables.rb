class CreateDropFriendtables < ActiveRecord::Migration[5.1]
  def change
    drop_table :friendships
  end
end
