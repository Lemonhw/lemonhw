class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :surname, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :gender, :string
    add_column :users, :address, :string
    add_column :users, :phone_number, :string
  end
end
