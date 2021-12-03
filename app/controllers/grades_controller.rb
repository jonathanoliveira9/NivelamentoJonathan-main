class GradesController < ApplicationController
  before_action :find_grade, only: %i[edit update destroy show
                                      inscription_teachers add_teachers
                                      inscription_students subscribe_student
                                      unsubscribe_student]

  def index
    @q = Grade.ransack(params[:q])
    @pagy, @grades = pagy(@q.result(distinct: true))
  end

  def show
    @teachers = @grade.teachers
    @pagy, @students = pagy(@grade.students)
  end

  def new
    @grade = Grade.new
    respond_to do |format|
      format.html
    end
  end

  def create
    @grade = Grade.new(grade_params)
    if @grade.save
      flash[:success] = t('.success_created')
      redirect_to grades_path
    else
      flash[:error] = @grade.errors.full_messages.join('')
      render :new
    end
  end

  def edit; end

  def update
    if @grade.update_attributes(grade_params)
      flash[:success] = t('.success_updated')
      redirect_to grades_path
    else
      flash[:error] = @grade.errors.full_messages
      render :edit
    end
  end

  def destroy
    @grade.destroy
    flash[:success] = t('.success_deleted')
    redirect_to grades_path
  end

  def inscription_teachers
    @teachers = Grades::AvaliabityTeachersService.call(grade: @grade)
    respond_to do |format|
      format.js {}
    end
  end

  def add_teachers
    @teachers = User.where(role: 'teacher')
    if @grade.update_attributes(grade_params)
      flash[:success] = t('.add_teachers_successfully')
    else
      flash[:error] = @grade.erros.full_messages.join('')
    end
    redirect_to @grade
  end

  def inscription_students
    respond_to do |format|
      format.js {}
    end
  end

  def subscribe_student
    begin
      @student = User.find(params[:student_id])
      @grade.students << @student
      flash[:success] = t('.add_student_successfully')
    rescue ActiveRecord::RecordNotUnique => exception
      flash[:error] = t('.error_subscribe_student')
    end
    redirect_to @grade
  end

  def unsubscribe_student
    student = User.find(params[:student_id])
    if @grade.students.delete student
      flash[:success] = t('.unsubscribe_student')
    else
      flash[:error] = @grade.errors.full_messages
    end
    redirect_to @grade
  end

  private

  def grade_params
    params.require(:grade).permit(:code, :friday, :hour_end, :hour_start, :monday,
                                  :saturday, :sunday, :thursday, :tuesday, :wednesday, :year, :school_name,
                                  teacher_ids: [])
  end

  def find_grade
    @grade = Grade.find(params[:id])
  end
end
