class UpdateObservationsTable < ActiveRecord::Migration
  def change
    remove_column :observations, :observer_id
    add_reference :observations, :dog, index: true

  end
end
