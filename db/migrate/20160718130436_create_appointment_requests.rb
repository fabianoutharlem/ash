class CreateAppointmentRequests < ActiveRecord::Migration
  def change
    create_table :appointment_requests do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.text :comment

      t.timestamps null: false
    end
  end
end
