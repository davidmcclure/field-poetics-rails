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

  # Build the Google Fonts include.
  def google_fonts(fonts)
    fonts.each do |font|
      font = font.strip().gsub(/\s+/, "+")
    end
    fonts = fonts.join("|")
    tag('link', { :rel => :stylesheet, :type => Mime::CSS, :href => "http://fonts.googleapis.com/css?family=#{fonts}" }, false, false)
  end

end
