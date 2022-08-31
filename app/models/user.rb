# frozen_string_literal: true

class User < ActiveRecord::Base
  extend ActiveSupport::Concern

  CLASS_MAPPING = {
    'user' => self
  }

  has_many :posts, dependent: :destroy
  has_many :my_feedbacks, foreign_key: 'owner_id', class_name: 'Feedback', dependent: :destroy
  has_many :feedbacks, as: :feedbackable, dependent: :destroy

  def self.polymorphic_name
    CLASS_MAPPING.invert.fetch(self)
  end

  def self.polymorphic_class_for(name)
    CLASS_MAPPING[name]
  end
end
