class Tournament < ApplicationRecord
	has_many :rounds, dependent: :destroy
  has_many :teams, dependent: :destroy
  has_many :players, dependent: :destroy
  belongs_to :user
  enum mode: [:Round_Robin, :Swiss_System, :Elimination]
  enum kind: [:Individuals, :Teams]
  enum rounds_num: [:Default, :Five, :Nine ]
  accepts_nested_attributes_for :teams, allow_destroy: true, reject_if: :all_blank
  after_update :update_pairs

  has_attached_file :image,
   styles: { small: "60x60", medium: "100x100", large: "200x200" }
   validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]


  private

  def update_pairs
    @id = self.id
    @rounds = Round.where(tournament_id: @id )
    @teams = Team.where(tournament_id: @id )

    @rounds.each do |round|
      round.pairs.each do |pair|
        @teams.each do |team|
          if pair.home == team.id
            pair.update(home_team: team.name)
            @updated = true
          elsif pair.away == team.id
            pair.update(away_team: team.name)
            @updated = true
          end
        end
      end
    end
  end
end

