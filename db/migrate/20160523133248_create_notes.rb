class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :title
      t.integer :priority
      t.text :body
      t.date :date_seen
      t.date :date_show

      t.timestamps null: false
    end
  end
end
