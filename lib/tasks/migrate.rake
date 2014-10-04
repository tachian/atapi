namespace :migrate do

  desc "Capture image from lectures"
  task :get_youtube_image => :environment do
    
    require 'open-uri'

    lectures = Lecture.all
    lectures.each do |l|
      if !File.exist?('images/'+l.id.to_s+'.jpg')
        open('images/'+l.id.to_s+'.jpg', 'wb') do |file|
          if !l.parts.first.url.blank?
            file << open("http://i.ytimg.com/vi/"+l.parts.first.url+"/1.jpg").read
            puts l.name + " - " + l.order.to_s
          end
        end
      end
    end
    puts "Fim..."
  end


  desc "Migrate data"
  task :migrate_core => :environment do

    require 'legacy/universities.rb'
    require 'legacy/courses.rb'
    require 'legacy/lectures.rb'
    require 'legacy/parts.rb'
    require 'legacy/subjects.rb'
    require 'legacy/course_subjects.rb'

    start = Time.new

    puts start

    University.delete_all
    Course.delete_all
    Lecture.delete_all
    Part.delete_all
    Subject.delete_all

    puts "[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[   MIGRATION START   ]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]\n\n\n"
    legacy_subject = Legacy::Subject.where("id < 22")
        # legacy_course_subject.each do |lcs|
    legacy_subject.each do |ls|
      puts "===============>   Subject: #{ls.name}"
      puts "\n\n"
      subject = Subject.new
      subject.id = ls.id
      subject.name = ls.name
      subject.description = ls.description

      subject.save
    end


    legacy_university = Legacy::University.all
    legacy_university.each do |lu|
      puts "===============>   University: #{lu.name}"
      puts "\n\n"
      university = University.new
      university.name = lu.name
      university.fullname = lu.fullname
      university.description = lu.description
      university.status = 1
      
      university.save

      legacy_course = Legacy::Course.where(university_id: lu.id)

      legacy_course.each do |lc|
        puts "===============>   Course: #{lc.name}"
        puts "\n\n"

        course = Course.new
        course.university_id = university.id
        course.avatar =lc.avatar
        course.name = lc.name
        course.description = lc.description
        course.status = lc.status == '1' ? 1 : 0

        

        legacy_course_subject = Legacy::CourseSubject.where(course_id: lc.id).where("course_list_id < 22")
        # legacy_course_subject.each do |lcs|
        # 	subject = CourseSubject.new
        # 	course_subject.course_id = course.id
        # 	course_subject.subject_id = lcs.course_list_id

        # 	course_subject.save
        # end 

        legacy_course_subject.each do |lcs|
          course.subjects << Subject.find(lcs.course_list_id)
        end

        course.save

        legacy_lecture = Legacy::Lecture.where(course_id: lc.id)

        legacy_lecture.each do |ll|

          puts "===============>   Lecture: #{ll.name}"

          lecture = Lecture.new
          lecture.course_id = course.id
          lecture.name = ll.name
          lecture.avatar = ll.avatar
          lecture.subtitle = ll.subtitle
          lecture.order = ll.order

          lecture.save

          
          legacy_part = Legacy::Part.where(lecture_id: ll.id)

          legacy_part.each do |lp|
            puts "===============>   Part: #{lp.name}"

            part = Part.new
            part.lecture_id = lecture.id
            part.name = lp.name
            part.teacher = lp.teacher
            part.url = lp.url
            part.duration = lp.duration
            part.order = lp.order

            part.save

          end

        end

      end

    end



  end

end