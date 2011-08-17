class AddPasswordToAdministrators < ActiveRecord::Migration
  def self.up
    add_column :administrators, :encrypted_password, :string
  end

  def self.down
    remove_column :administrators, :encrypted_password
  end
end
