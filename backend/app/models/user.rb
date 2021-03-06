# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :points, dependent: :nullify
  has_many :routes, dependent: :nullify
  has_many :events_users, dependent: :destroy
  has_many :events, through: :events_users
  has_many :comments, dependent: :destroy

  has_one_attached :avatar

  enum role: { user: 0, admin: 1 }

  ratyrate_rater
end
