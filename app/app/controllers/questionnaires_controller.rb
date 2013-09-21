require 'surveyor'
class QuestionnairesController < ApplicationController
  respond_to :html, :xml, :json

  def index
    @questionnaires = Questionnaire.all
    if !@questionnaires.empty?
      respond_with(@questionnaires)
    else
      render :empty
    end
  end

  def show
    @questionnaire = Questionnaire.find(params[:id])
    respond_with(@questionnaire)
  end

  def new
    @questionnaire = Questionnaire.new
    respond_with(@questionnaire)
  end

  def create
    @questionnaire = Questionnaire.new(params[:questionnaire])

    respond_with(@questionnaire) do |format|
      if @questionnaire.save
        flash[:notice] = 'Questionnaire was successfully created.'
        format.html { redirect_to @questionnaire }
        format.json { render json: @questionnaire, status: :created, location: @questionnaire }
      else
        flash[:error] = @questionnaire.errors
        format.html { render action: "new" }
        format.json { render json: @questionnaire.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @questionnaire = Questionnaire.find(params[:id])
    @questionnaire.destroy

    respond_with(@questionnaire)
  end

  def parse
    begin
      @questionnaire = Questionnaire.find(params[:questionnaire_id])
      ret = QuestionnaireServices.parse(@questionnaire)

      flash[:notice] = "Questionnaire was successfully parsed and updated."
    rescue Surveyor::ParserError => pe
      flash[:error] = ["Questionnaire was not successfully parsed.", pe.message]
    end

    render 'show'
  end
end
