class ChangeDatesColumn < ActiveRecord::Migration
  def change
    remove_column :user_infos, :dates_dismissed
    add_column :user_infos, :dates_dismissed, :date
  end
end
