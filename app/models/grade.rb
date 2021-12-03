class Grade < ApplicationRecord
  validates :code, :year, :hour_start, :hour_end, :school_name, presence: true

  has_and_belongs_to_many :users, -> { distinct }
  has_and_belongs_to_many :students, -> { where(role: 1) }, class_name: 'User'
  has_and_belongs_to_many :teachers, -> { where(role: 0) }, class_name: 'User'

  accepts_nested_attributes_for :students
  accepts_nested_attributes_for :teachers

  def weekday_text
    days = %i[sunday monday tuesday wednesday thursday friday saturday]
    days.select { |day| send(day.to_s).eql?(true) }.map do |day|
      self.class.human_attribute_name(day.to_s)
    end
  end
end
