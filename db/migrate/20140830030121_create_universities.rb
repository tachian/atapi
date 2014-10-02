class CreateUniversities < ActiveRecord::Migration
  def change
    create_table :universities do |t|
      t.string :name
      t.string :fullname
      t.text :description
      t.integer :status

      t.timestamps
    end
  end
end
