class CreatePlannedRoutes < ActiveRecord::Migration
  def change
    create_table :planned_routes do |t|

      t.timestamps
    end
  end
end
