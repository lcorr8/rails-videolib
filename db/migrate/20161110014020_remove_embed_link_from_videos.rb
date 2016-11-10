class RemoveEmbedLinkFromVideos < ActiveRecord::Migration
  def up
    remove_column :videos, :embed_link, :string
  end
  def down
    add_column :videos, :embed_link, :string
  end
end
