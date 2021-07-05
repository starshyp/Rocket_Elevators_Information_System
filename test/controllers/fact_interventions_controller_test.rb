require 'test_helper'

class FactInterventionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fact_intervention = fact_interventions(:one)
  end

  test "should get index" do
    get fact_interventions_url
    assert_response :success
  end

  test "should get new" do
    get new_fact_intervention_url
    assert_response :success
  end

  test "should create fact_intervention" do
    assert_difference('FactIntervention.count') do
      post fact_interventions_url, params: { fact_intervention: { BuildingID: @fact_intervention.BuildingID, ColumnID: @fact_intervention.ColumnID, ElevatorID: @fact_intervention.ElevatorID, EmployeeID: @fact_intervention.EmployeeID, End_date: @fact_intervention.End_date, Report: @fact_intervention.Report, Result: @fact_intervention.Result, Start_date: @fact_intervention.Start_date, Status: @fact_intervention.Status, datetime: @fact_intervention.datetime } }
    end

    assert_redirected_to fact_intervention_url(FactIntervention.last)
  end

  test "should show fact_intervention" do
    get fact_intervention_url(@fact_intervention)
    assert_response :success
  end

  test "should get edit" do
    get edit_fact_intervention_url(@fact_intervention)
    assert_response :success
  end

  test "should update fact_intervention" do
    patch fact_intervention_url(@fact_intervention), params: { fact_intervention: { BuildingID: @fact_intervention.BuildingID, ColumnID: @fact_intervention.ColumnID, ElevatorID: @fact_intervention.ElevatorID, EmployeeID: @fact_intervention.EmployeeID, End_date: @fact_intervention.End_date, Report: @fact_intervention.Report, Result: @fact_intervention.Result, Start_date: @fact_intervention.Start_date, Status: @fact_intervention.Status, datetime: @fact_intervention.datetime } }
    assert_redirected_to fact_intervention_url(@fact_intervention)
  end

  test "should destroy fact_intervention" do
    assert_difference('FactIntervention.count', -1) do
      delete fact_intervention_url(@fact_intervention)
    end

    assert_redirected_to fact_interventions_url
  end
end
