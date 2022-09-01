# frozen_string_literal: true

class PostsController < BaseController
  def index
    send_response(Post.top_rated_posts(params['pagination'] || nil))
  end

  def create
    user = User.find_or_create_by(username: user_params['username'])

    return send_error_response(user.errors.full_messages) unless user.save

    post = user.posts.create(post_params)

    if post.save
      send_response(post)
    else
      send_error_response(post.errors.full_messages)
    end
  end

  def create_rating
    post = Post.find(router_params[:id])
    rating = post.ratings.create(rating_params)

    if rating.save
      send_response({ average: post.avg_ratings })
    else
      send_error_response(rating.errors.full_messages)
    end
  end

  def user_params
    params['user']
  end

  def post_params
    params['post']
  end

  def rating_params
    params['rating']
  end
end
