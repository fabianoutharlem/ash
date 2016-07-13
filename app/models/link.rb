class Link < ActiveRecord::Base

  def menu_item_properties
    [
        self.title,
        {class: self.class.name, id: self.id}.to_json
    ]
  end

  def route
    self.url
  end

end
