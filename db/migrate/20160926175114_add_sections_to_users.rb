class AddSectionsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :section_ids, :string
  end
end
