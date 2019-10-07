# frozen_string_literal: true

class AverageCache < ApplicationRecord
  belongs_to :rater, class_name: 'User'
  belongs_to :rateable, polymorphic: true
end
