require 'rails_helper'

RSpec.describe GradesController, type: :controller do
  describe 'GET #index' do
    it 'assigns @grades' do
      grade = create(:grade)
      get :index
      expect(assigns(:grades)).to eq([grade])
    end
  end

  describe 'GET #new' do
    it 'have status 200' do
      get :new
      expect(response).to have_http_status(200)
    end
    it 'assigns new @grade' do
      get :new
      expect(assigns(:grade)).to be_a_new Grade
    end
  end

  describe 'POST #create' do
    let(:attributes_grade) { attributes_for(:grade) }

    it 'save grade' do
      expect do
        post :create, params: { grade: attributes_grade }
      end.to change(Grade, :count).by(1)
    end

    it 'redirect index grade' do
      post :create, params: { grade: attributes_grade }
      expect(response).to redirect_to(grades_path)
    end

    it 'render new' do
      post :create, params: { grade: attributes_grade.merge(code: nil) }
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #edit' do
    let(:grade) { create(:grade) }

    it 'when edit' do
      get :edit, params: { id: grade.id }
      expect(response).to have_http_status(200)
    end

    it 'render template' do
      get :edit, params: { id: grade.id }
      expect(response).to render_template :edit
    end

    it 'assigns @grade' do
      get :edit, params: { id: grade.id }
      expect(assigns(:grade)).to eq grade
    end
  end

  describe 'PATCH #update' do
    let(:grade_params) do
      { code: 'AAA' }
    end

    let(:grade) { create(:grade) }

    it 'update code' do
      patch :update, params: { id: grade.id, grade: grade_params }
      expect(grade.reload.code).to eq('AAA')
      expect(response).to redirect_to(grades_path)
    end

    it 'code is nil' do
      grade_params[:code] = nil
      patch :update, params: { id: grade.id, grade: grade_params }
      expect(response).to render_template(:edit)
    end
  end

  describe 'DELETE #destroy' do
    let(:grade) { create(:grade) }
    it 'delete the grade' do
      expect do
        delete :destroy, params: { id: grade.id }
      end.to change(Grade, :count).by(0)
    end

    it 'redirect index grade' do
      delete :destroy, params: { id: grade.id }
      expect(response).to redirect_to(grades_path)
    end
  end

  describe 'GET #show' do
    let(:grade) { create(:grade) }

    it 'when access page' do
      get :show, params: { id: grade.id }
      expect(response).to have_http_status(200)
    end

    it 'render show' do
      get :show, params: { id: grade.id }
      expect(response).to render_template(:show)
    end

    it 'assigns @grade' do
      get :show, params: { id: grade.id }
      expect(assigns(:grade)).to eq grade
    end
  end

  describe 'GET #inscription_teachers' do
    let(:grade) { create(:grade) }
    it 'render template js' do
      get :inscription_teachers, params: { id: grade.id }, xhr: true, format: :js
      expect(response).to render_template(:inscription_teachers)
    end

    it 'assigns teachers' do
      teachers = create_list(:user, 5, :teacher)
      get :inscription_teachers, params: { id: grade.id }, xhr: true, format: :js
      expect(assigns(:teachers)).to eq(teachers)
    end
  end

  describe 'POST #add_teachers' do
    let(:grade) { create(:grade) }
    let(:teachers) { create_list(:user, 4, :teacher) }
    let(:params_grade) { grade.attributes.merge(teacher_ids: teachers.pluck(:id)) }
    it 'assigns teachers' do
      post :add_teachers, params: { id: grade.id, grade: params_grade }
      expect(grade.teachers).to eq(teachers)
    end
  end

  describe 'GET #inscription_students' do
    let(:grade) { create(:grade) }

    it 'render template js' do
      get :inscription_students, params: { id: grade.id }, xhr: true, format: :js
      expect(response).to render_template(:inscription_students)
    end
  end

  describe 'POST #subscribe_student' do
    let(:grade) { create(:grade) }
    let(:student) { create(:user) }
    it 'assigns student' do
      post :subscribe_student, params: { id: grade.id, student_id: student.id }
      expect(assigns(:grade).students).to eq([student])
    end

    it 'redirect to grade' do
      post :subscribe_student, params: { id: grade.id, student_id: student.id }
      expect(response).to redirect_to(grade)
    end

    it 'when raise error' do
      grade.students << student
      post :subscribe_student, params: { id: grade.id, student_id: student.id }
      expect(flash[:error]).to eq(I18n.t('.grades.subscribe_student.error_subscribe_student'))
    end
  end

  describe 'POST #unsubscribe_student' do
    let(:grade) { create(:grade) }
    let(:student) { create(:user) }

    it 'return zero students' do
      grade.students << student
      get :unsubscribe_student, params: { id: grade.id, student_id: student.id }
      expect(grade.students.size).to eq(0)
    end
  end
end
