class AddFirstnameAndLastnameToAdministrators < ActiveRecord::Migration
  def self.up
    add_column :administrators, :firstname, :string
    add_column :administrators, :lastname, :string
  end

  def self.down
    remove_column :administrators, :lastname
    remove_column :administrators, :firstname
  end
end
