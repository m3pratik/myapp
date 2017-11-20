class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.string :area
      t.datetime :join_date
      t.string :address
      t.string :mobile_number
      t.string :plan
      t.integer :total_month

      t.timestamps
    end
  end
end
