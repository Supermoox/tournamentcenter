ActiveAdmin.register Team do
  permit_params :name, :points, :tournament_id, :wins, :played, :lost, :allowed, :forced, :draws, :playing, :num, :host, :seeded
end