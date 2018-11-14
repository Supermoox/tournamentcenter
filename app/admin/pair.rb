ActiveAdmin.register Pair do
  permit_params :home, :away, :score_away, :score_home, :ended, :round_id
end