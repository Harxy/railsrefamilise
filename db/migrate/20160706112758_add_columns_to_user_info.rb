class AddColumnsToUserInfo < ActiveRecord::Migration
  def change
    add_column :user_infos, :seen_mem_time, :date
  end
end
