class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.references :user, index: true
      t.references :course, index: true
      t.references :lecture, index: true
      t.references :part, index: true
      t.integer :time
      t.integer :status

      t.timestamps
    end
  end
end
