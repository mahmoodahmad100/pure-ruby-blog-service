# frozen_string_literal: true

class Post < ActiveRecord::Base
  extend ActiveSupport::Concern

  CLASS_MAPPING = {
    'post' => self
  }

  validates :title, presence: true
  validates :content, presence: true
  validates :ip_address, presence: true

  belongs_to :user
  has_many :ratings, dependent: :destroy
  has_many :feedbacks, as: :feedbackable, dependent: :destroy

  def self.polymorphic_name
    CLASS_MAPPING.invert.fetch(self)
  end

  def self.polymorphic_class_for(name)
    CLASS_MAPPING[name]
  end

  def avg_ratings
    ratings.average(:value).to_f.round(2)
  end

  def self.top_rated_posts(pagination = nil)
    pagination ||= 50
    posts = self.joins(:ratings)
                .select('title, content')
                .group('title')
                .order('avg(ratings.value) DESC')
                .limit(pagination)

    data = []
    posts.each do |v|
      data << { 'title' => v[:title], 'content' => v[:content] }
    end

    data
  end

  # TODO improve the below as the response time is 500ms (AVG) (for ex: use Redis to cache the result)
  def self.ip_addresses_info()
    ips = self.joins(:user)
              .select('users.id, users.username, posts.ip_address as ip')
              .group('users.id, ip')

    data = []
    ips.each do |v|
      data << { 'ip' => v[:ip], 'author' => { id: v[:id], username: v[:username] } }
    end

    data
  end
end
