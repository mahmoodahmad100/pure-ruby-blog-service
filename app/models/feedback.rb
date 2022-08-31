# frozen_string_literal: true

class Feedback < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  belongs_to :feedbackable, polymorphic: true
end
