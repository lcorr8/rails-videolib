class RemoveNoteIdsFromVideos < ActiveRecord::Migration
  def up
    remove_column :videos, :note_ids, :string
  end
  def down
    add_column :videos, :note_ids, :string
  end
end
