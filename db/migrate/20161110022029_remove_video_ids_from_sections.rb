class RemoveVideoIdsFromSections < ActiveRecord::Migration
  def change
    remove_column :sections, :video_ids, :string
  end
end
