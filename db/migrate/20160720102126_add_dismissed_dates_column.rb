class AddDismissedDatesColumn < ActiveRecord::Migration
  def change
    add_column :user_infos, :dates_dismissed, :boolean, default: false
  end
end
