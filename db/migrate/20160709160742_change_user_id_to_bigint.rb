class ChangeUserIdToBigint < ActiveRecord::Migration
  def change
    remove_column :user_infos, :user_id
    remove_column :notes, :user
    add_column :user_infos, :user_id, :bigint
    add_column :notes, :user, :bigint
  end
end
