module ApplicationHelper

  # Construct the title.
  def title
    base_title = "Field Poetics"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

end
