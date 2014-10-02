class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.references :lecture, index: true
      t.string :name
      t.string :teacher
      t.string :url
      t.integer :duration
      t.integer :order

      t.timestamps
    end
  end
end
