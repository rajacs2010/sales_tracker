class CreateCustomerDetails < ActiveRecord::Migration
  def change
    create_table :customer_details do |t|

      t.timestamps
    end
  end
end
