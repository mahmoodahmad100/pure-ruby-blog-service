# frozen_string_literal: true

require 'bundler'
require 'dotenv/load'
require 'active_record'
require 'yaml'
require 'erb'

$LOAD_PATH.push File.dirname(__dir__)
Bundler.require(:default, ENV['APP_ENV'])

def db_configuration
    db_configuration_file_path = File.join(File.expand_path('..', __dir__), 'db', 'config.yml')
    db_configuration_result = ERB.new(File.read(db_configuration_file_path)).result
    YAML.safe_load(db_configuration_result, aliases: true)
end

ActiveRecord::Base.establish_connection(db_configuration[ENV['APP_ENV']])

# Loading Models
require 'app/models/user'
require 'app/models/post'
require 'app/models/rating'
require 'app/models/feedback'

# Loading Controllers
require 'app/controllers/base_controller'
require 'app/controllers/posts_controller'
require 'app/controllers/ips_controller'