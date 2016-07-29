class UpdateExistingUsersWithMemNumber < ActiveRecord::Migration
  def change
    add_column :user_infos, :mem_no, :int, :default => 5
  end
end
