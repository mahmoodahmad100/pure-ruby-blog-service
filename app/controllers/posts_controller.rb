# frozen_string_literal: true

class PostsController < BaseController
    def index
    end

    def create
        user = User.find_or_create_by(username: user_params['username'])

        unless user.save
            return send_error_response(user.errors.full_messages)
        end

        post = user.posts.create(post_params)

        if post.save
            send_response(post)
        else
            send_error_response(post.errors.full_messages)
        end
    end

    def user_params
        params['user']
    end

    def post_params
        params['post']
    end
end