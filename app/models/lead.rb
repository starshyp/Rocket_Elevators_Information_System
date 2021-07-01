class Lead < ApplicationRecord
	has_one_attached :file

	before_create :migrate_to_dropbox # call migrate_to_dropbox after creating a customer
	#after_update :migrate_to_dropbox  # call migrate_to_dropbox after updating a customer
	
	#########################################################
	# The funstion attachement to dropbox,
	def migrate_to_dropbox   
		puts self.id
		dropbox_client = DropboxApi::Client.new(ENV["DROPBOX_TOKEN"])
		puts dropbox_client
		puts self.Email						  #delete later
		# lead = Lead.find_by(email: self.Email)
		# puts "lead"
		if self.file.attached?
			puts "*********************"
			puts self.AttachedFile
			puts "*********************"
			puts self.file.attached?
			puts "*********************"
			puts self.file
			puts "*********************"
			if self.file.attached? #<----check if the lead for attach file
				puts "enter"
				path = "/" + self.FullName #<----create a variable path that has the full name of the company contact
				
				begin
					puts "create_folder"
					dropbox_client.create_folder path
				rescue DropboxApi::Errors::FolderConflictError => err
					puts "The folder is not created since it already exists. just carry on with uploading the file"
				end

				begin
					dropbox_client.upload(path + "/" + self.file.filename.base + self.file.filename.extension_with_delimiter, self.file.download)
				rescue DropboxApi::Errors::FileConflictError => err
					puts "File already exists in the folder.do not upload anything."
					while true
						dupecounter = 1
						begin
							dropbox_client.upload(path + "/" + self.file.filename.base + dupecounter.to_s + self.file.filename.extension_with_delimiter, self.file.download)
							break
						rescue DropboxApi::Errors::FileConflictError => err
							dupecounter += 1
						end
					end
				end
			end
			self.AttachedFile = nil; #<----delete  attachement to avoid duplication
			self.file.purge
		end
	end
end