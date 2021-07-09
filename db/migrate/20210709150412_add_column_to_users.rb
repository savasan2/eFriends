class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :image_id, :string
    add_column :users, :Genre_id, :integer
    add_column :users, :introduction, :text
  end
end
