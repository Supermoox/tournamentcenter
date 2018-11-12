ActiveAdmin.register Tournament do
  permit_params :name, :mode, teams_attributes: [:id, :_destroy, :name, :points, :host, :seeded, :completed, :tournament_id]
end