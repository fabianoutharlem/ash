class AddCarToAppointmentRequests < ActiveRecord::Migration
  def change
    add_reference :appointment_requests, :car, after: :comment
  end
end
