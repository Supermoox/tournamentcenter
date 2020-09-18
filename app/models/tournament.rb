class Tournament < ApplicationRecord
	has_many :rounds, dependent: :destroy
  has_many :teams, dependent: :destroy
  has_many :players, dependent: :destroy
  belongs_to :user
  enum mode: [:Round_Robin, :Swiss_System, :Elimination]
  enum kind: [:Individuals, :Teams]
  enum rounds_num: [:Default, :Five, :Nine ]
  accepts_nested_attributes_for :teams, allow_destroy: true, reject_if: :all_blank


  has_attached_file :image,
   styles: { small: "60x60", medium: "100x100", large: "200x200" }
   validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

end

