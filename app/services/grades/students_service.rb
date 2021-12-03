module Grades
  class StudentsService
    def self.list(params)
      target_grade = Grade.where(id: params[:grade_id]).last
      resources = User.where(role: 1).where('email LIKE ?', "%#{params[:term]}%").limit(5)
      resources.map do |student|
        { id: student.id,
          label: "#{student.name} - #{student.email}",
          value: student.name,
          avaliable: avaliable?(student, target_grade) }
      end
    end

    def self.avaliable?(student, target_grade)
      student.grades.none? do |grade|
        match_hours?(grade, target_grade)
      end
    end

    def self.match_hours?(grade, target_grade)
      grade.hour_start >= target_grade.hour_start && grade.hour_start <= target_grade.hour_end ||
        grade.hour_end >= target_grade.hour_start && grade.hour_end <= target_grade.hour_end
    end
  end
end
