class AddRequestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :request, :string
  end
end
