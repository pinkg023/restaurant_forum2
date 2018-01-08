class AddUserIntroPhoto < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :intro, :string
    add_column :users, :image, :string
  end
end
