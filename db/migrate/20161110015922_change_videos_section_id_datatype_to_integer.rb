class ChangeVideosSectionIdDatatypeToInteger < ActiveRecord::Migration
  def change
    change_column :videos, :section_id, :integer
  end
end
