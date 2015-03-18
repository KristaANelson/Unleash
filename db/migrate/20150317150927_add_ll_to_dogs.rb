class AddLlToDogs < ActiveRecord::Migration
  def change
    add_column :dogs, :ll, :string
  end
end
