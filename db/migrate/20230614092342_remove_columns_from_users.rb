class RemoveColumnsFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :name, :string
    remove_column :users, :age, :integer
    remove_column :users, :height, :integer
    remove_column :users, :dietary_requirements, :string
  end
end
