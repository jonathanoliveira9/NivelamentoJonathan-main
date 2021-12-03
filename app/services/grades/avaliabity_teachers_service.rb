module Grades
  class AvaliabityTeachersService
    attr_reader :target_grade

    def initialize(grade:)
      @target_grade = grade
    end

    def self.call(grade)
      new(grade).filter
    end

    def filter
      filter_teachers = teachers.select do |teacher|
        teacher.grades.none? do |grade|
          match_hours?(grade)
        end
      end
      filter_teachers << target_grade.teachers.to_a if target_grade.teachers.any?
      filter_teachers.flatten!
      filter_teachers
    end

    private

    def teachers
      @teachers = User.where(role: 0).includes(:users_grades, :grades)
    end

    def match_hours?(grade)
      grade.hour_start >= target_grade.hour_start && grade.hour_start <= target_grade.hour_end ||
        grade.hour_end >= target_grade.hour_start && grade.hour_end <= target_grade.hour_end
    end
  end
end
