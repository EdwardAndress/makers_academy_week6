require 'data_mapper'
require 'dm-postgres-adapter'
require './lib/data_mapper_setup'

task :auto_upgrade do
	DataMapper.auto_upgrade!
	puts "Auto-upgrade complete (no data loss)"
end

task :auto_migrate do
	DataMapper.auto_migrate!
	puts "Auto-migrate complete (it is possible that data was lost during this process)"
end