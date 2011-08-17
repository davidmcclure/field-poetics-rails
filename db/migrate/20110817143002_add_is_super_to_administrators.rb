class AddIsSuperToAdministrators < ActiveRecord::Migration
  def self.up
    add_column :administrators, :is_superadmin, :boolean
  end

  def self.down
    remove_column :administrators, :is_superadmin
  end
end
