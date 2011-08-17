class ChangeIsSuperadminDefault < ActiveRecord::Migration
  def self.up
    change_column :administrators, :is_superadmin, :boolean, :default => 0
  end

  def self.down
    change_column :administrators, :is_superadmin, :boolean, :default => 1
  end
end
