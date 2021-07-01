class AddressGeocode < ApplicationRecord

	# EXAMPLE AddressGeocode.fromAddress("3512 40 Ave NW")
	# this caches geocode from addresses
	def self.fromAddress(address)
		addresses = AddressGeocode.where(address: address)
		if addresses.present? then
			return [addresses.first.latitude,addresses.first.longtitude]
		else
			results = Geocoder.search(address)
			if results.present? then
				newaddress = AddressGeocode.new()
				newaddress.address = address
				newaddress.latitude = results.first.coordinates[0]
				newaddress.longtitude = results.first.coordinates[1]
				newaddress.save
				return results.first.coordinates
			end
		end
	end
end
