class RemoveSectionIdsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :section_ids, :string
  end
end
