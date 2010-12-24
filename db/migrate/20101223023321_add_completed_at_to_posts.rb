class AddCompletedAtToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :completed_at, :datetime
  end

  def self.down
    remove_column :posts, :completed_at, :datetime
  end
end
