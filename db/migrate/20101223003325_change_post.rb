class ChangePost < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.change :body, :string
    end
  end

  def self.down
    change_table :posts do |t|
      t.change :body, :text
    end
  end
end
