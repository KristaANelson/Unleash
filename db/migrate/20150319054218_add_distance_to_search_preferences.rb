class AddDistanceToSearchPreferences < ActiveRecord::Migration
  def change
    add_column :search_preferences, :distance, :string
  end
end
