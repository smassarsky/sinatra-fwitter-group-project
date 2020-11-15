class User < ActiveRecord::Base
  include ActiveModel::Validations
  has_secure_password
  has_many :tweets

  validates :username, presence: true
  validates :email, presence: true

  def slug
    self.username.split(" ").map{|word| word.sub(/\W/, "")}.join("-").downcase
  end

  def self.find_by_slug(slug)
    self.all.find{|user| user.slug == slug}
  end

end
