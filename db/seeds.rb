# frozen_string_literal: true

require 'faker'
require_relative '../app/models/user'
require_relative '../app/models/Post'
require_relative '../app/models/feedback'

users_count = 100
ip_addresses_count = 50
posts_count = 200_000
post_feedbacks_count = 10_000
user_feedbacks_count = 50
feedbacks_count = post_feedbacks_count + user_feedbacks_count
time = Time.now

puts "Creating #{users_count} Users..."
users = []
users_count.times do
  users.push({ username: Faker::Internet.unique.username, created_at: time, updated_at: time })
end
User.insert_all(users)
users = User.select(:id).pluck(:id)

puts "Preparing #{ip_addresses_count} different IPs..."
ip_addresses = []
ip_addresses_count.times do
  ip_addresses.push(Faker::Internet.unique.ip_v4_address)
end

puts "Creating #{posts_count} Posts..."
posts = []
posts_count.times do
  posts.push({
    user_id: users.sample,
    title: Faker::Restaurant.name,
    content: Faker::Restaurant.description,
    ip_address: ip_addresses.sample,
    created_at: time,
    updated_at: time
  })
end
Post.insert_all(posts)
posts = Post.select(:id).pluck(:id)

puts "Creating #{feedbacks_count} Feedbacks..."
feedbacks = []
post_feedbacks_count.times do
  feedbacks.push({
    owner_id: users.sample,
    feedbackable_id: posts.sample,
    feedbackable_type: 'Post',
    comment: Faker::Restaurant.review,
    created_at: time,
    updated_at: time
  })
end

user_feedbacks_count.times do
  feedbacks.push({
    owner_id: users.sample,
    feedbackable_id: users.sample,
    feedbackable_type: 'User',
    comment: Faker::Restaurant.review,
    created_at: time,
    updated_at: time
  })
end

Feedback.insert_all(feedbacks)