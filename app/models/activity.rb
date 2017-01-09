class Activity < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :action_type, presence: true
  validates :type_id, presence: true

  delegate :name, to: :user, prefix: :user, allow_nil: true

  enum activity_types: {follow: 0, unfollow: 1, start_lesson: 2}

  scope :recent, ->{order "created_at DESC"}
  scope :user_activities, ->user do
    where "user_id = :user_id OR user_id IN (SELECT followed_id
      FROM relationships WHERE follower_id = :user_id)", user_id: user.id
  end
end
