class CreateEmployeeRoles < ActiveRecord::Migration
  def change
    create_table :employee_roles do |t|

      t.timestamps
    end
  end
end
