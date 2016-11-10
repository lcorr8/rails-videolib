class RemoveUserIdFromSections < ActiveRecord::Migration
  def change
    remove_column :sections, :user_id, :string
  end
end
