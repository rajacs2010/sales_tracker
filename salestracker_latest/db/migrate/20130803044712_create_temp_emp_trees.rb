class CreateTempEmpTrees < ActiveRecord::Migration
  def change
    create_table :temp_emp_trees do |t|

      t.timestamps
    end
  end
end
