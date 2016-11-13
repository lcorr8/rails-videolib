class AddFlatironToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :flatiron, :boolean, default: true
  end
end
