class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.references :university, index: true
      t.string :avatar
      t.string :name
      t.text :description
      t.integer :status

      t.timestamps
    end
  end
end
