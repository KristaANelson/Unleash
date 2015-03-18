class UpdateDogModel < ActiveRecord::Migration
  def change
    remove_column :dogs, :city, :string
    remove_column :dogs, :state, :string
    remove_column :dogs, :street, :string
    remove_column :dogs, :ll, :string
    rename_column :dogs, :weight, :size
  end
end
