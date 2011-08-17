class AddUsernameUniquenessIndex < ActiveRecord::Migration
  def self.up
    add_index :administrators, :username, :unique => true
  end

  def self.down
    remove_index :administrators, :username
  end
end
