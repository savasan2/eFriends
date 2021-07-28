class ChangeColumnUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :genre_id,:integer, default: 1
    change_column :contacts, :message, :text, null: false
    change_column :contacts, :title, :string, null: false
    change_column :genres, :name, :string, null: false
  end
end
