class AddSaltToAdministrators < ActiveRecord::Migration
  def self.up
    add_column :administrators, :salt, :string
  end

  def self.down
    remove_column :administrators, :salt
  end
end
