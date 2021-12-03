class CreateJoinTableUserGrade < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :grades do |t|
      t.index [:user_id, :grade_id], unique: true
      t.index [:grade_id, :user_id], unique: true
    end
  end
end
