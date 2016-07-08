class AddSlugToVacancies < ActiveRecord::Migration
  def change
    add_column :vacancies, :slug, :string, unique: true, after: :title
  end
end
