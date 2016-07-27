class AddTagcolumntoUserInfo < ActiveRecord::Migration
  def change
    add_column :user_infos, :user_tags, :string
  end
end
