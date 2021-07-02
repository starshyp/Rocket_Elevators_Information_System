class CreateAddressGeocode < ActiveRecord::Migration[5.2]
  def change
    create_table :address_geocodes do |t|
      t.string :address
      t.float :latitude
      t.float :longtitude
    end
  end
end
