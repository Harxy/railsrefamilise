class ChangeDateFormatInMyTable < ActiveRecord::Migration
  def up
    change_column :user_infos, :seen_mem_time, :datetime
  end
  def down
    change_column :user_infos, :seen_mem_time, :date
  end
end
