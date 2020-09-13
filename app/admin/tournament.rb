ActiveAdmin.register Tournament do
  permit_params :name, :mode, :publish, :completed, teams_attributes: [:id, :_destroy, :name, :points, :host, :seeded,  :tournament_id]
end