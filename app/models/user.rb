class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token
  before_save   :downcase_email
  before_create :create_activation_digest
  has_many :lessons, dependent: :destroy
  has_many :activities, dependent: :destroy

  has_many :active_relationships,  class_name:  Relationship.name,
    foreign_key: :follower_id,
    dependent:   :destroy
  has_many :passive_relationships, class_name:  Relationship.name,
    foreign_key: :followed_id,
    dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  validates :name, presence: true, length: {maximum:
    Settings.user.name.maximum_length}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum:
    Settings.user.email.maximum_length},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum:
    Settings.user.password.minimum_length}

  def forget
    update_attribute :remember_digest, nil
  end

  def follow other_user
    active_relationships.create followed_id: other_user.id
  end

  def unfollow other_user
    relationship = active_relationships.find_by followed_id: other_user.id
    if relationship
      relationship.destroy
    else
      false
    end
  end

  def following? other_user
    following.include? other_user
  end

   def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::
      MIN_COST : BCrypt::Engine::cost
    BCrypt::Password.create(string, cost: cost)
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  private
  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
