class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.datetime :birthday
      t.integer :gender
      t.string :avatar
      t.string :fb_id
      t.string :fb_at
      t.string :origin
      t.string :provider
      t.integer :status

      t.timestamps
    end
  end
end
