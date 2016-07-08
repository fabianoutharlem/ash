class CreateVacancies < ActiveRecord::Migration
  def change
    create_table :vacancies do |t|
      t.string :title
      t.string :sub_title
      t.text :description

      t.timestamps null: false
    end
  end
end
