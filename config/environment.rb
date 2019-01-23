require 'bundler'
require 'require_all'
# require_all 'app'
# require 'active_record'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
require_all 'app'
