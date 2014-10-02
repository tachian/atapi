class CreateCoursesSubjects < ActiveRecord::Migration
  def change
    create_table :courses_subjects, id: false do |t|
      t.references :course, index: true
      t.references :subject, index: true      
    end

		add_index :courses_subjects, [:course_id, :subject_id]

  end
end
