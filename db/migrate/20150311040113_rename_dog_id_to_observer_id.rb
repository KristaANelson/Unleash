class RenameDogIdToObserverId < ActiveRecord::Migration
  def change
    rename_column :observations, :dog_id, :observer_id
  end
end
