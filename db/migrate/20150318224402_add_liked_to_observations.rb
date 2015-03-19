class AddLikedToObservations < ActiveRecord::Migration
  def change
    add_column :observations, :liked, :boolean
  end
end
