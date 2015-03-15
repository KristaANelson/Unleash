class RemoveAddressFromDogs < ActiveRecord::Migration
  def change
    remove_column :dogs, :address, :string
  end
end
