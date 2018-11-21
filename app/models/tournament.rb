class Tournament < ApplicationRecord
	has_many :rounds, dependent: :destroy
  has_many :teams, dependent: :destroy
  has_many :players, dependent: :destroy
  belongs_to :user
  enum mode: [:Round_Robin, :Swiss_System, :Elimination]
  enum kind: [:Individuals, :Teams]
  accepts_nested_attributes_for :teams, allow_destroy: true, reject_if: :all_blank
end
