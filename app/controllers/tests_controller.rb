# Instituto Tecnologico de Costa Rica
# Curso: Introduccion al desarrollo de aplicaciones para web
# IV Tarea Programada
# Ruby on Rails/ Bootstrap/ TDD y BDD
# Profesor: Erick Hernandez
# Estudiantes:
#     - Daniel Solis Mendez / 2013099996
#     - Melvin Elizondo Perez / 2013099997
# I Semestre 2015

class TestsController < ApplicationController
  before_action :set_test, only: [:show, :edit, :update, :destroy,:score]

  respond_to :html

  def index
    @tests = Test.all
    respond_with(@tests)
  end

  def show
    @questions = @test.questions
    respond_with(@test)
  end

  def new
    @test = Test.new
    respond_with(@test)
  end

  def edit
  end

  def create
    @test = Test.new(test_params)
    @test.save
    render layout:false,text:@test.id
  end

  def update
    @test.update(test_params)
    render layout:false, text:"Success"
  end

  def destroy
    @test.destroy
    respond_with(@test)
  end


  def score
    # Array with user answers
    user_answers = params[:answers]

    questions = @test.questions
    total_questions = @test.questions_amount
    rights = 0

    # To compare user answers with right answers
    user_answers.zip(questions).each do |u_answer,question|
      rights += 1 if u_answer == question.right_answer
    end

    score = (rights*100) / total_questions
    render layout:false, text: score
  end



  private
    def set_test
      @test = Test.find(params[:id])
    end

    def test_params
      params.require(:test).permit(:name, :description, :begins_at, :ends_at,:user_id,:questions_amount)
    end
end
