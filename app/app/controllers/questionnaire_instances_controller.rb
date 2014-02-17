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
    @surveyor_response_set = QuestionnaireInstanceServices.get_surveyor_response_set(@questionnaire_instance)
    @surveyor_survey = QuestionnaireServices.get_surveyor_survey(@questionnaire)
    respond_with(@questionnaire_instance)
  end

  def new
    @instance = QuestionnaireInstance.new

    @questionnaires = Questionnaire.where(user_id: current_user)
    @events = Event.where(user_id: current_user)
    @contacts = Contact.where(user_id: current_user)
  end

  def create

    @questionnaire = Questionnaire.find(params[:questionnaire_id])

    datetime = DateTime.strptime(params[:questionnaire_instance][:due_date], "%m/%d/%Y")
    p = params[:questionnaire_instance].merge({ due_date: datetime})
    @questionnaire_instance = @questionnaire.questionnaire_instances.build(p)

    ret = QuestionnaireServices.create_surveyor_instance @questionnaire, @questionnaire_instance

    respond_with(@questionnaire_instance) do |format|
      if @questionnaire_instance.save && ret
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

    if QuestionnaireInstanceServices.send_reminder(@instance)
      flash[:notice] = "Reminder successfully sent to #{@instance.email}"
    else
      flash[:error] = "Reminder was not sent to #{@instance.email}"
    end

    redirect_to instances_path
  end
end
