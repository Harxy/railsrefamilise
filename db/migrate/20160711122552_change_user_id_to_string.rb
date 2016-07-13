class ChangeUserIdToString < ActiveRecord::Migration
  def change
    remove_column :user_infos, :user_id
    remove_column :notes, :user
    add_column :user_infos, :user_id, :string
    add_column :notes, :user, :string
  end
end
