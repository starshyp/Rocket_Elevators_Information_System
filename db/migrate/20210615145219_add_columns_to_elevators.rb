class AddColumnsToElevators < ActiveRecord::Migration[5.2]
  def change
    add_reference :elevators, :columns, foreign_key: true
  end
end
