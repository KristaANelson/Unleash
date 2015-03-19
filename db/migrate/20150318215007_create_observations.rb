class CreateObservations < ActiveRecord::Migration
  def change
    create_table :observations do |t|
      t.integer :observer_id
      t.integer :observed_id
      t.string  :distance

      t.timestamps null: false
    end
    add_index :observations, :observer_id
    add_index :observations, :observed_id
    add_index :observations, [:observer_id, :observed_id], unique: true
  end
end
