# frozen_string_literal: true

require 'hanami/router'
require_relative 'config/environment'

app = Hanami::Router.new do
  get '/posts', to: PostsController.new('index')
  post '/posts',                to: PostsController.new('create')
  post '/posts/:id/ratings',    to: PostsController.new('create_rating')
  get '/ip_addresses',          to: IpsController.new('index')
  post '/feedbacks',            to: FeedbacksController.new('create')
end

use Rack::Reloader, 0
run app
