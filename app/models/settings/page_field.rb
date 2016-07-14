class Settings::PageField < Setting

  belongs_to :page, foreign_key: :value

  def display_value
    self.page.try(:title)
  end

  def partial_name
    'page_field'
  end

  def template_value
    self.page
  end

end