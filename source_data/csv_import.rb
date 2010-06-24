parsed_file = CSV::Reader.parse(File.open('athfest.csv', 'rb')) do |row|
	# Build some models here, export some SQL or something
	# See this file: http://satishchauhan.wordpress.com/2007/07/18/how-to-import-csv-file-in-rails/
end
