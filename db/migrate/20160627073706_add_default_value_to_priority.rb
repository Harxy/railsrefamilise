class AddDefaultValueToPriority < ActiveRecord::Migration
  def up
    change_column :notes, :priority, :integer, :default => 0
  end

  def down
    change_column :notes, :priority, :integer, :default => nil
  end
end
