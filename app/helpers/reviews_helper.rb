module ReviewsHelper

  def star_rating(rating)
    html = ''
    rating.floor.times do
      html += content_tag :div, nil, class: 'star stars'
    end
    if rating % 1 >= 0.5
      html += content_tag :div, nil, class: 'half_star stars'
    end
    (5 - rating.ceil).times do
      html += content_tag :div, nil, class: 'empty_star stars'
    end
    return html.html_safe
  end

end