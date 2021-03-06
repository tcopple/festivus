class QuestionnaireInstancesController < ApplicationController
  respond_to :html, :xml, :json

  def index
    @instances = QuestionnaireInstance.all.group_by(&:event)

    if !@instances.empty?
      respond_with(@instances)
    else
      render :empty
    end
  end

  def show
    @instance = QuestionnaireInstance.find(params[:id])
    @questionnaire = @instance.questionnaire #questionnaire as defined by us
    @response_set = @instance.response_set
    @survey = @response_set.survey #questionnaire or survey as defined by surveyor gem
    respond_with(@instance)
  end

  def new
    @instance = QuestionnaireInstance.new

    @questionnaires = Questionnaire.where(user_id: current_user)
    @events = Event.where(user_id: current_user)
    @contacts = Contact.where(user_id: current_user)
  end

  def create
    @questionnaire = Questionnaire.find(params[:questionnaire_instance][:questionnaire_id])

    datetime = DateTime.new(2013, 5, 1) #DateTime.strptime(params[:questionnaire_instance][:due_date], "%m/%d/%Y")
    p = params[:questionnaire_instance].merge({ due_date: datetime})
    @questionnaire_instance = QuestionnaireInstance.new(p)
    @questionnaire_instance.user = current_user

    @questionnaire_instance.response_set = QuestionnaireServices.create_surveyor_instance(@questionnaire, @questionnaire_instance)

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

    if QuestionnaireInstanceServices.send_reminder(@instance)
      flash[:notice] = "Reminder successfully sent to #{@instance.email}"
    else
      flash[:error] = "Reminder was not sent to #{@instance.email}"
    end

    redirect_to instances_path
  end
end
