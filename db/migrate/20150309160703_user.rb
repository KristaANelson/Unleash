class User < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :oauth_token
      t.string :image_url
      
      t.timestamps null: false
    end
  end
end
