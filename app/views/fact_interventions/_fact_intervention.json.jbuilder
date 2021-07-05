json.extract! fact_intervention, :id, :EmployeeID, :BuildingID, :ColumnID, :ElevatorID, :Start_date, :End_date, :datetime, :Result, :Report, :Status, :created_at, :updated_at
json.url fact_intervention_url(fact_intervention, format: :json)
