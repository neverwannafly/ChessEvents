class User < ApplicationRecord
  has_secure_password
  has_many :ratings, class_name: '::Ratings::User', foreign_key: :owner_id

  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
  validates :username, presence: true, uniqueness: true, format: { with: /\A[a-z][a-z0-9_]*\z/, message: 'Invalid username' }

  def games
    Game.where(black_player_id: self.id).or.where(white_player_id: self.id)
  end
end
