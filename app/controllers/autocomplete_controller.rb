class AutocompleteController < ApplicationController
  def students
    @students = Grades::StudentsService.list(params)
    render json: @students
  end
end
