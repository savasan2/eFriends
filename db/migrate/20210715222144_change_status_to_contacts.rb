class ChangeStatusToContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :title, :string
    remove_column :contacts, :phone_number, :string
    remove_column :contacts, :subject, :string
  end
end
