class UpdateDogTable < ActiveRecord::Migration
  def change
    change_column :dogs, :weight, :string
    change_column :dogs, :age, :string
    add_column :dogs, :address, :string
  end
end
