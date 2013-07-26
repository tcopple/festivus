require 'test_helper'

class QuestionnaireInstancesControllerTest < ActionController::TestCase
  setup do
    @questionnaire_instance = questionnaire_instances(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:questionnaire_instances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create questionnaire_instance" do
    assert_difference('QuestionnaireInstance.count') do
      post :create, questionnaire_instance: { due_date: @questionnaire_instance.due_date, email: @questionnaire_instance.email, name: @questionnaire_instance.name, notification_count: @questionnaire_instance.notification_count }
    end

    assert_redirected_to questionnaire_instance_path(assigns(:questionnaire_instance))
  end

  test "should show questionnaire_instance" do
    get :show, id: @questionnaire_instance
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @questionnaire_instance
    assert_response :success
  end

  test "should update questionnaire_instance" do
    put :update, id: @questionnaire_instance, questionnaire_instance: { due_date: @questionnaire_instance.due_date, email: @questionnaire_instance.email, name: @questionnaire_instance.name, notification_count: @questionnaire_instance.notification_count }
    assert_redirected_to questionnaire_instance_path(assigns(:questionnaire_instance))
  end

  test "should destroy questionnaire_instance" do
    assert_difference('QuestionnaireInstance.count', -1) do
      delete :destroy, id: @questionnaire_instance
    end

    assert_redirected_to questionnaire_instances_path
  end
end
