class AddDistanceToObservationsTable < ActiveRecord::Migration
  def change
    add_column :observations, :distance, :string
  end
end
