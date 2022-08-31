# frozen_string_literal: true

class Rating < ActiveRecord::Base
  validates :value, presence: true, numericality: { in: 1..5 }

  belongs_to :post
end
