class UpdateExistingUsersWithTaskDefault < ActiveRecord::Migration
  def up
      change_column :user_infos, :user_tags, :string, :default => %w(watch buy read learn info reminder task)
  end

  def down
      change_column :user_infos, :user_tags, :string, :default => %w(watch buy read learn info reminder)
  end
end
