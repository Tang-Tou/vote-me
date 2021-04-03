class Candidate < ApplicationRecord
  # 做驗證
  validates :name, presence: true
end
