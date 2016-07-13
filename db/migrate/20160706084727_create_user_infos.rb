class CreateUserInfos < ActiveRecord::Migration
  def change
    create_table :user_infos do |t|
      t.string :user_id
      t.boolean :new_user
      t.boolean :seen_mems

      t.timestamps null: false
    end
  end
end
