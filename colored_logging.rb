module ColoredLogging
    
  STYLES = { :normal => 0, :bold => 1, :underscore => 4, :blink => 5, :inverse => 7, :concealed => 8 }
  COLORS = { :black  => 0, :blue => 4, :green => 2, :cyan => 6, :red => 1, :purple => 5, :yellow => 3, :white => 7 }

  def colorize(text, *options)

    font_style       = ''
    foreground_color = '0'
    background_color = ''
  
    options.each do |option|
      if option.kind_of?(Symbol)
        foreground_color = "3#{COLORS[option]}" if COLORS.include?(option)
        font_style       = "#{STYLES[option]};" if STYLES.include?(option)          
      elsif option.kind_of?(Hash)
        options.each do |key, value|
          case key
          when :color;      foreground_color = "3#{COLORS[value]}"  if COLORS.include?(value)
          when :background; background_color = "4#{COLORS[value]};" if COLORS.include?(value)
          when :on;         background_color = "4#{COLORS[value]};" if COLORS.include?(value)
          when :style;      font_style       = "#{STYLES[value]};"  if STYLES.include?(value)
          end
        end
      end
    end
    return "\e[#{background_color}#{font_style}#{foreground_color}m#{text}\e[0m"
  end

end
