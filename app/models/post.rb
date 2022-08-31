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
    posts.each do |k,v|
      data << { 'title' => k[:title], 'content' => k[:content] }
    end

    data
  end
end
