require "application_system_test_case"

class FactInterventionsTest < ApplicationSystemTestCase
  setup do
    @fact_intervention = fact_interventions(:one)
  end

  test "visiting the index" do
    visit fact_interventions_url
    assert_selector "h1", text: "Fact Interventions"
  end

  test "creating a Fact intervention" do
    visit fact_interventions_url
    click_on "New Fact Intervention"

    fill_in "Buildingid", with: @fact_intervention.BuildingID
    fill_in "Columnid", with: @fact_intervention.ColumnID
    fill_in "Elevatorid", with: @fact_intervention.ElevatorID
    fill_in "Employeeid", with: @fact_intervention.EmployeeID
    fill_in "End date", with: @fact_intervention.End_date
    fill_in "Report", with: @fact_intervention.Report
    fill_in "Result", with: @fact_intervention.Result
    fill_in "Start date", with: @fact_intervention.Start_date
    fill_in "Status", with: @fact_intervention.Status
    fill_in "Datetime", with: @fact_intervention.datetime
    click_on "Create Fact intervention"

    assert_text "Fact intervention was successfully created"
    click_on "Back"
  end

  test "updating a Fact intervention" do
    visit fact_interventions_url
    click_on "Edit", match: :first

    fill_in "Buildingid", with: @fact_intervention.BuildingID
    fill_in "Columnid", with: @fact_intervention.ColumnID
    fill_in "Elevatorid", with: @fact_intervention.ElevatorID
    fill_in "Employeeid", with: @fact_intervention.EmployeeID
    fill_in "End date", with: @fact_intervention.End_date
    fill_in "Report", with: @fact_intervention.Report
    fill_in "Result", with: @fact_intervention.Result
    fill_in "Start date", with: @fact_intervention.Start_date
    fill_in "Status", with: @fact_intervention.Status
    fill_in "Datetime", with: @fact_intervention.datetime
    click_on "Update Fact intervention"

    assert_text "Fact intervention was successfully updated"
    click_on "Back"
  end

  test "destroying a Fact intervention" do
    visit fact_interventions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Fact intervention was successfully destroyed"
  end
end
