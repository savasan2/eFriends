class DestoryGenreToUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :Genre_id, :integer
  end
end
