class CreateDogs < ActiveRecord::Migration
  def change
    create_table :dogs do |t|
      t.string :name
      t.integer :age
      t.integer :weight
      t.string :breed
      t.string :city
      t.string :state
      t.string :street
      t.string :zipcode
      t.references :user, index: true
      t.attachment :img

      t.timestamps null: false
    end
    add_foreign_key :dogs, :users
  end
end
