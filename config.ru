# frozen_string_literal: true

require 'hanami/router'
require_relative 'config/environment'

app = Hanami::Router.new do
    root                to: ->(env) { [200, {}, ['Hello World!']] }
    get '/lambda',      to: ->(env) { [200, {}, ['hello lambda!!!']] }
    get '/posts',       to: PostsController.new('index')
end

use Rack::Reloader, 0
run app