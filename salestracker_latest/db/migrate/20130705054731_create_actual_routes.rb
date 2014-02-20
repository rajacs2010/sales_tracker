class CreateActualRoutes < ActiveRecord::Migration
  def change
    create_table :actual_routes do |t|

      t.timestamps
    end
  end
end
