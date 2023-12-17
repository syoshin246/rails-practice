class Board < ApplicationRecord
  validates :title, presence: true, length: { minimum: 1}
  validates :title2, presence: true, length: { minimum: 1}
end