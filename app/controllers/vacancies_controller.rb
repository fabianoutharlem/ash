class VacanciesController < ApplicationController

  add_breadcrumb 'Vacatures', :vacancies_path

  def index
    @vacancies = Vacancy.all
  end

  def show
    @vacancy = Vacancy.find(params[:id])
    add_breadcrumb @vacancy.title
  end

end