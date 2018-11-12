class Tournament < ApplicationRecord
	has_many :rounds, dependent: :destroy
  has_many :teams, dependent: :destroy
  belongs_to :user
  enum mode: [:Round_Robin, :Swiss_System, :Elimination]
  accepts_nested_attributes_for :teams, allow_destroy: true, reject_if: :all_blank
end
