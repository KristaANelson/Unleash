class Observations < ActiveRecord::Migration
  def change
    create_table :observations do |t|
      t.belongs_to :dog
      t.integer :observed_id, index: true
      t.boolean :liked, default: nil

      t.timestamps
    end
  end
end
