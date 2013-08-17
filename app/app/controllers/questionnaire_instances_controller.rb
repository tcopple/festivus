class QuestionnaireInstancesController < ApplicationController
  respond_to :html, :xml, :json

  def index
    @instances = QuestionnaireInstance.all
    if !@instances.empty?
      respond_with(@instances)
    else
      render :empty
    end
  end

  def show
    @questionnaire_instance = QuestionnaireInstance.find(params[:id])
    respond_with(@questionnaire_instance)
  end

  def new
    @questionnaire = Questionnaire.find(params[:questionnaire_id])
    @questionnaire_instance = @questionnaire.questionnaire_instances.build
  end

  def create
    @questionnaire = Questionnaire.find(params[:questionnaire_id])

    datetime = DateTime.strptime(params[:questionnaire_instance][:due_date], "%m/%d/%Y")
    p = params[:questionnaire_instance].merge({ due_date: datetime})
    @questionnaire_instance = @questionnaire.questionnaire_instances.build(p)

    respond_with(@questionnaire_instance) do |format|
      if @questionnaire_instance.save
        flash[:notice] = 'Questionnaire instance was successfully created.'
        format.html { redirect_to instances_path }
        format.json { render json: instances_path, status: :created, location: @questionnaire_instance }
      else
        format.html { render action: "new" }
        format.json { render json: @questionnaire_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @questionnaire_instance = QuestionnaireInstance.find(params[:id])
    @questionnaire_instance.destroy
    flash[:notice] = 'Questionnaire Instance was successfully removed.'
    redirect_to instances_path
  end

  def remind
    @instance = QuestionnaireInstance.find(params[:id])
    QuestionnaireInstanceServices.send_reminder(@instance)

    render 'index'
  end
end
