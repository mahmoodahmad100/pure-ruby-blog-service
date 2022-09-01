# frozen_string_literal: true

require 'dotenv/load'
require 'active_record'
require 'standalone_migrations'

ENV['SCHEMA'] = File.join(ActiveRecord::Tasks::DatabaseTasks.db_dir, 'schema.rb')
StandaloneMigrations::Tasks.load_tasks
