class CreateCarSaleRequests < ActiveRecord::Migration
  def change
    create_table :car_sale_requests do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :license_plate
      t.string :mileage
      t.text :message

      t.timestamps null: false
    end
  end
end
