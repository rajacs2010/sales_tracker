class CreateSaleData < ActiveRecord::Migration
  def change
    create_table :sale_data do |t|

      t.timestamps
    end
  end
end
