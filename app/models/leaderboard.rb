class Leaderboard < ActiveRecord::Base
  validates :username, presence: true
  validates :game_session_id, presence: true
  validates :duration, presence: true
  validates :level, presence: true
end
