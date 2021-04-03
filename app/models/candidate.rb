class Candidate < ApplicationRecord
  # 做驗證
  validates :name, presence: true
  has_many :vote_logs
end
