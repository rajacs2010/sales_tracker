class CreateBranchDetails < ActiveRecord::Migration
  def change
    create_table :branch_details do |t|

      t.timestamps
    end
  end
end
