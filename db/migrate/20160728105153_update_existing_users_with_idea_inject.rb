class UpdateExistingUsersWithIdeaInject < ActiveRecord::Migration
  def change
    UserInfo.update_all :user_tags => %w(idea watch buy read learn info reminder task)
  end
end
