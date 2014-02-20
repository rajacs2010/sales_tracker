class CreateKdDetails < ActiveRecord::Migration
  def change
    create_table :kd_details do |t|

      t.timestamps
    end
  end
end
