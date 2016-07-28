class UpdateExistingUsersWithTask < ActiveRecord::Migration
  def change
    UserInfo.update_all :user_tags => %w(watch buy read learn info reminder task)
  end
end
