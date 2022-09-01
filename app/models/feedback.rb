# frozen_string_literal: true

class Feedback < ActiveRecord::Base
  validates :owner, presence: true
  validates :comment, presence: true

  belongs_to :owner, class_name: 'User'
  belongs_to :feedbackable, polymorphic: true

  def check_existence
    Feedback.where(owner_id: owner_id, feedbackable_type: feedbackable_type, feedbackable_id: feedbackable_id)
            .where.not(id: nil).exists?
  end
end
