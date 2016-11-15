class AddDescriptionsToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :description, :string
  end
end
