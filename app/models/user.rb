class User < ApplicationRecord
  enum role: { teacher: 0, student: 1 }.freeze
  has_and_belongs_to_many :grades
end
