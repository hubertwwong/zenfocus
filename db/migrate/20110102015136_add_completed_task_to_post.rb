class AddCompletedTaskToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :completed_task, :integer
  end

  def self.down
    remove_column :posts, :completed_task, :integer
  end
end
