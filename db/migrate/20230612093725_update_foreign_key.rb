class UpdateForeignKey < ActiveRecord::Migration[7.0]
  def change
    add_reference :weekly_plans, :profile, index: true, foreign_key: true
    remove_reference :weekly_plans, :user, index: true, foreign_key: true
  end
end
