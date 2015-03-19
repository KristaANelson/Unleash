class CreateSearchPreferences < ActiveRecord::Migration
  def change
    create_table :search_preferences do |t|
      t.references :dog, index: true
      t.string :breeds
      t.string :ages
      t.string :gender
      t.string :sizes
    end
    add_foreign_key :search_preferences, :dog_ids
  end
end
