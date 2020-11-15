class Tweet < ActiveRecord::Base
  include ActiveModel::Validations
  belongs_to :user

  validates :user, presence: true
  validates :content, presence: true
end
