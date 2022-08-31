# frozen_string_literal: true

class Rating < ActiveRecord::Base
  validates :post, presence: true
  validates :value, numericality: { in: 1..5 }

  belongs_to :post

  def self.avg
    Rating.average(:value).to_f.round(2)
  end
end
