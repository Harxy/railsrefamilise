class ChangeUserIdTointeger < ActiveRecord::Migration
  def change
    remove_column :user_infos, :user_id
    remove_column :notes, :user
    add_column :user_infos, :user_id, :integer
    add_column :notes, :user, :integer
  end
end
