# frozen_string_literal: true

require 'bundler'

$LOAD_PATH.push File.dirname(__dir__)
Bundler.require(:default, ENV['APP_ENV'])