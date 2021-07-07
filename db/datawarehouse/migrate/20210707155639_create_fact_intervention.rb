class CreateFactIntervention < ActiveRecord::Migration[5.2]
  def change
    create_table :fact_interventions do |t|
      t.integer :EmployeeID
      t.integer :BuildingID
      t.integer :ColumnID
      t.integer :ElevatorID
      t.datetime :Start_date
      t.string :End_date
      t.string :datetime
      t.string :Result
      t.string :Report
      t.string :Status
    end
  end
end
