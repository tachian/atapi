class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.references :course, index: true
      t.string :name
      t.string :subtitle
      t.string :avatar
      t.integer :order

      t.timestamps
    end
  end
end
