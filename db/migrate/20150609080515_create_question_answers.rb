class CreateQuestionAnswers < ActiveRecord::Migration
  def change
    create_table :question_answers do |t|
      t.string :choice
      t.belongs_to :test_answer
      t.integer :question_number, index: true
      t.timestamps
    end
  end
end